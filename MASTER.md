# Hermes Proactive Agent — Master Blueprint

## 1. Mission

Build a proactive operating layer around Hermes that continuously notices relevant changes, connects them to open commitments/goals/history, quietly prepares or performs useful work when permitted, and involves the user only when attention or approval is genuinely required.

This is not a new agent framework.

## 2. Product behavior

The system should behave like:

```text
OBSERVE
  ↓
NORMALIZE
  ↓
UPDATE EXACT STATE
  ↓
CONNECT TO COMMITMENTS / GOALS / MEMORY / HISTORY
  ↓
DECIDE WHAT SHOULD HAPPEN
  ↓
DROP / REMEMBER / IDEA / RESEARCH / ACT / ASK / INTERRUPT
  ↓
RECORD RESULT
  ↓
NEW WORLD STATE
```

The system should feel proactive without feeling chatty.

## 3. Primary architecture rule

Many sources may observe.

Only one central judgment path decides whether the user's attention is required.

No scout may independently decide to interrupt.

## 4. System boundaries

### Postgres: canonical operational truth

Use existing `personal_platform`.

Stores:
- exact current states
- events
- candidates
- commitments
- goals
- notifications
- suppressions
- activity
- approvals
- routing telemetry

### Hindsight: personal and episodic memory

Use for:
- past interactions
- personal preferences
- relationship context
- remembered experiences
- contextual recall

Do not use Hindsight as the authoritative workflow database.

### Qdrant: source/reference retrieval

Use for:
- documents
- Kaizen knowledge
- incidents
- indexed observations
- source-grounded retrieval

Do not use Qdrant as canonical workflow state.

### n8n: deterministic integration plumbing

Use for:
- webhook intake
- API adapters
- predictable transforms
- low-complexity automation
- integration glue

Do not make n8n the reasoning authority.

### Hermes: reasoning

Use for:
- materiality judgment
- cross-domain reasoning
- research planning
- drafting
- tool execution
- user interaction

### LiteLLM: model routing

The proactive application should target logical model roles rather than provider-specific API calls.

### Conduit: primary human control surface

Target surfaces:
- Attention
- Approvals
- Ideas
- Goals
- Activity

### TextBee: bidirectional SMS

TextBee is both:
- an inbound signal source for SMS
- an outbound SMS executor/notification channel

Reading SMS is not the same permission class as sending SMS to third parties.

## 5. Central entities

### Event
Something observed.

### Candidate
Something that may warrant action or attention.

### Commitment
Who owes what to whom, and by when.

### Follow-up state
Whether the next move belongs to the user, another party, or neither.

### Goal
A desired outcome that may contain multiple commitments.

### Activity
What the proactive system did.

### Notification
What was surfaced externally.

### Approval
Permission for a consequential action.

## 6. Commitment model

Commitments are a first-class system, not a scout.

Core lifecycle:

```text
OPEN
  ↓
WAITING_ON_ME
  ↓
ACTION_TAKEN
  ↓
WAITING_ON_OTHER
  ↓
RESPONSE_RECEIVED
  ↓
RESOLVED
```

Possible side states:
- BLOCKED
- SNOOZED
- OVERDUE
- FOLLOW_UP_DUE

Messages from email, Teams, and SMS may create, advance, resolve, or reopen commitments.

## 7. Follow-up principle

The agent should understand:
- what the user promised
- what others promised the user
- who is waiting on whom
- when a follow-up becomes useful
- whether a newly received message changes an open loop
- whether the next useful step can be prepared automatically

## 8. Judgment vocabulary

Exactly:

- DROP
- REMEMBER
- IDEA
- RESEARCH
- ACT
- ASK
- INTERRUPT

Do not add an elaborate scoring taxonomy in V1.

Internal escalation to a stronger model is allowed, but it is not a user-visible judgment type.

## 9. Action classes

### A — read-only
Automatic.

### B — preparatory
Automatic.

### C — reversible low-impact
Policy-controlled.

### D — consequential external action
Approval required initially.

### E — financial/security/high-risk
Always explicit approval.

Examples:
- read SMS → A
- draft SMS → B
- send SMS to the user as an authorized alert → notification policy
- send SMS to another person → D
- delete data → D/E
- purchase → E

## 10. Notification hierarchy

Not all useful things interrupt.

```text
IDEA
→ Conduit Ideas

ASK, not urgent
→ Conduit Attention

ASK, urgent
→ push + Attention

INTERRUPT
→ immediate user-facing notification + activity record
```

Channels may include:
- Conduit
- TextBee
- WhatsApp
- ntfy
- Teams
- email

Channel choice is policy. Scouts never own notification authority.

## 11. First release scope

V1 sources:
- Commitments/follow-ups
- AgentMail
- TextBee SMS
- Umbrel health

V1 does not require:
- all calendar integrations
- all Teams flows
- bills
- deliveries
- price watches
- advanced identity graph
- adaptive ML scoring

Those are later expansions.

## 12. Definition of architecture success

The user should be able to ask:

"What am I waiting on?"

"What did I promise?"

"Who is waiting on me?"

"What changed today that matters?"

"What did Hermes do proactively?"

"Why did you notify me?"

and receive answers grounded in exact state plus memory/history.
