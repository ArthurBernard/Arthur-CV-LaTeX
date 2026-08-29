#!/usr/bin/env python3
"""PreToolUse(Bash) safety net for `gh pr create`.

If the branch changes structural code under <package_dir>/ (excluding tests) but
adds no entry to the decision journal (<decisions>), ask the user to confirm
before the PR is opened. This is only a net — the real capture is the
`/finish-task` decision step; here we just make the omission visible.

Emits a PreToolUse "ask" decision (human confirms / overrides) rather than a hard
deny, so a genuinely decision-free PR isn't deterministically blocked. No-op for
any command other than `gh pr create`, or if the project doesn't declare both a
`package_dir` and a `decisions` path in .claude/workflow.json.
"""
from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def _allow() -> None:
    """Exit without influencing the decision."""
    sys.exit(0)


def main() -> None:
    try:
        payload = json.load(sys.stdin)
    except Exception:
        _allow()

    cmd = (payload.get("tool_input") or {}).get("command", "")
    if "gh pr create" not in cmd:
        _allow()

    try:
        cfg = json.loads((ROOT / ".claude" / "workflow.json").read_text())
    except Exception:
        _allow()

    pkg = cfg.get("package_dir")
    base = cfg.get("base_branch", "develop")
    decisions = cfg.get("decisions")
    if not pkg or not decisions:
        _allow()  # project hasn't opted into the guard

    try:
        changed = subprocess.run(
            ["git", "diff", f"{base}...HEAD", "--name-only"],
            cwd=ROOT, capture_output=True, text=True, timeout=10,
        ).stdout.split()
    except Exception:
        _allow()

    def is_structural(path: str) -> bool:
        name = path.rsplit("/", 1)[-1]
        return (
            path.startswith(f"{pkg}/")
            and "/tests/" not in path
            and not name.startswith("test_")
        )

    touched_code = any(is_structural(p) for p in changed)
    if touched_code and decisions not in changed:
        reason = (
            f"This branch changes structural code under {pkg}/ but adds no entry "
            f"to {decisions}. Capture the *why* (the /finish-task decision step) "
            f"before opening the PR — or confirm this PR genuinely needs no "
            f"decision entry."
        )
        print(json.dumps({
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "permissionDecision": "ask",
                "permissionDecisionReason": reason,
            }
        }))
        sys.exit(0)

    _allow()


if __name__ == "__main__":
    main()
