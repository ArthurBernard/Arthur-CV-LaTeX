# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

The classes carried no version marker before this file existed; history prior to
2026-08-27 lives in the git log only.

## [Unreleased]

### Added

- `Makefile` (`make test` / `build` / `lint` / `clean`) compiling every example
  with two `lualatex` passes, plus a page-count assertion per example — the
  layout is absolutely positioned, so a broken change often still compiles.
- GitHub Actions workflow running the same compile on push and pull request.
- Developer brief for Claude Code under `doc/dev/`, repo `CLAUDE.md`, and the
  `.claude/` dev-loop configuration (`workflow.json`, `settings.json`, hook
  copies).

### Changed

### Fixed

### Deprecated

### Removed
