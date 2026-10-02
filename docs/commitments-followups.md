# Commitments and Follow-ups

## Purpose

The proactive agent must track open loops, not just deadlines.

## Core questions

For every commitment:
- what was promised?
- who owns the next move?
- who is the counterparty?
- what source created it?
- when was the last inbound touch?
- when was the last outbound touch?
- when is a follow-up useful?
- is it blocked?
- is it resolved?

## Recommended state

Existing commitment columns remain.

Add:
- `waiting_on`
- `next_follow_up_at`
- `last_touch_at`
- `last_inbound_at`
- `last_outbound_at`
- `conversation_ref`
- `snoozed_until`
- `resolved_at`

## State examples

### User owes work

`waiting_on = me`

Candidate:
`commitment:<id>:due`

### User completed work and is awaiting response

`waiting_on = other`

Candidate eventually:
`commitment:<id>:follow-up-due`

### Reply arrives via email/SMS/Teams

Update:
- `last_inbound_at`
- linked event
- waiting state
- candidate evidence

Then judge again.

## Extraction

Models may help infer:
- whether a message contains a promise
- whether a response satisfies a commitment
- whether two conversations refer to the same open loop

Models must not be authoritative for:
- whether an outbound message was actually sent
- whether a due date has passed
- whether a follow-up was already sent
- whether an approval exists
