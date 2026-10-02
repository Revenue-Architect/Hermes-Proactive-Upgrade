# Handoff

## Baseline date
2026-10-01

## Current phase
Phase 2 complete — all 14 tasks done. The proactive loop is built end to end (shadow judge live, router built with kill-switch OFF, Conduit parked).

## Current task
T012-T014 complete. No tasks remain on the board. Next: user decision to arm the router.

## Last verified live state
See `CURRENT_STATE.md`.

## Last verified source-of-truth repo
`/home/umbrel/umbrel-config`

## Live implementation branch
`feat/hermes-proactive-foundation`

## Completed live commits
- `967ee92` — T001 baseline record
- `0d5120e` — T002 proactive schema + rollback migration
- `acca49c` — T003 deterministic ingestion core + tests
- `1ea9a43` — ignore Python cache artifacts
- `29b4c5d` — T004 commitments follow-up state machine
- `2a13dc6` — T005 TextBee SMS adapter
- `99c4fcb` — T006 AgentMail adapter
- `047aa9d` — T007 Umbrel health adapter
- `44ccf0b` — T008 monitor gate + central judge (shadow)
- `7fdc4b8` — T009 Hindsight/Qdrant context adapters
- `d0c1be4` — T010 bounded research loop
- `64d6859` — T011 backend API for Conduit surfaces
- `6998735` — T012 approval + executor
- `d1f28ae` — T013 live notification router (kill-switch off)
- `1a140d9` — T014 additional scouts (changedetection, paperless, n8n)
- `edc1c7e` — live wiring: 6 new systemd timers (scouts 15m, umbrel-health 10m, textbee-poll 10m) + RESEARCH auto-invocation hook in applier; 182/182 tests green at commit time
- `18e37b4` — AgentMail receiver wiring + wiring reconciliation: hermes receiver now mirrors inbound mail to a proactive spool (drained every 5m via adapter CLI); parallel uncommitted source_tick/shadow_cycle approach removed (timers kept on merit); commitment caretaker timer added; pushed to private Forgejo
- `d78cb17` — judge SILENT blocker fix: hardened prompt (SILENT only valid on empty candidate list), batched judge input (max 8, priority-ordered), applier fail-closed on SILENT-with-candidates; backlog triaged (3 stale expired, 19 judged: 5 RESEARCH/2 DROP/12 REMEMBER); E2E proven on production loop
- `4dc2553` — churn fix: dropped volatile `last_checked` from ChangeDetection evidence (it poisoned the evidence hash and flipped judged candidates to pending every 15m); regression test added

## Completed
- pre-change `personal_platform` backup created and restore catalog verified
- TextBee verified live as Hermes communication skill/plugin with inbound read and outbound SMS support
- existing commitments count verified at 8 before and after foundation changes
- `proactive` schema created with 7 canonical tables
- migration rollback was executed successfully and schema reapplied
- deterministic event normalization, canonical hashing, stable IDs, candidate upsert, and activity recording implemented
- database ingest function implemented with rollback migration
- exact replay/new-evidence integration behavior tested
- core services remained healthy after changes
- test rows cleaned to zero

