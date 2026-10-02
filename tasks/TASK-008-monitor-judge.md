# TASK-008 — Hermes Monitor Gate and Central Judge

## Depends on
T004, T005, T006, T007

## Objective
Create exactly one Hermes judgment path.

## Work
- implement stable `proactive_monitor.py`
- query only eligible candidates
- canonical JSON ordering
- no volatile timestamps
- create one Hermes cron job using `--monitor-script`
- keep system in shadow mode
- validate output with judgment JSON schema
- persist judgment/activity transactionally

## Hermes facts
Installed version supports:
- `--monitor-script`
- `--no-agent`
- `--continuity`
- model/provider pins
- reasoning-effort pins

Current scheduler has no active jobs.

## Tests
- unchanged bytes → no wake
- candidate added → wake
- evidence update → wake
- malformed judgment → fail closed
- restart → state preserved
- no notification in shadow mode


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
