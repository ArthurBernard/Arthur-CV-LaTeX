# 7 — Roadmap / next steps

This file is the **single source of truth** for open work — read by `/pick-task`,
updated by `/finish-task` / `/abandon-task`. Finished work is *removed* from
here: git log + `CHANGELOG.md` are authoritative for *what* shipped,
`03-decisions.md` for *why*. Keep it short and true.

> Section numbers = working state, freely renumberable. They never appear in
> commits or the CHANGELOG — traceability goes through the PR number. A finished
> task = a deleted line (no "Done" section).
>
> Loop: `/pick-task` → `/plan` → `/execute-leaf` → `/finish-task`.
> Release: `/release` once `[Unreleased]` is full enough.

---

## 1. Correctness & robustness

- [ ] Initialise every header field to empty at class load, so **omitting** a
      field renders nothing instead of erroring. Currently only calling it with
      `{}` is safe. (`02-architecture.md` § Known fragilities)
- [ ] `\RequirePackage{etoolbox}` explicitly — `\ifblank` currently resolves only
      through a transitive dependency — and add it to the README package list.
- [ ] Make `\@sectioncolor` safe for `\section` titles shorter than three tokens
      or starting with a macro/group. Currently it grabs `#1#2#3` blindly.

## 2. Class conformance

- [ ] Move `\ProvidesClass` above `\LoadClass`, turn the stray
      `\usepackage{fontawesome}` into `\RequirePackage`, drop the unused
      `titlesec` / `multirow` / `ragged2e`, and give the classes a real version
      in `\ProvidesClass[...]` (currently frozen at the 2019 creation date).

## 3. API & ergonomics

- [ ] Declare class options for the colour themes so
      `\documentclass[green]{arthur-cv}` replaces copying five `\definecolor`
      lines into the preamble. Needs `\DeclareOption`/`\ProcessOptions`, which
      the class currently lacks entirely.
- [ ] Factor `\makeprofile` into a shared `arthur-cv-header.sty` required by both
      classes — the two copies have already drifted (`0.43` vs `0.45\textwidth`).
- [ ] Provide `cvleft`/`cvright` environments so the side-bar/body widths stop
      living in the user's `.tex`. Removes the "don't touch this if you don't
      know what you're doing" warning from the README.
- [ ] Rename the meaningless colours `yt` and `test` (they are the mail and site
      icon colours) — with backward-compatible aliases.
- [ ] Document `\hlink` and `\capit` in the root README; they exist and are used
      in the examples but are undocumented.

## 4. Maintenance

- [ ] Migrate `fontawesome` (4.7, frozen) to `fontawesome5`.
- [ ] Replace the `$\begin{array}{l}\hspace{Nmm}…\end{array}$` icon-alignment
      hack with `\makebox`.
- [ ] Compress `pictures/*.jpg` — 3.8 MB for README previews, two files above
      1 MB each.
- [ ] Switch the README's image links from absolute `github.com/…/blob/master/…`
      URLs to relative paths, so they render in forks, locally, and off GitHub.
- [ ] Delete the stale `origin/main` branch — fully merged into `master`
      (0 commits ahead) since PR #4.
- [ ] Cut the first tag/release once the above has settled. The repo has been
      stable since 2019 with no version marker at all.
