# TASK-007 — Umbrel Health Adapter

## Depends on
T003

## Objective
Convert existing monitoring signals into proactive events without adding monitoring infrastructure.

## Reuse
- Beszel
- Uptime Kuma
- NetAlertX
- Docker health
- system metrics
- ntfy infrastructure signals

## Behavior
- transient self-recovery should not interrupt
- persistent degradation should create/update one candidate
- recovery should update/resolve candidate
- diagnostics/research may be requested by judge later

## Tests
- 20 identical alerts → one candidate
- alert then immediate recovery → no interrupt candidate escalation
- persistent failure → evidence updates same candidate
- disk threshold crossing


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
