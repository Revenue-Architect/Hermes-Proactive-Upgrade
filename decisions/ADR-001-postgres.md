# ADR-001 — Use existing `personal_platform` Postgres

Status: Accepted

## Decision

Add a `proactive` schema to existing `personal_platform`.

## Why

The live system already uses Postgres for:
- commitments
- approvals
- routing
- refinery state
- n8n data

A new SQLite database would fragment state and backups.

## Rejected

Standalone `proactive.db`.
