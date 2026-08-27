#!/usr/bin/env python3
"""SessionStart hook — cheap orientation.

Prints the current branch, the number of open roadmap tasks, and the most recent
dated decision-journal entry. Stdout is injected into the session context by
Claude Code. Reads paths from .claude/workflow.json; degrades gracefully if the
descriptor or any target file is missing (prints what it can, never errors out).
"""
from __future__ import annotations

import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]  # .claude/hooks/ -> repo root


def _cfg() -> dict:
    p = ROOT / ".claude" / "workflow.json"
    try:
        return json.loads(p.read_text())
    except Exception:
        return {}


def _branch() -> str:
    try:
        out = subprocess.run(
            ["git", "branch", "--show-current"],
            cwd=ROOT, capture_output=True, text=True, timeout=5,
        )
        return out.stdout.strip() or "(detached)"
    except Exception:
        return "?"


def main() -> None:
    cfg = _cfg()
    label = cfg.get("package_dir", ROOT.name)
    lines = [f"{label} workflow — branch: {_branch()}"]

    roadmap_rel = cfg.get("roadmap", "doc/dev/07-roadmap.md")
    roadmap = ROOT / roadmap_rel
    if roadmap.exists():
        open_n = len(re.findall(r"(?m)^\s*- \[ \] ", roadmap.read_text()))
        lines.append(f"open roadmap tasks: {open_n}  ({roadmap_rel})")

    decisions = ROOT / cfg.get("decisions", "doc/dev/03-decisions.md")
    if decisions.exists():
        # Journal is newest-first; dated entries are h3 `### YYYY-MM-DD …`.
        m = re.search(r"(?m)^### (\d{4}-\d{2}-\d{2} .+)$", decisions.read_text())
        if m:
            lines.append(f"last decision: {m.group(1)}")

    print("\n".join(lines))


if __name__ == "__main__":
    main()
