# Orchestrator Config Guide (OpenCode)

This guide explains how to use and tune `orchestrator-config.opencode.yaml` for production runs.

## 1) Quick Start

1. Copy config:

```bash
cp home/modules/agent/orchestrator/orchestrator-config.opencode.yaml ./orchestrator.yaml
```

2. Set credentials in environment:

```bash
export CTF_USERNAME='your_username'
export CTF_PASSWORD='your_password'
# optional but recommended
export CTF_SESSION_TOKEN='your_session_token'
```

3. Start one master session in OpenCode and load:
- `home/modules/agent/security-agent.md`
- `home/modules/agent/ctf-orchestrator-design.md`
- `home/modules/agent/orchestrator/opencode-integration.md`

4. Ensure Scrapling MCP server name in OpenCode matches `mcp.scrapling.server_name`.

## 2) What to Edit First

- `contest.slug`, `contest.base_url`, start/end times
- `contest.release_windows` (if organizer announced release time)
- `submission.mode` (`print_only` recommended first)
- `scheduler.max_concurrency` (default 3)

## 3) Tuning Profiles

Use `profile` field as your baseline intent:

- `balanced` (default): safe and general usage
- `aggressive`: faster polling and lower timeouts
- `conservative`: lower risk, fewer auto actions

### Suggested knobs

For **aggressive**:
- `collection.polling.normal_interval_sec: 120`
- `stop_rules.hard_timeout_min: 30`
- `stop_rules.no_progress_min: 10`

For **conservative**:
- `submission.mode: print_only`
- `scheduler.max_concurrency: 2`
- `collection.polling.normal_interval_sec: 600`

## 4) Priority Logic Explained

Final score is additive:

- category weight (`crypto`/`reverse` highest)
- solved count contribution (`solved_count_weight` with cap)
- freshness bonus for newly released tasks
- change bonus for hint/attachment updates
- optional spike boost for sudden solve-count increase

This ensures easy/high-signal tasks are solved first while still reacting to updates.

## 5) Hard-Task Cut-Loss

A worker task is paused (cooldown) when any threshold is hit:
- `hard_timeout_min`
- `no_progress_min`
- `max_failed_attempts`

This prevents one hard challenge from blocking the whole contest.

## 6) Submission Strategy

- Start with `submission.mode: print_only`.
- Switch to `auto_submit` only after checking platform response patterns and confidence threshold.
- Keep accepted response keywords in `submission.accepted_status_text`.

## 7) Security Best Practices

- Prefer `CTF_SESSION_TOKEN` for workers (`workers.pass_credentials: token_only`).
- Keep logs redacted (`observability.redact`).
- Do not hardcode credentials in YAML files.

## 8) Common Adjustments by Scenario

### New tasks released on schedule
- Fill `contest.release_windows`.
- Keep `high_freq_before_release_min` and `high_freq_after_release_min` enabled.

### Platform frequently edits hints/attachments
- Keep `collection.change_detection.check_hints/check_attachments = true`.
- Raise `prioritization.change_bonus` values.

### Too many difficult tasks consume time
- Lower `stop_rules.hard_timeout_min`.
- Increase `scheduler.cooldown_min`.
- Keep `max_concurrency` at 3 or lower.

## 9) Validation Checklist

Before contest run:

- [ ] MCP server name matches OpenCode config
- [ ] credentials env vars are exported
- [ ] contest URL and times are correct
- [ ] `submission.mode` is intended
- [ ] queue/events paths are writable

## 10) Related Files

- `home/modules/agent/orchestrator/orchestrator-config.opencode.yaml`
- `home/modules/agent/orchestrator/opencode-integration.md`
- `home/modules/agent/orchestrator/schemas/task.schema.json`
- `home/modules/agent/orchestrator/schemas/event.schema.json`
- `home/modules/agent/orchestrator/state-machine.md`
