# Operations Runbook

## 1. Before touching the system

Read:
- `AGENTS.md`
- `CURRENT_STATE.md`
- `HANDOFF.md`
- assigned task

On Umbrel:
- verify current branch/commit in `/home/umbrel/umbrel-config`
- check for uncommitted changes
- do not mix unrelated changes

## 2. Modes

Expected config:

```yaml
proactive:
  enabled: true
  mode: shadow
```

Modes:
- `off`
- `shadow`
- `live`

## 3. Emergency stop

Set:
```yaml
proactive:
  enabled: false
```

Expected result:
- judge stops acting
- executor does not execute
- notification router does not send
- scouts may continue recording

If kill switch does not prevent output, treat as severity-1 project defect.

## 4. Health checks

Check:
- Postgres reachable
- proactive schema exists
- n8n healthy
- Hermes gateway healthy
- Hermes cron doctor healthy
- Hindsight health green
- Qdrant health green
- LiteLLM healthy
- TextBee source/tool available
- AgentMail receiver healthy
- monitoring sources healthy

## 5. Inspect recent events

Example query:

```sql
SELECT observed_at, domain, entity_key, event_type, summary
FROM proactive.events
ORDER BY observed_at DESC
LIMIT 50;
```

## 6. Inspect pending candidates

```sql
SELECT id, domain, entity_key, candidate_type, status, judgment, updated_at
FROM proactive.candidates
WHERE status NOT IN ('resolved','expired','suppressed')
ORDER BY updated_at DESC;
```

## 7. Inspect commitments needing attention

```sql
SELECT *
FROM commitments.commitments
WHERE status <> 'resolved'
ORDER BY due_date NULLS LAST, updated_at;
```

Once follow-up columns exist, also filter:
- `waiting_on`
- `next_follow_up_at`
- `snoozed_until`

## 8. Why did Hermes notify me?

Trace:
1. notification row
2. candidate row
3. evidence/event rows
4. judgment activity
5. linked commitment/goal
6. relevant research activity
7. approval record if action occurred

Every notification must be traceable.

## 9. Replay an event

Replay through the normal ingestion contract.

Expected:
- same source_ref + evidence_hash does not create duplicate event/candidate
- activity may record replay if desired

Never insert arbitrary rows manually unless repairing state.

## 10. Stuck candidate

Check:
- `status`
- `recheck_at`
- suppressions
- last activity
- last judgment parse error
- research depth
- pending approval

Repair minimally and record activity.

## 11. Notification duplicate

Immediately:
- disable live mode if duplicates are ongoing
- inspect `proactive.notifications`
- inspect evidence hash/candidate identity
- verify notification idempotency key
- do not patch by adding arbitrary cooldowns until root cause is understood

## 12. Research loop

If research repeats:
- inspect `research_depth`
- maximum is 2
- judge must not return RESEARCH beyond limit

## 13. Approval issues

Use existing:
- `approvals.approval_requests`
- `approvals.approval_audit_log`

Never manually execute a Class D/E action just because the UI failed.

## 14. TextBee issues

Inbound:
- verify SMS exists at source
- verify webhook/poll retrieval
- verify source_ref
- verify event idempotency
- verify commitment linkage

Outbound:
- verify recipient/action class
- verify approval if third party
- verify notification/action ledger before retry
- retries must not double-send

## 15. Hermes judge not waking

Check:
- active cron status
- ticker heartbeat
- monitor script exit status
- monitor output bytes
- stable JSON sorting
- whether eligible set truly changed

Remember:
unchanged output should suppress the agent.

## 16. Hermes waking too often

Look for volatile monitor output:
- timestamps
- unordered arrays
- random IDs
- non-canonical JSON
- fluctuating irrelevant fields

Fix monitor stability before changing schedule.

## 17. Hindsight

Hindsight is contextual memory, not exact workflow state.

Current auto-consolidation is disabled by design.

Do not "fix" pending consolidation unless explicitly tasked.

## 18. Qdrant

Do not use Qdrant to decide whether an action already happened.

That answer belongs in Postgres.

## 19. Rollback

Every migration must have:
- pre-change backup
- reverse SQL or documented restore
- task-specific rollback steps

For app changes:
- retain existing rollback path
- avoid deleting old containers/images merely to tidy up during implementation

## 20. End-of-session handoff

Before stopping:
- tests run
- commit recorded
- exact files changed
- current phase/task
- known defects
- next exact command/action
- HANDOFF updated
- TASK_BOARD updated
