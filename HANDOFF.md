# Handoff

## Baseline date
2026-10-01

## Current phase
Not started — implementation package created.

## Current task
None assigned.

## Last verified live state
See `CURRENT_STATE.md`.

## Last verified source-of-truth repo
`/home/umbrel/umbrel-config`

## Last verified Git state
Must be refreshed by the first implementation agent before changes.

## Completed
- architecture validated against live Oct 1 system
- current substrate mapped
- implementation package created
- task dependencies defined

## Not yet implemented
- proactive Postgres schema
- shared event ingestion
- commitment follow-up extension
- TextBee proactive ingestion loop
- AgentMail proactive ingestion loop
- Umbrel proactive health adapter
- central Hermes judge
- proactive Conduit surfaces
- research/executor loop
- live notification router

## Known important facts
- Hermes has no active cron jobs currently
- commitments table already exists and is active
- existing approval tables must be reused
- TextBee belongs in both inbound SMS and outbound SMS design
- Hindsight and Qdrant are both live and have different roles
- n8n is already the deterministic integration layer
- current private repo contains real credentials

## Next exact task
Start `tasks/TASK-001-baseline-and-snapshot.md`.

## Agent handoff template

When updating this file, replace/add:

### Session
- Agent:
- Date:
- Task:
- Starting commit:
- Ending commit:

### Completed
-

### Files changed
-

### Tests run
-

### Verified behavior
-

### Known issues
-

### Next exact action
-

### Do not touch
-
