# 2 — Architecture

## The layout model: absolute positioning, no reflow

Both classes set zero page margins via `geometry` and place **everything** in
`textpos` `textblock`s at absolute coordinates, with `\TPHorizModule` and
`\TPVertModule` set to 1 cm. Consequences an agent must internalise:

- **Content does not reflow.** There is no page-breaking. If the body overflows,
  it silently runs off the page instead of spilling onto a second one. That is
  why `\newcvpage` exists as a *manual* escape hatch: it emits `\newpage` and
  re-draws the grey band.
- **Every dimension is a hand-tuned magic number**, and several of them must
  agree across *two different files* (see "The fragile seam" below).
- **Vertical rhythm is `\vspace`, not skips.** `\sectionleft`, `\section` and
  friends hard-code `\par\vspace{Nmm}` before and after.

## The three regions

```
┌────────────────────────────────────────────────┐
│ header — \makeprofile                          │  textblock (0.25, 0.25)
│  contact table │ name + job title │ photo      │  photo at (17.25, 0.25)
├──────────────────┬─────────────────────────────┤
│ grey band        │                             │  tikz node, 8cm × 27cm
│ (side bar)       │  body                       │  drawn by \makeprofile
│ \sectionleft     │  \section                   │
│ \subsectionleft  │  rightenv/\subsectionright  │  textblock (0.25, 3.5)
└──────────────────┴─────────────────────────────┘
```

The user's `.tex` opens the `textblock` and the two `minipage`s itself (see any
example); the class only provides the commands used *inside* them.

### Header — `\makeprofile`

A two-`minipage` row: a `tabular` of contact rows on the left, name + job title
on the right, then a separate `textblock` for the photo with a tikz-drawn frame.

Each public setter (`\cvmail{...}`) is built by `\cv@declarefield` and stores
its argument in a private macro (`\cv@mail`) that is **initialised empty**.
`\makeprofile` reads the private macro and guards each row with
`\ifthenelse{\equal{\cv@foo}{}}{}{...}`, so a field that is unset — whether
passed `{}` or omitted entirely — renders nothing.

Two implementation notes:

- The icons are vertically aligned with a `$\begin{array}{l}\hspace{Nmm}…\end{array}$`
  wrapper and a per-icon hand-tuned `\hspace`. It is a hack; a `\makebox` would do.
- **`\makeprofile` is copy-pasted into both classes** and the copies have already
  drifted (`0.43\textwidth` in `arthur-cv`, `0.45` in `arthur-cover-letter`).

### Side bar

`\sectionleft` is a `tcolorbox` (framed, tinted 10 %, drop shadow).
`\subsectionleft` is a one-item `itemize` with tuned `enumitem` spacing.

### Body

`\section` is **`\renewcommand`ed** over `article`'s — it is no longer a
sectioning command (no TOC, no bookmarks, no optional argument, no numbering).

`\subsectionright` is a 6-argument `\newcommandx` with optionals in positions
2/4/5 — an unusual interleaved signature (`{date}[pre]{title}[org][place]{desc}`)
that the README documents by example. It lays out inside `rightenv`, a
`tabular{p{1.6cm} l}` whose second cell is a `\parbox[t]{10.5cm}`.

## The fragile seam

Three widths must agree, and they live in two different files:

| Value | Where | Meaning |
|---|---|---|
| `8cm` | `arthur-cv.cls`, tikz band | grey band width |
| `0.37\textwidth` / `0.61\textwidth` | **the user's `.tex`** | side bar / body minipages |
| `10.5cm` | `arthur-cv.cls`, `\subsectionright` | body text wrap width |

Change one without the others and the layout silently breaks. This is why the
root README says *"don't custom textblock and minipage … if you don't know what
you are doing"*. Factoring these into class-provided environments is on the
roadmap.

## Known fragilities (read before touching)

- **`\@sectioncolor`** colours a title's first **three tokens** in `maincolor`
  by grabbing `#1#2#3`. A title shorter than three tokens, or starting with a
  group/macro, eats the tokens that follow. All current examples have long
  titles, so it never fires.
- **`\subsectionleft` takes two *mandatory* arguments**, but the examples often
  pass one. That works only by accident: `\newcommand` builds `\long` macros, so
  the `\par` from the following blank line silently becomes the second argument.
  Pass `{}` explicitly.
- **No class options** are declared (`\DeclareOption`/`\ProcessOptions` are
  absent), so colour themes can only be applied by re-`\definecolor`ing in the
  user preamble.
- **`fontawesome`** is FontAwesome 4.7, frozen upstream; `fontawesome5` exists.
