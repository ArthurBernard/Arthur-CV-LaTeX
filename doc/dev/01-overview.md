# 1 — Overview

## What this is

Two LaTeX document classes for job applications, plus runnable examples:

- **`arthur-cv`** — a one- or multi-page CV on a fixed two-column layout: a grey
  side bar (skills, languages, interests) and a body (experience, education).
  Compiled with LuaLaTeX.
- **`arthur-cover-letter`** — a matching cover letter sharing the CV's header,
  with FR and EN address/recipient conventions (which side the sender and the
  recipient sit on differs between the two).

It is a **public template**: the point is for strangers to fork it and fill it
in. The `\cv*` commands documented in the root `README.md` are the product's
public API — see the invariants in `CLAUDE.md`.

## Repo map

```
arthur-cv.cls              # the CV class (~275 lines)
arthur-cover-letter.cls    # the cover-letter class (~245 lines)
examples/                  # 5 .tex + committed reference .pdf
  example_cv.tex           #   minimal skeleton (John Doe)
  example_cover_letter.tex #   minimal letter
  Arthur_Bernard_CV_En.tex #   real EN CV — no photo/age/address
  Arthur_Bernard_CV_Fr.tex #   real FR CV — with photo/age/address
  Two_Pages_CV.tex         #   exercises \newcvpage
pictures/                  # README previews + the profile photo
README.md                  # end-user documentation
```

## Public API surface

Header (both classes): `\profilepic` `\cvname` `\cvlinkedin` `\cvgithub`
`\cvmail` `\cvnumberphone` `\cvjobtitle` `\cvsite`, plus `\cvaddress`
`\cvyearsold` (CV only). Rendered by `\makeprofile`.

CV body: `\sectionleft{title}` and `\subsectionleft{item}{desc}` for the side
bar; `\section{title}` and, inside a `rightenv` environment,
`\subsectionright{date}[pre]{title}[org][place]{desc}` for the body;
`\newcvpage` to start another page.

Cover letter: `\address`/`\recipient`/`\location` (EN) and
`\addressfr`/`\recipientfr`/`\locationfr` (FR); the `coverletter` environment
with `\subject` `\opening` `\closing` `\signing`; helpers `\capit` (small-caps
surname) and `\hlink` (coloured italic link) — the last two are undocumented in
the root README.

Theming: five colours (`leftcolorband`, `boxcolor`, `maincolor`, `secondcolor`,
`thirdcolor`) that the user re-`\definecolor`s in their own preamble.

## Toolchain

LuaLaTeX (preferred) or XeLaTeX — `fontspec` rules out pdfLaTeX. Dependencies
are listed in the root `README.md`; on Debian/Ubuntu the install command is in
`CLAUDE.md`. `make test` compiles every example and is the entire test suite.

## Current state (snapshot)

Stable and in real use (the author's own CV and cover letter are two of the
examples). Last functional change was `\newcvpage` (multi-page support). The
classes carry no version number yet and the repo has no tags; `CHANGELOG.md`
starts from the adoption of this dev loop.
