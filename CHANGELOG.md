# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

The classes carried no version marker before this file existed; history prior to
2026-08-27 lives in the git log only.

## [Unreleased]

### Added

- `examples/minimal_cv.tex` — the smallest CV the template can produce, and the
  regression test for the omitted-field fix below.
- `Makefile` (`make test` / `build` / `lint` / `clean`) compiling every example
  with two `lualatex` passes, plus a page-count assertion per example — the
  layout is absolutely positioned, so a broken change often still compiles.
- GitHub Actions workflow running the same compile on push and pull request.
- Developer brief for Claude Code under `doc/dev/`, repo `CLAUDE.md`, and the
  `.claude/` dev-loop configuration (`workflow.json`, `settings.json`, hook
  copies).

### Changed

### Fixed

- **Omitting a header field no longer errors.** Fields such as `\cvnumberphone`
  were self-redefining macros with no initial value, so leaving one out (rather
  than calling it with `{}`) left a macro still expecting an argument and failed
  with `Argument of \cvnumberphone has an extra }`. Setters now store into
  separate storage macros that start empty. The public API is unchanged.
- `\ifblank` (used by `\subsectionright`) resolved only through a transitive
  dependency; `etoolbox` is now required explicitly and listed in the README.
- `\ProvidesClass` now precedes `\LoadClass`, as LaTeX2e requires, and both
  classes carry a real version instead of their 2019 creation date.
- Both classes used `\usepackage` for `fontawesome`; a class must use
  `\RequirePackage`.

### Deprecated

### Removed

- `ragged2e`, `titlesec` and `multirow` were loaded by the classes but never
  used, and are no longer required.
