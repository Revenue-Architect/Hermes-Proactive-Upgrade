# ADR-006 — Prefer n8n/webhooks for deterministic source plumbing

Status: Accepted

## Decision

Use existing webhook/event/n8n plumbing before creating Hermes cron scouts.

## Why

Hermes should reason about meaningful state, not repeatedly perform integration polling that deterministic code can handle.
