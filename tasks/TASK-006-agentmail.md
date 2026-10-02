# TASK-006 — AgentMail Adapter

## Depends on
T003

## Objective
Feed relevant email changes into proactive state using the existing AgentMail path.

## Work
- reuse existing webhook/receiver
- normalize thread/message reference
- identify reply-needed/deadline/commitment signals
- link to existing commitment where deterministic
- create candidate updates
- preserve existing email behavior

## Non-goals
- no periodic full-mailbox scan as primary architecture
- no automatic sends

## Tests
- duplicate webhook
- follow-up in same thread
- unrelated mail
- explicit promise/deadline
- reply resolves waiting state


Before work:
- read `AGENTS.md`
- read `HANDOFF.md`
- refresh live Git state
- do not include unrelated changes

After work:
- run listed tests
- update `HANDOFF.md`
- update `TASK_BOARD.md`
