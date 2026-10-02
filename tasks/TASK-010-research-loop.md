# TASK-010 — Bounded Research Loop

## Depends on
T009

## Objective
Implement RESEARCH → evidence → same candidate → judge.

## Rules
- max depth 2
- research worker cannot notify
- worker cannot perform consequential actions
- research results become evidence/activity
- same candidate is updated unless a genuinely new issue is discovered

## Tests
- useful result
- no useful result
- urgent discovery
- depth 2 refusal to recurse
- worker failure/retry


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
