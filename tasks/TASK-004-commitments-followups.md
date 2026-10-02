# TASK-004 — Commitments and Follow-ups

## Depends on
T003

## Objective
Turn the existing commitments table into an open-loop/follow-up state machine without replacing it.

## Work
- add follow-up columns via reversible migration
- preserve existing 8 rows/data
- update commitments API if needed
- implement candidate generation for due/overdue/follow-up/reply/dependency states
- implement deterministic caretaker query
- do not add another commitments database

## State
`waiting_on`:
- me
- other
- neither

## Tests
- existing row migration
- due
- overdue
- snoozed
- waiting on other
- reply received
- resolved
- reopened
- duplicate caretaker run

## Acceptance
The system can answer "who is waiting on whom?" from exact state.


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
