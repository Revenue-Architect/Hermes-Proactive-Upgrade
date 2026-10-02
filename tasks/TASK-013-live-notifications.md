# TASK-013 — Live Notification Router

## Depends on
T012

## Objective
Move from shadow to narrowly scoped live attention.

## Channels
- Conduit
- TextBee
- WhatsApp where explicitly configured
- ntfy infrastructure/fallback

## Work
- notification policy
- notification ledger
- idempotency
- cooldown/suppression
- quiet hours
- channel selection
- kill-switch enforcement

## Tests
- shadow never sends
- disabled never sends
- duplicate candidate never double-sends
- IDEA does not interrupt
- nonurgent ASK stays in Attention
- urgent ASK/INTERRUPT routes correctly
- TextBee alert to user
- no third-party send without executor approval


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
