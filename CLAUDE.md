# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

> **Claude-oriented developer brief**: [`doc/dev/`](doc/dev/) is an orientation
> pack written for Claude Code — overview, the class architecture, design
> decisions & rationale, and current status. Start at
> [`doc/dev/README.md`](doc/dev/README.md). `CLAUDE.md` stays authoritative for
> commands and invariants.

## What this repo is

Two LaTeX document classes — `arthur-cv` (a two-column CV: grey side bar +
body) and `arthur-cover-letter` (matching cover letter) — plus runnable
examples under `examples/`. It is a **template meant to be forked and filled
in by other people**, so the public API (the `\cv*` commands documented in
`README.md`) is the product. Breaking it breaks strangers' CVs.

## Common conventions

<!-- mirror of ~/.claude/CLAUDE.md — synced 2026-08-27 -->

Shared across my repos, mirrored from `~/.claude/CLAUDE.md` (the single source of
truth — if they ever disagree, the global file wins). Restated here so the repo
stays self-contained:

- **Git Flow** — `master` (tagged releases) ← `develop` (integration) ←
  `feat|fix|chore|docs/<topic>`. **Never commit directly to `develop` or `master`**
  — always a feature branch + PR into `develop`; `develop` → `master` only at release.
- **Conventional Commits** — `feat:` `fix:` `chore:` `docs:`. **Never add
  `Co-Authored-By` trailers** (personal repo).
- **One PR = one concern**, small and disposable — a big plan ships as several small
  atomic PRs, never one catch-all branch.
- **Model: session model for judgement, tiered execution** — sessions,
  orchestration and the judgement skills run on the session model (set in
  `~/.claude/settings.json`); plan-leaf execution runs at the tier derived from
  the leaf's `complexity` (`low→haiku / medium→sonnet / high→session model`),
  escalating one tier on failed tests/verification.
- **English only** in all code content: comments, docstrings, log/user messages,
  identifiers. (Chat prose may be French; code is English.)
- **Before every commit** — `make test` and `make lint` must pass.

## Commands

```bash
# One-off toolchain install (Debian/Ubuntu)
sudo apt install -y texlive-luatex texlive-latex-extra texlive-latex-recommended \
                    texlive-fonts-extra texlive-pictures texlive-lang-french
sudo apt install -y poppler-utils   # pdfinfo, for the page-count assertion
sudo apt install -y chktex          # optional: `make lint` skips without it

# Compile every example into build/ — this is the test suite
make test

# Same thing, but keep going after a failure and print a summary
make build

# Compile one example
make build/example_cv.pdf

# Lint the sources (chktex)
make lint

# Remove build artifacts
make clean
```

There is no unit-test framework: **compiling every example is the test suite.**
A change to a `.cls` is verified when all examples still compile *and* their
page count is unchanged (`make test` checks both). There is deliberately no
`latexmk` dependency — two `lualatex` passes are enough (the only thing needing
a second pass is tikz `remember picture`).

## Invariants — do not regress

1. **The documented public API is frozen.** Every command in `README.md`
   (`\cvname`, `\cvmail`, `\sectionleft`, `\subsectionright`, `\newcvpage`, …)
   must keep working with the exact signature documented there. People have
   forked this repo; a renamed command silently breaks their CV. Add new
   commands, deprecate old ones with a wrapper — never rename in place.
2. **Examples are the contract.** `examples/*.tex` must compile with an
   unmodified class. If a change needs an example edit, the change is
   API-breaking — reconsider it.
3. **The two classes must render an identical header.** `\makeprofile` is
   currently copy-pasted into both `.cls` files and the copies have already
   drifted (`0.43` vs `0.45\textwidth`). Until that is factored out
   (`07-roadmap.md`), any header edit must be applied to **both** files.
4. **Compile with LuaLaTeX** (or XeLaTeX). `fontspec` makes pdfLaTeX
   impossible; don't add anything that assumes pdfLaTeX.
5. **No page-count surprises.** The layout is absolutely positioned
   (`textpos`), so content does not reflow. A class change that shifts a
   one-page CV to two pages is a regression, not a cosmetic diff.

## Dev loop & docs of record

The iterative loop is tooled by user-level skills, with four tracked docs as the
sources of truth:

| Doc | Holds | Updated by |
|-----|-------|-----------|
| `doc/dev/07-roadmap.md` | open work — single source *index* | `/pick-task` reads · `/finish-task`, `/abandon-task` update |
| `doc/dev/plans/<epic>/` | open work *detail* — durable plan trees | `/plan` writes · `/execute-leaf` reads · `/finish-task` archives |
| `doc/dev/03-decisions.md` | the *why* — ADR journal | `/finish-task` (accepted), `/abandon-task` (rejected/tombstone) |
| `doc/dev/06-status.md` | where things stand | `/finish-task`, `/groom-docs` |

`CHANGELOG.md` + git log stay authoritative for *what* shipped. The loop:

`/pick-task` → `/plan` → `/execute-leaf <epic> next` → `/finish-task` → …
per leaf … → `/release`. `/abandon-task` salvages the lesson + closes a bad PR;
`/groom-docs` keeps `doc/dev/` lean and true.

**Note on the hooks**: `.claude/hooks/` holds copies of the canonical hooks in
`~/.claude/hooks/` (never edit the copies — edit the canon, then
`sync-claude-hooks --apply`). `pr_decision_guard.py` is **inert here by
design**: it keys off `package_dir`, which this repo does not declare because
the classes sit at the repo root rather than in a package directory. Capturing
the *why* therefore relies on the `/finish-task` decision step alone.

## Skill shipped to users

`.claude/skills/build-cv/` is **published in this repo for the people who fork
it** — it walks a stranger through filling in the template. It is not part of
my own dev loop. Treat it as user-facing documentation: keep it in sync with
the public API above.
