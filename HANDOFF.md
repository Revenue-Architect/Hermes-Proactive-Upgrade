# Handoff

## Baseline date
2026-10-01

## Current phase
Phase 2 — first real-world loops are ready to begin. T004-T007 complete; T008 (central judge) is now unblocked.

## Current task
T004-T007 complete. T008 is READY and may proceed.

## Last verified live state
See `CURRENT_STATE.md`.

## Last verified source-of-truth repo
`/home/umbrel/umbrel-config`

## Live implementation branch
`feat/hermes-proactive-foundation`

## Completed live commits
- `967ee92` — T001 baseline record
- `0d5120e` — T002 proactive schema + rollback migration
- `acca49c` — T003 deterministic ingestion core + tests
- `1ea9a43` — ignore Python cache artifacts
- `29b4c5d` — T004 commitments follow-up state machine
- `2a13dc6` — T005 TextBee SMS adapter
- `99c4fcb` — T006 AgentMail adapter
- `047aa9d` — T007 Umbrel health adapter

## Completed
- pre-change `personal_platform` backup created and restore catalog verified
- TextBee verified live as Hermes communication skill/plugin with inbound read and outbound SMS support
- existing commitments count verified at 8 before and after foundation changes
- `proactive` schema created with 7 canonical tables
- migration rollback was executed successfully and schema reapplied
- deterministic event normalization, canonical hashing, stable IDs, candidate upsert, and activity recording implemented
- database ingest function implemented with rollback migration
- exact replay/new-evidence integration behavior tested
- core services remained healthy after changes
- test rows cleaned to zero

## Tests passed
- 6 deterministic core unit tests
- 1 live Postgres integration test
- migration up/down/up validation for T002
- function up/down/up validation for T003
- T004: 9/9 (migration, due, overdue, snoozed, waiting-on-other, reply-received, resolved, reopened, duplicate-run idempotency); migration 003 up/down/up verified live, 8 rows preserved
- T005: 8/8 (inbound idempotent replay, reply-to-open-commitment, unrelated SMS, approved/denied/pending send, ambiguous-failure retry without double-send, home-number alert)
- T006: 22/22 (17 unit + 5 integration: duplicate webhook, same-thread follow-up, unrelated mail, promise/deadline extraction, reply resolves waiting state)
- T007: 21/21 (debounce, evidence stability, 20-identical-alerts→1 candidate, alert-then-recovery→0 candidates, persistent-failure evidence update, disk threshold, recovery resolution)
- Full suite: 67/67 pass, zero test residue

## Safety / rollback
Pre-change database dump:
`/home/umbrel/.jarvis/backups/proactive-agent/personal_platform-pre-proactive-20261001.dump`

Verified Git bundle containing the complete proactive branch:
`/home/umbrel/.jarvis/backups/proactive-agent/hermes-proactive-foundation.bundle`

## Known issue
The live repo origin uses the existing local Forgejo SSH path. The current Desktop Commander → Umbrel SSH session does not have the Forgejo SSH identity, so pushing the new branch from this session failed with public-key authentication. Do not alter Forgejo authentication merely to fix this unless explicitly tasked.

The proactive commits are present locally on Umbrel and have a separately verified Git bundle backup.

Three pre-existing staged non-proactive edits remain untouched in the live repo.

## Not yet implemented
- central Hermes judge (T008, now READY)
- proactive Conduit surfaces
- research/executor loop
- live notification router

## Next exact tasks
- `tasks/TASK-008-monitor-judge.md` — the central Hermes judge; consumes pending candidates from domains `commitment`, `mail`, `server`

## Do not touch
- unrelated staged LiteLLM / Forgejo-sync changes
- unrelated Hermes skills
- Hindsight consolidation settings
- notification/live execution behavior before its assigned task
