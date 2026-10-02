# AGENTS.md

These rules apply to every AI/coding agent working on this project.

## Mandatory read order

Before editing:
1. `CURRENT_STATE.md`
2. `MASTER.md`
3. `IMPLEMENTATION_SPEC.md`
4. `HANDOFF.md`
5. assigned task
6. relevant ADRs

## Architecture is already decided

Do not redesign the system without explicit user approval.

Hard boundaries:

- `personal_platform` Postgres = canonical operational state
- Hindsight = personal/episodic memory
- Qdrant = source/reference retrieval
- n8n = deterministic integration plumbing
- Hermes = reasoning/tool execution
- LiteLLM = model routing
- Conduit = human control surface
- TextBee = bidirectional SMS
- ntfy = infrastructure/fallback notifications

## Do not create

Unless explicitly authorized:
- another database
- another vector store
- another notification service
- another monitoring stack
- another approval system
- another agent framework
- another general-purpose workflow engine
- another identity graph

## Existing infrastructure first

Before adding a service/library:
1. verify whether the capability already exists
2. reuse it when reasonable
3. prefer a small adapter over another platform

## State rules

Exact operational facts belong in Postgres.

Do not make memory the source of truth for:
- whether something was sent
- whether an action executed
- whether a candidate is pending
- who is waiting on whom
- whether an approval exists

## Notification rule

No scout may notify the user directly.

Only the central judgment/notification path may request user interruption.

## Action rule

Class D/E actions require approval in V1.

Never bypass approval because:
- the action seems obvious
- the user "would probably want it"
- an earlier message implied general autonomy

## Secrets

The live private DR repo contains real credentials.

Never:
- print secrets
- paste them into prompts
- copy them into task files
- put them in test fixtures
- expose them in screenshots
- publish the repository

Use environment references and redacted diagnostics.

## Skills freeze / unrelated changes

Do not modify unrelated Hermes skills.

Do not perform opportunistic cleanup.

Do not fix unrelated warnings during a scoped task.

Do not delete backups/rollback containers/images unless explicitly tasked.

## Simplicity

Prefer:
- one table over three
- one adapter over a new service
- deterministic code over LLM reasoning
- explicit state over inferred state
- small reversible changes
- existing components

Avoid over-engineering.

## Testing

Every task must include:
- unit tests where applicable
- idempotency test
- failure-path test
- regression check for touched existing behavior
- acceptance criteria from task file

## Git discipline

Before work:
- capture branch/commit
- inspect working tree

During work:
- do not include unrelated modifications

After work:
- narrow commit if allowed
- record commit in HANDOFF

## Multi-agent coordination

One owner at a time for:
- schema migrations
- shared ingestion library
- judge state transitions
- executor transaction logic

Parallel agents may work only on independent adapters/UI/tests with non-overlapping files.

## Handoff requirement

Before stopping, update `HANDOFF.md` with:
- task
- status
- commit
- changed files
- verified tests
- unresolved issues
- exact next action
- warnings for next agent

If HANDOFF is not updated, the task is not complete.
