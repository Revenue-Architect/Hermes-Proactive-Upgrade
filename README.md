# Hermes Proactive Agent — Implementation Package

Baseline: 2026-10-01

This package is the canonical handoff bundle for implementing the proactive personal-agent layer around the existing Hermes/Umbrel stack.

## Read order for any AI agent

1. `AGENTS.md`
2. `CURRENT_STATE.md`
3. `MASTER.md`
4. `IMPLEMENTATION_SPEC.md`
5. `HANDOFF.md`
6. The assigned file in `tasks/`
7. Relevant ADRs and docs only as needed

Do not redesign the system before reading those files.

## Core rule

This project extends the existing stack. It does not create a new agent framework.

- `personal_platform` Postgres = canonical operational state
- Hindsight = personal / episodic memory
- Qdrant = document / reference retrieval
- n8n = deterministic integration plumbing
- Hermes = reasoning and tool use
- LiteLLM = model routing
- Conduit = primary human control surface
- TextBee = bidirectional SMS source/action channel
- ntfy = infrastructure/fallback notifications

## Multi-agent workflow

Each coding agent takes one bounded task from `tasks/`.

Before coding:
- verify `HANDOFF.md`
- verify the current Git commit
- run the task's preflight checks
- do not edit unrelated components

Before stopping:
- run acceptance tests
- record changed files
- record verified behavior
- record unresolved issues
- update `HANDOFF.md`
- update `TASK_BOARD.md`
- commit with a narrow message if repository access is available

## Important operational note

The live `/home/umbrel/umbrel-config` repository is private and is known to contain real credentials and exported configuration. Never publish it. Never copy secrets into logs, prompts, task files, screenshots, or this package.
