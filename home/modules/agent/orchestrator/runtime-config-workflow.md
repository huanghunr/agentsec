# Runtime Config Workflow (No Nix Rebuild Required)

If you do not want to edit repository files for each contest, use runtime config generation.

## Why this works

- Nix-managed files in the repo remain unchanged.
- Contest-specific config is generated under user state path:
  - `~/.local/state/agentsec/orchestrator/<contest>.yaml`
- You can give contest info directly to AI, and AI runs one command to generate config.

## Command

```bash
python home/modules/agent/orchestrator/scripts/bootstrap_runtime_config.py \
  --contest-slug "tsgctf-2026" \
  --platform "ctfd" \
  --base-url "https://ctf.example.com" \
  --start-time "2026-04-01T00:00:00Z" \
  --end-time "2026-04-03T00:00:00Z" \
  --release-window "2026-04-01T12:00:00Z" \
  --submission-mode "print_only"
```

The script prints the generated config path.

## AI-first usage pattern

1. You provide to AI:
   - platform URL
   - contest slug
   - start/end time
   - optional release windows
   - preferred submission mode
2. AI executes the script above.
3. AI starts orchestrator using that runtime config path.

## Tunable flags

- `--submission-mode`: `print_only` or `auto_submit`
- `--max-concurrency`: capped at 3 by script policy
- `--release-window`: repeat this flag for multiple windows
- `--output`: optional custom path

## Security note

Credentials should still be supplied via environment variables:

- `CTF_USERNAME`
- `CTF_PASSWORD`
- `CTF_SESSION_TOKEN` (preferred for workers)

Do not store plaintext passwords inside generated YAML.
