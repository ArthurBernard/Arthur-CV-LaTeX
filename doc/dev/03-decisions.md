# 3 — Design decisions & rationale

The *why* behind the structure. The prose below is the *settled* rationale
(standing decisions); the **Decision journal** at the bottom is the running,
dated ADR log.

## Standing decisions

- **Absolute positioning over a flowing layout.** The CV is a poster, not a
  document: a fixed grid gives pixel control over where the grey band, the photo
  and the two columns sit, which a flowing two-column layout cannot. The price is
  that nothing reflows and page breaks are manual (`\newcvpage`). Accepted
  deliberately — a CV is short and hand-calibrated by definition.

- **LuaLaTeX/XeLaTeX only.** `fontspec` + the ClearSans system font rule out
  pdfLaTeX. Worth it: the typography is most of the visual identity.

- **The public API is frozen.** This repo is forked by strangers whose CVs break
  silently if a command changes. New capability ships as new commands; old ones
  get deprecating wrappers, never renames. See `CLAUDE.md`.

- **Examples are the test suite.** There is no sensible unit-test framework for a
  document class. Compiling all five examples exercises every documented command,
  both languages, both conventions, and the multi-page path. Page-count checks
  catch the layout regressions that a clean compile would miss.

- **Colour theming by re-`\definecolor`, historically.** Five named colours are
  defined in the class and the README tells users to redefine them in their
  preamble; the later `\definecolor` wins. It works but is unusual — class
  options are the idiomatic mechanism and are on the roadmap.

## Decision journal

### 2026-08-27 — Adopt the standard dev loop in this repo

**Context.** This repo predates the roadmap → plan → execute → release loop used
in my other repos (Fynance, dccd, Trading_Bot, fynance-research). It had no
`develop` branch, no `CLAUDE.md`, no docs of record, no CHANGELOG, and no way to
verify a change beyond compiling by hand.

**Decision.** Mirror the standard layout: `.claude/workflow.json` +
`settings.json` + copies of the canonical hooks, a repo `CLAUDE.md` carrying the
common-conventions mirror, this `doc/dev/` pack, `CHANGELOG.md`, and a `develop`
branch so Git Flow applies.

**Deviations from the other repos, and why.**

- **No `package_dir` in `workflow.json`.** The other repos point it at their
  top-level Python package. Here the structural code (two `.cls` files) sits at
  the repo root, so no prefix matches. Setting `package_dir: "."` would make
  `pr_decision_guard.py` *silently* inert (it tests `path.startswith("./")`,
  which `git diff --name-only` never produces) and would label the session
  `. workflow`. Omitting the key instead takes the hook's **documented opt-out**
  path — explicit rather than silent. Cost: no automated nag when a PR changes a
  class without an ADR entry; capture relies on the `/finish-task` step.
  *Alternative considered and rejected:* teaching the canonical hook to handle a
  repo-root `package_dir`. That is a global-layer change requiring a resync and a
  commit in four other repos — out of scope for adopting the loop here.
- **`test_cmd` / `lint_cmd` are `make test` / `make lint`** rather than
  pytest/ruff. See the standing decision on examples-as-tests.

### 2026-08-27 — Compiling the examples is the verification gate

**Context.** Nothing in the repo could tell you whether a class edit broke an
example; the committed PDFs were the only evidence, and they were stale.

**Decision.** A `Makefile` compiles every `examples/*.tex` into `build/` with
two `lualatex -halt-on-error` passes, and `make test` additionally asserts each
output's **page count** matches the expected value. Same command runs in CI on
push and PR. Rationale for the page-count assertion: the layout is absolutely
positioned, so a broken change frequently still *compiles* — it just pushes
content off the page or onto a new one. A clean exit code alone is not evidence.

**No `latexmk`.** It is a separate package on Debian and one more thing for a
forker to install. There is no bibliography, index or TOC here — the only reason
a second pass is needed at all is tikz `remember picture` for the grey band and
the photo frame — so a fixed two-pass loop is equivalent and dependency-free.
`chktex` is likewise optional: `make lint` skips loudly without it and CI
enforces it.

**Rejected:** diffing rendered pages against committed reference images. More
faithful, but it makes every intentional cosmetic change a binary-blob churn in
a repo already carrying 3.8 MB of JPEGs.

### 2026-08-27 — Header fields store into private macros

**Context.** `\cvmail` and friends were self-redefining macros:
`\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}`. Calling one replaced it
with its value. But a field never called stayed a *one-argument* macro, so
`\makeprofile`'s `\ifthenelse{\equal{\cvmail}{}}` expanded a macro still hunting
for an argument and died with `Argument of \cvnumberphone has an extra }` — a
message that points nowhere near the actual mistake. Omitting a field is the
obvious thing for a newcomer to do, so this was the most likely first-run
failure.

**Decision.** Split setter from storage: `\cv@declarefield{cvmail}{mail}` builds
the public setter `\cvmail{...}`, which writes into `\cv@mail`. Storage macros
are initialised empty, so an omitted field and a `{}` field are identical.
`\makeprofile` reads the private macros.

**The public API is unchanged** — `\cvmail{...}` still works exactly as
documented, which the frozen-API invariant requires. Verified by rendering every
pre-existing example before and after at 100 dpi: all six pages are
byte-identical PNGs. `examples/minimal_cv.tex` is the regression test; it fails
to compile against the previous class and succeeds against this one.

*Considered and rejected:* keeping the self-redefining idiom and making
`\makeprofile` tolerate an unset one-argument macro. There is no clean way to
test that from `\ifthenelse`, and the fragility would remain for anyone reading
a field directly.
