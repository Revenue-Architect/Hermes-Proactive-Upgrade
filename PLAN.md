# Implementation Plan

## Dependency graph

```text
T001 Baseline
   ↓
T002 Proactive schema
   ↓
T003 Shared ingestion core
   ├────────────┬────────────┬────────────┐
   ↓            ↓            ↓            ↓
T004          T005          T006         T007
Commitments   TextBee       AgentMail    Umbrel
   └────────────┴────────────┴────────────┘
                    ↓
                  T008
               Judge / gate
                    ↓
                  T009
              Memory context
                    ↓
          ┌─────────┴─────────┐
          ↓                   ↓
        T010                T011
      Research             Conduit
          └─────────┬─────────┘
                    ↓
                  T012
            Approval/executor
                    ↓
                  T013
           Live notifications
                    ↓
                  T014
            Additional scouts
```

## Parallelization

Safe parallel work:
- T004, T005, T006, T007 may proceed in parallel after T003 if file ownership is kept separate.
- T010 and T011 may proceed in parallel after T009.

Do not parallelize:
- schema migrations
- shared identity/ingestion library
- judge state transition logic
- approval executor transaction logic

These are shared foundations and should have one owner at a time.

## Phase 0 — Baseline and safety

Goal:
make current state reproducible before changes.

Exit:
- Git baseline recorded
- DB backup/snapshot path verified
- current services health captured
- no uncommitted unrelated edits accidentally included

## Phase 1 — State foundation

Tasks:
- T002
- T003

Exit:
- proactive schema applied
- event replay idempotent
- candidate identity deterministic
- activity log functional

## Phase 2 — First real-world loops

Tasks:
- T004
- T005
- T006
- T007

Exit:
- commitments produce candidates
- incoming SMS produces events
- email produces events
- Umbrel health produces events
- no user-facing output yet

## Phase 3 — Judgment

Tasks:
- T008
- T009

Exit:
- single Hermes judge exists
- unchanged monitor output causes no wake
- structured output validated
- Hindsight/Qdrant retrieval follows boundaries
- still shadow mode

## Phase 4 — Useful work and UI

Tasks:
- T010
- T011

Exit:
- bounded research loop
- Attention/Ideas/Activity surfaces available or contract complete

## Phase 5 — Controlled execution

Task:
- T012

Exit:
- class-based action policy enforced
- approvals reused
- retry idempotency tested

## Phase 6 — Live attention

Task:
- T013

Exit:
- notification router enabled for narrow cases
- no scout can notify directly
- dedupe proven
- kill switch proven

## Phase 7 — Expansion

Task:
- T014

Possible sources:
- Calendar
- Teams
- deliveries
- bills
- price watches
- Paperless-derived events
- additional household/service signals

## V1 complete

V1 is complete when Commitments + TextBee + AgentMail + Umbrel feed one reliable central judge in shadow/live modes with exact state, bounded research, approvals, activity history, and no duplicate interruptions.
