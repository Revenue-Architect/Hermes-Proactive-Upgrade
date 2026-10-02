# Handoff

## Baseline date
2026-10-01

## Current phase
Phase 2 — first real-world loops are ready to begin.

## Current task
T001-T003 complete. T004-T007 are READY and may proceed in parallel with separate file ownership.

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
- commitment follow-up extension
- TextBee proactive ingestion loop
- AgentMail proactive ingestion loop
- Umbrel proactive health adapter
- central Hermes judge
- proactive Conduit surfaces
- research/executor loop
- live notification router

## Next exact tasks
Any of the following may start now:
- `tasks/TASK-004-commitments-followups.md`
- `tasks/TASK-005-textbee.md`
- `tasks/TASK-006-agentmail.md`
- `tasks/TASK-007-umbrel-health.md`

T004-T007 are intentionally parallel-safe only when agents use non-overlapping files and do not modify the shared ingestion core without coordination.

## Do not touch
- unrelated staged LiteLLM / Forgejo-sync changes
- unrelated Hermes skills
- Hindsight consolidation settings
- notification/live execution behavior before its assigned task
