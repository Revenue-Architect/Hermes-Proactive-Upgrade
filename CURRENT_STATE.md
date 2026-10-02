# Current Verified State — 2026-10-01

This is the baseline against which implementation work must be evaluated.

## Host

- GEEKOM IT13 Max
- Debian GNU/Linux 13 (Trixie)
- Intel Core Ultra 9 185H
- ~62 GiB usable RAM
- LAN: `<UMBrel-LAN-IP>`
- Tailscale: active
- Active Umbrel data pool: single-disk ZFS on ~1 TB NVMe
- 2 TB SATA SSD is not installed yet and is intentionally out of scope

## Docker / Umbrel

Verified:
- 51 containers total
- 47 running
- 26 Compose projects

Major apps/services include:
- Immich
- Paperless
- Karakeep
- Homebox
- Forgejo
- Syncthing
- Portainer
- Code Server
- Uptime Kuma
- AdGuard Home
- n8n
- PostgreSQL
- LiteLLM
- Qdrant
- Hindsight
- Context Refinery
- Steel Browser
- Kai Graph MCP
- Vaultwarden
- AgentMail receivers
- Beszel
- NetAlertX
- Speedtest Tracker
- ChangeDetection

Stremio/media-related components may be managed through Portainer. Do not assume absence merely because no obvious standalone Compose project was found.

## Hermes

Installed:
- Hermes Agent v0.21.1
- upstream release string: 2026.9.7
- custom Umbrel image: `hermes-agent-umbrel-teams:v2026.9.7-kai1`

Active/supervised gateway slots:
- default
- fast
- strong
- local
- kai
- autopilot

Additional profile present on disk:
- hermuse

Current profile defaults:
- fast → `mimo-v2.6-flash`
- strong → `mimo-v2.6-pro`
- local → `qwen3-30b-a3b`
- hermuse → `spark-contributor`
- kai → `spark-contributor`
- autopilot → `poolside/laguna-s-2.1:free`

Important:
- `local` profile description still references Qwen 3.8 27B, but the active config points to Qwen3 30B-A3B.
- LiteLLM is the actual model control plane.
- Hermes built-in scheduler currently has no active jobs.
- Hermes supports `--monitor-script`, `--no-agent`, `--continuity`, model/provider pins, and reasoning-effort pins.

## Local model

- llama.cpp service: `qwen-local`
- active model artifact: Qwen3 30B-A3B IQ4_XS
- exposed locally through LiteLLM
- large RAM consumer by design

## Postgres

Server databases:
- `personal_platform`
- `kaizen_intel`
- `litellm`
- `postgres`

Important existing schemas/tables in `personal_platform`:

### commitments
`commitments.commitments`
- 8 rows at audit time
- fields include owner, counterparty, commitment, due_date, confidence, source, source_message_id, status, timestamps

### approvals
- `approvals.approval_requests`
- `approvals.approval_audit_log`

### ai_routing
- `ai_routing.routing_requests`
- `ai_routing.provider_attempts`
- `ai_routing.request_telemetry`
- `ai_routing.escalations`

### refinery
- `refinery.extraction_facts`
- `refinery.reconciliation_runs`

## n8n

Version: 1.80.0

Active workflows:
1. Phase 1 Demo Approval Workflow
2. Forgejo Config Auto-Sync
3. Commitments - Tracking & Management API
4. Site change - GLiNER extract and ntfy
5. Paperless - GLiNER Document Extraction Pipeline

The Commitments workflow is an active webhook/API over the existing commitments table.

Maintenance warnings observed:
- n8n config file permissions are broader than recommended
- task runners are not explicitly enabled

Do not fix these unless they are in the assigned task.

## Memory

### Hindsight
- version 0.10.1
- bank: `personal-memory`
- 451 facts at audit time
- 72 documents
- active writes on 2026-10-01
- auto-consolidation explicitly disabled
- pending consolidation is therefore expected, not an outage

### Qdrant
Collections:
- `documents`
- `kaizen_knowledge`
- `personal_notes`
- `incidents`
- `hermes_observations`

Boundary:
- Hindsight answers "what do I remember?"
- Qdrant answers "what source/reference material says this?"
- Postgres answers "what is the current operational state?"

## Messaging / channels

Verified:
- AgentMail receivers active
- Teams routing/session history exists in Hermes
- WhatsApp bridge active inside Hermes
- TextBee is part of the Hermes tool/skill/MCP setup for reading and sending SMS and belongs in the commitments/follow-up design
- Conduit has NotificationCenter/deep-link notification work already implemented
- ntfy exists in the infrastructure stack

## Networking

Tailscale is active and tailnet-only routes exist for Umbrel and multiple apps.

Private Docker networks intentionally isolate:
- core data plane
- Hindsight/refinery/Qdrant access
- Steel browser
- Kai Graph MCP

## Repositories / source of truth

Primary private config/DR repository:
`/home/umbrel/umbrel-config`

It currently contains:
- Compose definitions
- Hindsight config
- LiteLLM config
- monitoring config
- Qwen config
- Hermes scripts
- Hermes cron definitions
- n8n workflow exports
- Tailscale serve config
- QA/support files

The repo is private and contains live credentials/exported configuration. Never publish it.

## Guardrails inherited from the existing system

- do not over-engineer
- fastest path to working
- do not regress existing services
- QA everything
- preserve rollback paths
- do not modify unrelated Hermes skills
