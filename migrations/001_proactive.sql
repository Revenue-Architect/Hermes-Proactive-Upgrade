BEGIN;

CREATE SCHEMA IF NOT EXISTS proactive;

CREATE TABLE IF NOT EXISTS proactive.events (
    id UUID PRIMARY KEY,
    domain TEXT NOT NULL,
    entity_key TEXT NOT NULL,
    event_type TEXT NOT NULL,
    summary TEXT NOT NULL,
    details JSONB NOT NULL DEFAULT '{}'::jsonb,
    evidence_hash TEXT NOT NULL,
    source TEXT NOT NULL,
    source_ref TEXT,
    occurred_at TIMESTAMPTZ,
    observed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    expires_at TIMESTAMPTZ,
    origin TEXT NOT NULL DEFAULT 'external',
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS proactive_events_source_ref_evidence_uidx
ON proactive.events (source, source_ref, evidence_hash)
WHERE source_ref IS NOT NULL;

CREATE INDEX IF NOT EXISTS proactive_events_entity_idx
ON proactive.events (domain, entity_key, observed_at DESC);

CREATE TABLE IF NOT EXISTS proactive.candidates (
    id UUID PRIMARY KEY,
    domain TEXT NOT NULL,
    entity_key TEXT NOT NULL,
    candidate_type TEXT NOT NULL,
    summary TEXT NOT NULL,
    why_now TEXT,
    evidence JSONB NOT NULL DEFAULT '[]'::jsonb,
    evidence_hash TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    judgment TEXT,
    judgment_reason TEXT,
    priority INTEGER,
    first_seen_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    expires_at TIMESTAMPTZ,
    recheck_at TIMESTAMPTZ,
    research_depth INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT proactive_candidate_research_depth_chk CHECK (research_depth >= 0 AND research_depth <= 2)
);

CREATE UNIQUE INDEX IF NOT EXISTS proactive_candidates_identity_uidx
ON proactive.candidates (domain, entity_key, candidate_type);

CREATE INDEX IF NOT EXISTS proactive_candidates_status_idx
ON proactive.candidates (status, updated_at DESC);

CREATE TABLE IF NOT EXISTS proactive.goals (
    id UUID PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    status TEXT NOT NULL,
    desired_outcome TEXT,
    state JSONB NOT NULL DEFAULT '{}'::jsonb,
    next_review_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS proactive.goal_links (
    goal_id UUID NOT NULL REFERENCES proactive.goals(id) ON DELETE CASCADE,
    candidate_id UUID NOT NULL REFERENCES proactive.candidates(id) ON DELETE CASCADE,
    relationship TEXT NOT NULL,
    PRIMARY KEY (goal_id, candidate_id)
);

CREATE TABLE IF NOT EXISTS proactive.activity (
    id UUID PRIMARY KEY,
    candidate_id UUID REFERENCES proactive.candidates(id) ON DELETE SET NULL,
    goal_id UUID REFERENCES proactive.goals(id) ON DELETE SET NULL,
    actor TEXT NOT NULL,
    action_type TEXT NOT NULL,
    summary TEXT NOT NULL,
    status TEXT NOT NULL,
    details JSONB NOT NULL DEFAULT '{}'::jsonb,
    started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    completed_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS proactive_activity_candidate_idx
ON proactive.activity (candidate_id, started_at DESC);

CREATE TABLE IF NOT EXISTS proactive.notifications (
    id UUID PRIMARY KEY,
    candidate_id UUID REFERENCES proactive.candidates(id) ON DELETE SET NULL,
    domain TEXT,
    entity_key TEXT,
    evidence_hash TEXT,
    channel TEXT NOT NULL,
    delivery_type TEXT NOT NULL,
    content TEXT,
    status TEXT NOT NULL,
    idempotency_key TEXT NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    delivered_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS proactive_notifications_candidate_idx
ON proactive.notifications (candidate_id, created_at DESC);

CREATE TABLE IF NOT EXISTS proactive.suppressions (
    id UUID PRIMARY KEY,
    domain TEXT,
    entity_key TEXT,
    reason TEXT NOT NULL,
    suppress_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS proactive_suppressions_lookup_idx
ON proactive.suppressions (domain, entity_key, suppress_until);

COMMIT;
