# Security and Approval Model

## Action classes

A — read/search/inspect/summarize  
B — draft/prepare/calculate/stage  
C — reversible low-impact  
D — external/consequential  
E — financial/security/high-risk

## V1 policy

A: automatic  
B: automatic  
C: explicit allowlist only  
D: approval required  
E: explicit approval always

## Existing approvals

Reuse:
- `approvals.approval_requests`
- `approvals.approval_audit_log`

## Failure behavior

If approval state is ambiguous:
do not execute.

If external action outcome is ambiguous:
do not blindly retry.

First determine whether the first attempt succeeded.

## Secrets

Never pass raw credentials into model context.

Prefer:
- environment variables
- MCP/tool isolation
- service-local secret storage
- redacted diagnostics
