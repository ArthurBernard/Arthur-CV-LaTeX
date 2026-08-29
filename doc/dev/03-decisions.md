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

- **Colour theming by class option, with the preamble override kept.** Themes
  are `\DeclareOption`s that pick a palette; because `\definecolor` is
  last-one-wins and the user preamble is read after the class, redefining the
  colours by hand still overrides the theme. Both routes are documented.

## Decision journal

### 2026-08-27 — Shared header package and layout environments

**Context.** `\makeprofile` was copy-pasted into both classes and the copies had
drifted (name column `0.43\textwidth` in the CV, `0.45` in the letter). Separately,
the side-bar/body widths lived in the *document*, while widths they had to agree
with lived in the class — the reason the README warned people off touching them.

**Decision.** `arthur-cv-header.sty`, required by both classes, holds the field
declarations, the contact column, the name column and the photo block. The four
genuine differences are parameters: the grey band (drawn by `arthur-cv` only),
the header-block width, the name-column width, and the `\cv@headerextra` hook.
The drift is preserved as data rather than "fixed", because changing either
number would move a real document.

The same package adds `cvbody` / `cvleft` / `cvright`, which own `\cvleftwidth`
and `\cvrightwidth`. The explicit form still works — the API is frozen — so the
examples deliberately cover **both**: `example_cv.tex` uses the environments,
the three real CVs keep the explicit form.

**Verification.** Every example renders byte-identically at 100 dpi before and
after, including `example_cv.tex` *after* converting it to the new environments.
That is the whole claim: a pure refactor plus an additive API.

**One trap worth knowing.** The original inline code had **two** space tokens
between the contact and name minipages. The header row is set flush, so
collapsing them to one moves the name 2.69 pt left — which is exactly what the
first attempt did, caught by the pixel comparison and not by the compile. The
trailing newlines in the two column macros are load-bearing and commented as
such.

### 2026-08-27 — Colour themes become class options

**Context.** The four extra themes existed only as five `\definecolor` lines to
copy out of the README. The classes declared no options at all — no
`\DeclareOption`, no `\ProcessOptions` — so there was no mechanism to offer.

**Decision.** Declare `blue`/`green`/`red`/`grey`/`gray`/`yellow` as class
options selecting a palette, with `\DeclareOption*` forwarding everything else
to `article` and `\ProcessOptions\relax` before `\LoadClass`. Same option names
on both classes so a CV and its letter match.

**Backward compatibility is the whole constraint** (frozen public API). Verified
three ways: every existing example renders byte-identically under the default
theme; `[11pt]` still reaches `article`; and a preamble that redefines the five
colours to the README's yellow values renders **byte-identically to
`[yellow]`** — so the palettes are faithful and the old route still wins.

*Note:* the letter has no grey band and no `thirdcolor`, so its palettes carry
four slots against the CV's five. Same option names, different arity — kept
deliberately rather than inventing unused colours for the letter.

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
