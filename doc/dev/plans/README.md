# Plan trees — durable, hierarchical task plans

This directory holds **active plan trees**: the durable, file-based expansion of a
roadmap item into an executable plan. It is **tracked in git** (committed via the
"plan PR" — see below). Finished trees move to `../_archive/plans/`, which is
**gitignored** (local reference only; git log + `CHANGELOG.md` stay authoritative
for what shipped). This file is the canonical reference for the format — the
`/plan`, `/execute-leaf` and `/finish-task` skills read and write it.

## Why this exists

`plan mode` writes to `~/.claude/plans/*.md` (outside the repo), so a plan is lost
on `/compact`. And when a task splits into sub-tasks, nothing recorded *whether we
were planning one slice or the whole set*. Plan trees fix both: plans are
**committed to the repo** (durable, reviewable, visible to every later branch) and
**hierarchical** (a global map + precise leaves).

## Layout

```
doc/dev/plans/<epic-slug>/
  00-plan.md            # global: goal, decomposition, leaf checklist, deps
  01-<leaf-slug>.md     # leaf: precise, agent-executable spec
  02-<leaf-slug>.md
  ...
```

**Depth is adaptive — never forced.**

- Trivial task → a *single* leaf file, **no global** `00-plan.md`.
- Normal task → a global `00-plan.md` + N leaves.
- A leaf still too big → it gets its own sub-directory with its own `00-plan.md`
  and sub-leaves (recursion). The **deepest level must be precise enough that an
  agent executes it without re-deciding anything.**

## Lifecycle

```
/pick-task → /plan (build tree + open "plan PR" → develop)
  → merge plan PR
  → /execute-leaf <epic> next   (model from `complexity`, spawn agent, verify)
  → /finish-task                (tests, ADR, PR, archive leaf, tick global)
  → … repeat per leaf (deps respected; `parallel` leaves may run concurrently)
  → last leaf → roadmap line removed, global done → /release
```

The **plan PR lands the tree on `develop` first**, so every leaf branch cut later
already contains `doc/dev/plans/<epic>/`.

## Frontmatter

### Global `00-plan.md`
```yaml
---
plan: <epic-slug>
kind: global
status: planning | executing | done
roadmap: "<verbatim roadmap line this expands>"   # link back to 07-roadmap.md
release_on_done: true            # completing the global suggests /release
---
```
Body sections: **Goal**, **Decomposition** (numbered leaf list, one-line intent
each), **Leaf checklist** (`- [ ] 01 <slug> — <branch> — <complexity>`),
**Dependencies** (`02 depends on 01`), **Done criteria**.

### Leaf `NN-<slug>.md`
```yaml
---
plan: <epic-slug>/NN-<slug>
kind: leaf
status: planned | executing | done | abandoned
complexity: low | medium | high   # → haiku | sonnet | opus
model: <optional override>
depends: [01]                     # leaf numbers that must be done first; [] = independent
parallel: false                   # true = may run in a worktree alongside siblings
branch: <type>/<topic>
pr: "#NN"                         # filled in by /finish-task
---
```
Mandatory body sections (this precision is what makes agent handoff safe):

- **Goal** — 1–2 lines.
- **Files to change** — exact paths + what changes in each.
- **Steps** — precise enough to execute without re-deciding.
- **Tests** — what to add or modify.
- **Verification on real data** — the [`data-e2e`](../../../.claude/skills/data-e2e/)
  discipline; **mandatory** for any data-path leaf (run the real operation, read
  what landed on disk, compare it to what was requested — a green unit suite is not
  enough; see [`05-testing.md`](../05-testing.md)).
- **Closeout** — the CHANGELOG line text; an ADR note if a non-trivial decision was
  made; the status/roadmap edits to apply.

## Complexity → execution model

The spawned agent's model is derived from the leaf's `complexity` (overridable via
`model:`), mirroring the advisory table in [`../../../CLAUDE.md`](../../../CLAUDE.md):

| `complexity` | model | for |
|--------------|--------|-----|
| `low` | `haiku` | mechanical fan-out — doc scans, checklists, trivial edits |
| `medium` | `sonnet` | straightforward implementation against a precise spec |
| `high` | `opus` | judgement, design, cross-cutting changes |

## Dependencies & parallelism

- `depends:` lists the leaf numbers that must reach `status: done` first.
- `/execute-leaf <epic> next` picks the lowest-numbered `planned` leaf whose
  `depends` are all satisfied.
- Leaves marked `parallel: true` (with deps met) may be spawned **concurrently** in
  isolated git worktrees; everything else runs **serially in the main worktree** —
  the safe default.

## Templates

### `00-plan.md`
```markdown
---
plan: <epic-slug>
kind: global
status: planning
roadmap: "<paste the roadmap line>"
release_on_done: true
---

# <Epic title>

## Goal
<one paragraph — what "done" looks like>

## Decomposition
1. **<leaf-slug>** — <one-line intent>
2. **<leaf-slug>** — <one-line intent>

## Leaf checklist
- [ ] 01 <leaf-slug> — feat/<topic> — medium
- [ ] 02 <leaf-slug> — feat/<topic> — high (depends on 01)

## Dependencies
- 02 depends on 01

## Done criteria
- <observable, verifiable conditions>
```

### `NN-<slug>.md`
```markdown
---
plan: <epic-slug>/NN-<slug>
kind: leaf
status: planned
complexity: medium
depends: [01]
parallel: false
branch: feat/<topic>
pr: ""
---

# <Leaf title>

## Goal
<1–2 lines>

## Files to change
- `path/to/file.py` — <what>

## Steps
1. <precise step>
2. <precise step>

## Tests
- `dccd/tests/v3/test_<x>.py` — <what to assert>

## Verification on real data
- <run the real op; read what landed; compare to requested>

## Closeout
- CHANGELOG (`Added`/`Fixed`/…): "<entry text> (#NN)"
- ADR: <decision + why, or "none — mechanical">
- Status/roadmap: <edits, or "deferred to last leaf">
```
