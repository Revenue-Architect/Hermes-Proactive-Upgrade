# Notification Policy

## Core rule

Useful does not equal interrupt-worthy.

## Decision mapping

### DROP
No user output.

### REMEMBER
Update state/memory only.

### IDEA
Surface in Conduit Ideas.

### RESEARCH
No user output unless research itself needs approval.

### ACT
Perform or prepare work under action policy.

### ASK
Place in Conduit Attention.
Push only if time-sensitive.

### INTERRUPT
Immediate user-facing notification.

## Channel routing

Preferred:
1. Conduit for structured attention/approval
2. TextBee for SMS when immediacy or SMS context is appropriate
3. WhatsApp where configured/appropriate
4. ntfy for infrastructure/fallback

## TextBee distinctions

Inbound SMS:
automatic read/ingestion.

SMS alert to the user:
allowed if notification policy selects TextBee.

SMS to another person:
approval-required in V1.

## Dedupe

Before sending:
- candidate state
- evidence hash
- notification ledger
- cooldown
- suppression

must all be checked deterministically.
