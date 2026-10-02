# Implementation Specification

## 1. Canonical database

Use existing PostgreSQL database:

`personal_platform`

Create schema:

`proactive`

Do not introduce SQLite for canonical state.

## 2. Required tables

- `proactive.events`
- `proactive.candidates`
- `proactive.goals`
- `proactive.goal_links`
- `proactive.activity`
- `proactive.notifications`
- `proactive.suppressions`

Reuse:
- `commitments.commitments`
- `approvals.approval_requests`
- `approvals.approval_audit_log`
- `ai_routing.*`
- `refinery.*`

Migration skeleton is in `migrations/001_proactive.sql`.

## 3. Deterministic identity

### Event identity

Event identity must be idempotent across replay.

Recommended unique tuple:
- `source`
- `source_ref`
- `evidence_hash`

### Candidate identity

Stable key:
`domain + entity_key + candidate_type`

Examples:
- `server:immich:health-degraded`
- `mail:thread:abc:reply-needed`
- `commitment:42:follow-up-due`
- `sms:conversation:+1xxx:reply-needed`

Same candidate + new evidence = update, not duplicate candidate.

### Evidence identity

`SHA256(canonical_json(relevant evidence))`

Canonicalization rules:
- stable field ordering
- normalized whitespace
- exclude observation timestamps unless timing itself is evidence
- exclude volatile IDs that do not change meaning

## 4. Event intake contract

All scouts call one shared ingestion layer.

Input shape:

```json
{
  "domain": "mail",
  "entity_key": "thread:123",
  "event_type": "reply_requested",
  "summary": "Merchant asked two follow-up questions",
  "details": {},
  "source": "agentmail",
  "source_ref": "thread:123",
  "occurred_at": "2026-10-01T14:32:00-04:00",
  "expires_at": null,
  "origin": "external"
}
```

Ingestion must:
1. validate
2. normalize
3. hash
4. enforce idempotency
5. insert event
6. create/update candidate when appropriate
7. write activity row

## 5. Scout contract

A scout may:
- observe
- normalize
- submit

A scout may not:
- decide whether to interrupt
- send user-facing proactive messages
- make consequential changes
- bypass approval policy

Prefer source order:
1. webhook/event subscription
2. existing n8n event
3. existing monitoring callback
4. small deterministic polling script
5. model-driven polling only when unavoidable

## 6. Commitment extension

Extend existing `commitments.commitments` rather than replacing it.

Recommended new columns:
- `waiting_on`
- `next_follow_up_at`
- `last_touch_at`
- `last_inbound_at`
- `last_outbound_at`
- `conversation_ref`
- `snoozed_until`
- `resolved_at`

Allowed `waiting_on`:
- `me`
- `other`
- `neither`

Do not build a generic BPM/workflow engine.

## 7. Commitment candidate types

At minimum:
- `due`
- `overdue`
- `follow-up-due`
- `reply-received`
- `dependency-satisfied`
- `blocked`
- `waiting-too-long`

## 8. TextBee contract

Inbound SMS:
- read automatically
- normalize into event
- link to commitment/conversation where deterministic
- use Hermes only for ambiguous relationship/intent
- do not create duplicate events on reread

Outbound:
- draft automatically
- alert user via TextBee only when notification policy allows
- sending to third parties requires approval in V1
- after successful third-party send:
  - write activity
  - write notification/action record
  - set commitment waiting state appropriately
  - record `last_outbound_at`

Incoming reply:
- update `last_inbound_at`
- reopen/update related candidate
- move `waiting_on` as appropriate
- re-enter central judgment

## 9. Mail contract

Use existing AgentMail/webhook path.

Do not periodically rescan entire inbox as primary mechanism.

Mail events should preserve:
- provider/source message or thread reference
- counterparty
- reply-needed signal
- explicit date/deadline if present
- relation to existing commitment if known

## 10. Umbrel-health contract

Reuse existing monitoring sources.

Do not install another monitoring stack.

Normalize meaningful state transitions:
- service unhealthy
- persistent restart loop
- disk threshold
- resource pressure
- recovery
- monitoring alert

Transient self-recovery should generally be suppressed before user interruption.

## 11. Monitor/judge gate

Create one Hermes scheduled judge job.

Use:
`--monitor-script proactive_monitor.py`

The monitor output must:
- contain only eligible candidates
- be stable
- contain no volatile timestamps
- use deterministic ordering
- be canonical JSON

Hash suppression is an optimization, not correctness.

Correctness lives in Postgres:
- states
- hashes
- notification ledger
- suppressions
- transactional updates

## 12. Judge context package

For each candidate provide only:
- candidate
- evidence
- linked commitment
- linked goal
- recent same-topic activity
- recent same-topic notifications
- suppressions/cooldowns
- relevant Hindsight recall
- relevant Qdrant evidence when needed
- current local time
- attention policy

Do not inject:
- full inbox
- entire memory bank
- all goals
- all system logs
- full Qdrant contents

## 13. Judge output

Must validate against `contracts/judgment.schema.json`.

Allowed decisions:
- DROP
- REMEMBER
- IDEA
- RESEARCH
- ACT
- ASK
- INTERRUPT

Malformed output fails closed:
- no external action
- candidate returns to safe pending/error state
- activity entry recorded

## 14. Research loop

`RESEARCH` creates bounded research work.

Flow:
candidate → research → new evidence → same candidate → judge

`research_depth <= 2`

At depth 2, judge must choose something other than RESEARCH.

## 15. Executor

Executor accepts only structured authorized tasks.

Every task includes:
- action ID
- candidate ID
- correlation ID
- action class
- parameters
- approval ID when required

Retries must be idempotent.

## 16. Approval

Reuse existing approval tables.

Do not create parallel approval state.

Class D/E actions require approval in V1.

## 17. Notification ledger

Any outbound user-facing message must create/update a notification row.

This is the authoritative dedupe source for:
"Have I already told the user this?"

## 18. Memory rules

Postgres:
- exact current state

Hindsight:
- personal/contextual memory

Qdrant:
- source/reference retrieval

No duplication of exact operational state into memory stores as a substitute for Postgres.

## 19. Modes

`off`
- no proactive judgment
- no proactive action
- scouts may optionally continue recording

`shadow`
- full intake
- full candidate generation
- judge runs
- research may run read-only
- no external actions
- no user-facing proactive notifications

`live`
- policy-authorized outputs/actions enabled

## 20. Kill switch

One authoritative config field:
`proactive.enabled`

All judge/executor/notification paths must check it.

## 21. Observability

Minimum metrics/query report:
- events today
- candidates today
- pending
- resolved
- duplicates suppressed
- expired
- judgments by type
- approvals
- research jobs
- notifications attempted/delivered/failed
- executor failures

## 22. Security

- never log secrets
- never emit MCP/API credentials into model prompts
- third-party sends require approval initially
- no scout receives broad action authority
- no public exposure changes without explicit task scope
- existing private DR repo must remain private
