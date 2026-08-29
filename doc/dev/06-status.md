# 6 — Current status

A snapshot of what's done, what's in progress, and what's deliberately deferred —
so an agent doesn't re-investigate settled ground or assume a known stub is a bug.

## Done & working

- **`arthur-cv`** — header with optional photo/age/address, grey side bar
  (`\sectionleft`/`\subsectionleft`), body (`\section` + `rightenv` /
  `\subsectionright`), multi-page via `\newcvpage`.
- **`arthur-cover-letter`** — same header, FR and EN address/recipient
  conventions, `coverletter` environment with subject/opening/closing/signing.
- **Five examples** covering both classes, both languages, both conventions and
  the multi-page path. All are the real documents the author uses.
- **Colour theming** by redefining five colours in the user preamble; four ready
  themes (green/red/grey/yellow) documented in the root `README.md`.
- **Dev loop adopted (2026-08-27)** — `develop` branch, `.claude/` config,
  canonical hook copies, this `doc/dev/` pack, `CHANGELOG.md`.

## Known gaps

Ordered by how likely they are to bite someone. Details in
[`02-architecture.md`](02-architecture.md); open items in
[`07-roadmap.md`](07-roadmap.md).

- **Omitting a header field errors cryptically** instead of rendering nothing —
  the fields have no default. Most likely first-run failure for a new user.
- **`\ifblank` used without `etoolbox` loaded** — works only via a transitive
  dependency, and is missing from the README's package list.
- **`\@sectioncolor` eats tokens** on `\section` titles shorter than three
  tokens or starting with a macro/group.
- **The left/right widths are split across the class and the user's `.tex`**, so
  the layout can only be customised by editing numbers in two files.
- **`\makeprofile` is duplicated** across the two classes and has already
  drifted.
- **No page-break support** — overflowing content silently runs off the page.
  This is by design (see `03-decisions.md`), but it is a real usability edge.
- **`fontawesome` 4.7** is frozen upstream.

## Deferred deliberately

- **No reflowing layout.** Absolute positioning is the design; see
  `03-decisions.md`. Not up for revisit without a strong reason.
- **No visual regression testing.** Page-count assertions only — image diffing
  was rejected (`03-decisions.md`).
- **No CTAN submission.** This is a personal template, not a distributed package;
  the naming (`arthur-*`) reflects that.

## Tooling

- `make test` / `make build` / `make lint` / `make clean` (see `CLAUDE.md`).
- GitHub Actions compiles every example on push and PR.
- `.claude/skills/build-cv/` is shipped **for users of the template**, not for
  this repo's own dev loop.
