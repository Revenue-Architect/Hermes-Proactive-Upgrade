# Data Model

## Existing data reused

### `commitments.commitments`
Existing operational obligation table.

### `approvals.*`
Existing approval lifecycle.

### `ai_routing.*`
Existing routing telemetry scaffolding.

### `refinery.*`
Existing extraction/reconciliation state.

## New proactive schema

### events
Immutable-ish normalized observations.

### candidates
Mutable units of possible useful work/attention.

### goals
Persistent desired outcomes.

### goal_links
Many-to-many relation between candidates and goals.

### activity
Audit trail of proactive work.

### notifications
Outbound user-facing communication ledger.

### suppressions
Explicit deterministic suppression windows/rules.

## Key invariant

Events are evidence.

Candidates are decisions-in-progress.

Commitments are obligations.

Goals are outcomes.

Notifications are delivery history.

Activity is audit history.

Do not collapse these into one generic table.
