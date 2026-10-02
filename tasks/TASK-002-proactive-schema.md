# TASK-002 — Proactive Postgres Schema

## Depends on
T001

## Objective
Add canonical proactive operational state to existing `personal_platform`.

## Work
- review `migrations/001_proactive.sql`
- adapt only if live schema requires it
- apply migration
- add reverse/rollback migration
- add schema-level tests
- do not change existing commitment/approval tables yet

## Acceptance
- all proactive tables exist
- constraints/indexes verified
- migration can be rerun safely where intended
- rollback tested against a disposable/test target or documented safely
- existing n8n/commitments behavior unchanged


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
