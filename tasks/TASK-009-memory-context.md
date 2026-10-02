# TASK-009 — Hindsight and Qdrant Context

## Depends on
T008

## Objective
Provide the judge with narrowly relevant context without mixing store responsibilities.

## Rules
Postgres = exact state
Hindsight = personal/episodic context
Qdrant = source/reference evidence

## Work
- define retrieval adapter interfaces
- bounded recall
- include citations/IDs internally where possible
- no whole-bank dumps
- no writes to exact state based only on memory recall

## Tests
- candidate with relevant personal memory
- candidate with relevant document evidence
- no relevant context
- conflicting memory/evidence
- bounded token/context size


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
