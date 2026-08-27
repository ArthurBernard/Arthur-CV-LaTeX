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

The `cvbody` / `cvleft` / `cvright` environments open the `textblock` and the two
`minipage`s; the document only supplies the content. Documents written before
those existed open them by hand, which still works — see
`Arthur_Bernard_CV_En.tex` for that form and `example_cv.tex` for the new one.

### Header — `\makeprofile`

A two-`minipage` row: a `tabular` of contact rows on the left, name + job title
on the right, then a separate `textblock` for the photo with a tikz-drawn frame.

Each public setter (`\cvmail{...}`) is built by `\cv@declarefield` and stores
its argument in a private macro (`\cv@mail`) that is **initialised empty**.
`\makeprofile` reads the private macro and guards each row with
`\ifthenelse{\equal{\cv@foo}{}}{}{...}`, so a field that is unset — whether
passed `{}` or omitted entirely — renders nothing.

`\makeprofile` itself lives in **`arthur-cv-header.sty`**, required by both
classes; each class composes it from `\cv@headerblock{<tb width>}{<name width>}`
and `\cv@photoblock`, and fills the `\cv@headerextra` hook (address + age for
the CV, empty for the letter). The grey band is drawn by `arthur-cv.cls` alone.

Two implementation notes:

- **The two space tokens between the contact column and the name column are
  load-bearing.** The header row is set flush, so collapsing them to one shifts
  the name 2.69 pt left. `arthur-cv-header.sty` says so at the call site.
- The icons are vertically aligned with a `$\begin{array}{l}\hspace{Nmm}…\end{array}$`
  wrapper and a per-icon hand-tuned `\hspace`. It is a hack; a `\makebox` would do.

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

## The width seam

Three widths must agree:

| Value | Where | Meaning |
|---|---|---|
| `8cm` | `arthur-cv.cls`, tikz band | grey band width |
| `\cvleftwidth` / `\cvrightwidth` (`0.37` / `0.61`) | `arthur-cv-header.sty` | side bar / body minipages |
| `10.5cm` | `arthur-cv.cls`, `\subsectionright` | body text wrap width |

These now all live in the package, so a document using `cvbody`/`cvleft`/
`cvright` cannot desynchronise them. A document using the older explicit
`minipage` form still hard-codes `0.37`/`0.61` itself and can.

## Known fragilities (read before touching)

- **`\@sectioncolor`** colours a title's first **three tokens** in `maincolor`
  by grabbing `#1#2#3`. A title shorter than three tokens, or starting with a
  group/macro, eats the tokens that follow. All current examples have long
  titles, so it never fires.
- **`\subsectionleft` takes two *mandatory* arguments**, but the examples often
  pass one. That works only by accident: `\newcommand` builds `\long` macros, so
  the `\par` from the following blank line silently becomes the second argument.
  Pass `{}` explicitly.
- **`fontawesome`** is FontAwesome 4.7, frozen upstream; `fontawesome5` exists.
