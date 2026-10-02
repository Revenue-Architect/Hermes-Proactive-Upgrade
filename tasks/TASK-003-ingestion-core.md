# TASK-003 — Shared Event Ingestion Core

## Depends on
T002

## Objective
Create one reusable deterministic intake path for all scouts.

## Required functions
- validate event contract
- normalize entity keys
- canonicalize evidence
- compute SHA256 evidence hash
- idempotent event insert
- candidate upsert
- activity record
- self-origin filtering support

## Non-goals
- no model calls
- no notification
- no source-specific logic

## Tests
- exact replay
- reordered JSON fields
- whitespace variance
- same candidate/new evidence
- same source_ref/new evidence
- malformed event
- transaction rollback

## Acceptance
One adapter can submit the same event repeatedly with exactly one durable observation/candidate effect.


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
