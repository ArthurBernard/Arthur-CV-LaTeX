# Arthur-CV-LaTeX — developer brief (for Claude Code)

This folder is an **orientation pack written for Claude Code** (not end users).
Its job is to give an agent a fast, faithful overview of the repository: what
exists, how it fits together, why it was built that way, and what is and isn't
done. End-user docs live in the repo-root `README.md`; the authoritative working
rules live in the repo-root `CLAUDE.md`.

> **Relationship to `CLAUDE.md`**: `CLAUDE.md` is the source of truth for
> *commands and the hard invariants you must not regress*. This folder is the
> *narrative and depth* around it — rationale, per-area detail, current status.
> When the two disagree, trust `CLAUDE.md` and fix this folder.

## Read in this order

1. [`01-overview.md`](01-overview.md) — what the template is, who uses it, the
   repo map, the public API surface.
2. [`02-architecture.md`](02-architecture.md) — how the two classes are built:
   the absolute-positioning layout model, the header, the left/right blocks, and
   where the fragile seams are.
3. [`03-decisions.md`](03-decisions.md) — the design choices and *why*, plus the
   running ADR journal.
4. [`06-status.md`](06-status.md) — what works, known gaps, deferred work.
5. [`07-roadmap.md`](07-roadmap.md) — open work.

## Tools kept here

- [`plans/`](plans/) — **active plan trees** (durable, hierarchical task plans).
  Each roadmap item being worked on expands into a `plans/<epic>/` tree that
  drives `/plan` → `/execute-leaf` → `/finish-task`. See
  [`plans/README.md`](plans/README.md). Tracked in git; finished trees move to
  `_archive/plans/`, which is gitignored.

## Conventions for keeping this current

- This is descriptive, not aspirational: write what the repo **is**, not what it
  should become. Open work goes in `07-roadmap.md` and its executable expansion
  in `plans/`; history stays in git / `CHANGELOG.md`; the *why* in
  `03-decisions.md`.
