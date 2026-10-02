# ADR-002 — Separate exact state, memory, and evidence

Status: Accepted

## Decision

- Postgres = exact operational state
- Hindsight = personal/episodic memory
- Qdrant = source/reference retrieval

## Why

These stores answer different questions and should not compete.

## Consequence

No action/dedupe/approval decision may rely solely on vector or memory recall.
