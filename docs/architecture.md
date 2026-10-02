# Architecture

```text
EXTERNAL SOURCES
│
├── AgentMail
├── TextBee SMS
├── Teams
├── Calendar
├── Umbrel monitoring
├── Deliveries
├── Bills
└── ChangeDetection
        │
        ▼
NORMALIZATION / INGESTION
        │
        ▼
personal_platform Postgres
├── commitments
├── approvals
├── proactive.events
├── proactive.candidates
├── proactive.goals
├── proactive.activity
├── proactive.notifications
└── proactive.suppressions
        │
        ▼
DETERMINISTIC ELIGIBILITY
        │
        ▼
Hermes monitor-script gate
        │
        ▼
HERMES JUDGE
├── exact state → Postgres
├── memory → Hindsight
├── source evidence → Qdrant
└── model routing → LiteLLM
        │
        ▼
DROP / REMEMBER / IDEA / RESEARCH / ACT / ASK / INTERRUPT
        │
        ├── research worker
        ├── executor
        ├── approval system
        └── notification router
                │
                ├── Conduit
                ├── TextBee
                ├── WhatsApp
                └── ntfy
```

## Design quality bar

The architecture is correct when:
- exact state is inspectable without asking an LLM
- every notification is traceable
- every consequential action is attributable to an approval or policy
- one source replay cannot create duplicate consequences
- agent restart does not lose state
- model change does not require data migration
