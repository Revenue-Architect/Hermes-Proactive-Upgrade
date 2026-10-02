# ADR-005 — TextBee is bidirectional

Status: Accepted

## Decision

Treat TextBee as:
- an inbound SMS source
- an outbound SMS capability

## Policy

Reading SMS is automatic.

Drafting SMS is automatic.

Sending the user an authorized proactive alert is controlled by notification policy.

Sending SMS to a third party requires approval in V1.