## Tests passed
- 6 deterministic core unit tests
- 1 live Postgres integration test
- migration up/down/up validation for T002
- function up/down/up validation for T003
- T004: 9/9 (migration, due, overdue, snoozed, waiting-on-other, reply-received, resolved, reopened, duplicate-run idempotency); migration 003 up/down/up verified live, 8 rows preserved
- T005: 8/8 (inbound idempotent replay, reply-to-open-commitment, unrelated SMS, approved/denied/pending send, ambiguous-failure retry without double-send, home-number alert)
- T006: 22/22 (17 unit + 5 integration: duplicate webhook, same-thread follow-up, unrelated mail, promise/deadline extraction, reply resolves waiting state)
- T007: 21/21 (debounce, evidence stability, 20-identical-alerts→1 candidate, alert-then-recovery→0 candidates, persistent-failure evidence update, disk threshold, recovery resolution)
- Full suite: 67/67 pass, zero test residue
- T008: 17/17 (monitor wake/no-wake, malformed judgment fail-closed, restart state, shadow zero-notifications); full live loop proven candidate → wake → judge → validated judgment → applied transactionally; one Hermes cron job `proactive-judge` (30m, monitor-gated, qwen3-30b-a3b, deliver local)
- T009: 19/19 (Hindsight recall + Qdrant keyword retrieval, bounded caps, conflict labeling, graceful degradation); full suite 103 pass
- T010: 11/11 (useful/no-result/urgent/depth-2-refusal/failure-retry/idempotent rerun/no-notify proof); full suite 124/124 pass
- T011: 10/10 backend contract tests; proactive API live at 127.0.0.1:8899 via Tailscale Serve :8445 (systemd unit active, bearer token at /home/umbrel/.jarvis/proactive-api-token); Conduit Attention/Ideas/Activity + deep links committed on parked branch (Dart NOT compiled — no Flutter toolchain in this environment)
- T012: 10/10 (Class A/B auto, Class D blocked w/o approval, approval→execute, rejection blocks, idempotent duplicate, ambiguous no-blind-retry); action classes A–E with registry enforcement; POST /v1/approvals/<id>/decision added to API (all other POSTs still 405)
- T013: 21/21 (kill-switch off never sends, dry-run never sends, INTERRUPT→SMS, dedup, IDEA/non-urgent ASK silent, quiet-hours hold + morning delivery, suppressions, cooldowns); systemd timers installed and firing (poller/applier/router every 5m); router tick verified armed:false, zero sends; Conduit leg dormant by design; WhatsApp flag-gated off
- T014: 16/16 (3 scouts: ChangeDetection, Paperless, n8n workflow failures); Teams/bills skipped with reasons (Graph app-only limits, Gmail unreachable); calendar deferred (user connecting later)
- Full suite: 171/171 pass (4 pre-existing skips), zero test residue

## Safety / rollback
Pre-change database dump:
`/home/umbrel/.jarvis/backups/proactive-agent/personal_platform-pre-proactive-20261001.dump`

Verified Git bundle containing the complete proactive branch:
`/home/umbrel/.jarvis/backups/proactive-agent/hermes-proactive-foundation.bundle`

## Known issue
The live repo origin uses the existing local Forgejo SSH path. The current Desktop Commander → Umbrel SSH session does not have the Forgejo SSH identity, so pushing the new branch from this session failed with public-key authentication. Do not alter Forgejo authentication merely to fix this unless explicitly tasked.

The proactive commits are present locally on Umbrel and have a separately verified Git bundle backup.

Three pre-existing staged non-proactive edits remain untouched in the live repo.

## Not yet implemented
Nothing on the current board. Remaining parked/deferred items:
- optionally wire the kai receiver (agentmail-kai-receiver) into the loop — hermes receiver only for now
- build the Conduit APK (Dart changes uncompiled; needs Flutter toolchain)
- connect Google Calendar (deferred scout)

## Router status
ARMED 2026-10-02 11:43 EDT by explicit user order ("Lets arm it!"). Kill-switch file `/home/umbrel/.jarvis/proactive-router-live` present. First armed tick: evaluated 0, sent 0 (no INTERRUPT/ASK in queue — correct). To disarm: `rm /home/umbrel/.jarvis/proactive-router-live`.

## n8n scout recency fix (2026-10-02 ~13:10 EDT, live commit cdf68a7)
User feedback: early judge output "seems useless". Diagnosis: the n8n scout had no recency cutoff, so when it went live it backfilled week-old failed executions as fresh candidates — the judge solemnly RESEARCHed a 2026-09-25 GLiNER pipeline failure burst that had already self-resolved (workflow green since). Fix: `RECENCY_CUTOFF_HOURS = 24` in `proactive/scouts/n8n.py`; failures older than 24h never become candidates. Tests: 198/198 pass (4 expected skips); new tests cover stale-skip, fresh-emit, and `_is_fresh` boundaries. Live dry-run: 0 events. Note: commit cdf68a7 briefly swept 3 intentionally-staged unrelated files; fixed via soft reset, recommitted proactive-only, restored their staged state.

## Next exact tasks
Board is clear (T001–T014 DONE). Awaiting user direction.

## Do not touch
- unrelated staged LiteLLM / Forgejo-sync changes
- unrelated Hermes skills
- Hindsight consolidation settings
- notification/live execution behavior before its assigned task
