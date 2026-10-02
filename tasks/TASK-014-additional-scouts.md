# TASK-014 — Additional Scouts

## Depends on
T013

## Objective
Expand coverage without changing the core architecture.

## Candidate additions
- Calendar
- Teams
- deliveries
- bills
- price watches
- ChangeDetection-derived life events
- Paperless-derived events
- additional household services

## Rule
Every source must implement the same ingestion contract.

No source gets direct notification authority.

## Acceptance
Each new scout has:
- event contract
- stable identity
- idempotency
- source-specific tests
- no new canonical state store
- no duplicated notification path


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
