# TASK-012 — Approval and Executor

## Depends on
T010, T011

## Objective
Execute authorized work safely using the existing approval subsystem.

## Work
- action-class enforcement
- reuse `approvals.*`
- structured action contract
- idempotency keys
- activity logging
- ambiguous-outcome handling
- Conduit approval state integration

## Tests
- Class A automatic
- Class B automatic
- Class D blocked without approval
- approval then execute
- rejection
- duplicate execute request
- ambiguous external outcome


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
