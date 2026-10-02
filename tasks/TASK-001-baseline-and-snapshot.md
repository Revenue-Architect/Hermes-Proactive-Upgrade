# TASK-001 — Baseline and Snapshot

## Objective
Create a clean implementation starting point without changing behavior.

## Work
- refresh `/home/umbrel/umbrel-config` branch/commit/status
- inventory existing relevant files
- record current DB schema versions
- verify backup/restore path for `personal_platform`
- verify Hermes cron status
- verify n8n active workflows
- verify TextBee availability without exposing secrets
- verify AgentMail receiver health
- create a pre-change baseline note/commit if appropriate

## Non-goals
- no schema changes
- no service upgrades
- no cleanup
- no skill edits

## Acceptance
- starting commit documented
- unrelated dirty files identified
- rollback path documented
- all core services still healthy


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
