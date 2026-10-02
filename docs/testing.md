# Test Strategy

## Required categories

### Idempotency
- replay same event
- retry same notification
- retry same action
- duplicate inbound webhook

### State transitions
- commitment waiting_on changes
- follow-up due
- inbound reply
- resolution/reopen
- candidate expiry
- suppression expiry

### Judge
- valid structured output
- malformed output
- low-confidence escalation
- research-depth limit
- no duplicate interrupt

### Notification
- shadow mode never sends
- kill switch never sends
- TextBee third-party send requires approval
- Conduit Attention receives ASK
- IDEA does not push

### Restart
- Hermes restart
- n8n restart
- worker restart
- DB connection loss

### Regression
- existing commitments API still works
- existing AgentMail flow still works
- existing monitoring remains intact
- no unrelated Hermes skill changes
