# TASK-005 — TextBee SMS Adapter

## Depends on
T003

## Objective
Make SMS a bidirectional part of the proactive open-loop system.

## Inbound
- verify actual Hermes TextBee MCP/skill/tool path
- retrieve/receive SMS safely
- normalize to event contract
- establish stable source_ref
- dedupe rereads
- link to commitment/conversation where possible
- create candidate when message changes an open loop

## Outbound
- provide draft/send executor interface
- SMS to third party is Class D
- require existing approval system
- record idempotency key and outcome
- update commitment touch/waiting state after confirmed send

## Non-goals
- no broad contact graph
- no automatic third-party sends
- no new SMS provider

## Tests
- same inbound SMS twice
- reply to open commitment
- unrelated SMS
- approved send
- rejected send
- retry after ambiguous failure without double-send

## Acceptance
SMS can create/advance/resolve follow-up state and outbound third-party SMS cannot bypass approval.


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
