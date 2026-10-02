# Task Board

| Task | Name | Status | Depends on | Parallel-safe |
|---|---|---|---|---|
| T001 | Baseline and snapshot | DONE | — | No |
| T002 | Proactive Postgres schema | DONE | T001 | No |
| T003 | Shared ingestion core | DONE | T002 | No |
| T004 | Commitments + follow-ups | DONE | T003 | Yes |
| T005 | TextBee adapter | DONE | T003 | Yes |
| T006 | AgentMail adapter | DONE | T003 | Yes |
| T007 | Umbrel health adapter | DONE | T003 | Yes |
| T008 | Hermes monitor + judge | READY | T004-T007 | No |
| T009 | Hindsight/Qdrant context | BLOCKED | T008 | No |
| T010 | Research loop | BLOCKED | T009 | Yes |
| T011 | Conduit Attention/Ideas/Activity | BLOCKED | T009 | Yes |
| T012 | Approval + executor | BLOCKED | T010-T011 | No |
| T013 | Live notification router | BLOCKED | T012 | No |
| T014 | Additional scouts | BLOCKED | T013 | Yes |

Allowed status values:
- READY
- IN_PROGRESS
- BLOCKED
- REVIEW
- DONE
