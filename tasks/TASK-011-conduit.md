# TASK-011 — Conduit Attention / Ideas / Activity

## Depends on
T009

## Objective
Use Conduit as the primary human control surface.

## Reuse
Existing NotificationCenter/deep-link/approval-oriented UX work.

## Minimum surfaces
- Attention
- Ideas
- Activity

Goals may be read-only initially if needed.

## Requirements
- deep link from notification to candidate/approval
- show why item matters
- show current status
- show actions requiring approval
- activity trace
- no duplicate notification plumbing

## Acceptance
A user can understand what happened and why without opening Postgres or Hermes logs.


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
