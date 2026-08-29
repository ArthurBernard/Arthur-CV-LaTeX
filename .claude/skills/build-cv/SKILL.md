---
name: build-cv
description: Use this skill to build a CV or a cover letter from the arthur-cv LaTeX template — gather the person's details, pick the right language convention and colour theme, generate their .tex from the closest example, compile it, and fix the silent-overflow problem this template has. Triggers on "/build-cv", "make my CV", "build my resume from this template", "write my cover letter", "fais mon CV", "construis mon CV avec ce template".
---

# Build a CV from this template

Turns a conversation into a compiled, one-page PDF using the `arthur-cv` /
`arthur-cover-letter` classes in this repo. The user supplies facts; you handle
LaTeX, layout and the one thing that reliably goes wrong (overflow).

**Read `README.md` at the repo root for the full command reference** before
generating anything — this skill covers the *process*, the README covers the
*API*.

## The one thing you must internalise

This template is **absolutely positioned**. Content does not reflow and page
breaks are not automatic. If someone's experience section is too long it does
**not** spill onto page 2 — it runs off the bottom of the page and **the
compile still succeeds**. A green build is not evidence the CV is correct.

Every time you compile, you must check *both*:

1. the page count is what you expect (`pdfinfo build/<name>.pdf`), and
2. nothing is cut off — render the last page to an image and **look at it**:
   `pdftoppm -png -r 110 -f <last> -l <last> build/<name>.pdf /tmp/cv && ` then
   read the PNG.

Skipping step 2 is the most common way to hand someone a broken CV.

## Step 1 — Check the toolchain

```bash
make toolchain
```

If it fails it prints the install command. LuaLaTeX is required (`fontspec`
rules out pdfLaTeX) — never fall back to `pdflatex`.

## Step 2 — Ask what they're making

Use `AskUserQuestion` for these, in one call:

- **Document**: CV, cover letter, or both.
- **Language / convention** — this is not just a translation:

  | | French convention | English convention |
  |---|---|---|
  | Photo | usual | **omit** |
  | Age / date of birth | usual | **omit** |
  | Home address | usual | usually omit |
  | Letter: sender address + date | top **left** | top **right** |
  | Letter: recipient | **right** | **left** |

  The letter class has two command sets for this: `\address` / `\recipient` /
  `\location` (EN) versus `\addressfr` / `\recipientfr` / `\locationfr` (FR).
  Using the wrong pair is a visible mistake to a native reader.

- **Colour theme**: pass it as a class option —
  `\documentclass[a4paper, green]{arthur-cv}`. Available: `blue` (default),
  `green`, `red`, `grey`/`gray`, `yellow`; the same names work on
  `arthur-cover-letter`, so the CV and the letter match. For a colour outside
  those five, redefine `leftcolorband` / `boxcolor` / `maincolor` /
  `secondcolor` / `thirdcolor` in their preamble — that overrides the theme.

## Step 3 — Gather the content

Ask for what you don't have, but do not interrogate them field by field — invite
a paste (an old CV, a LinkedIn export, a rough list) and extract from it, then
ask only about the gaps and the ambiguities.

What the template needs:

- **Header**: full name, job title (the headline under the name), email, phone,
  LinkedIn (`/in/slug` form), GitHub (username only), website, plus photo /
  address / age if the convention calls for them.
- **Side bar**: short items only — key skills, languages, tools, interests. The
  bar is ~5.5 cm wide; anything longer than ~40 characters wraps badly.
- **Body**: experience and education as `{date} {title} [org] [place]
  {description}`, newest first. One or two lines of description each.

**Any field they don't want: pass `{}` or leave the command out.** Empty fields
render as nothing — the icon row disappears with them.

## Step 4 — Start from the closest example, never from scratch

| Their case | Copy |
|---|---|
| EN CV, no photo | `examples/Arthur_Bernard_CV_En.tex` |
| FR CV, photo + age + address | `examples/Arthur_Bernard_CV_Fr.tex` |
| Two pages | `examples/Two_Pages_CV.tex` |
| Cover letter | `examples/example_cover_letter.tex` |
| Bare skeleton | `examples/example_cv.tex` (uses the layout environments) |
| Smallest possible | `examples/minimal_cv.tex` |

Write the result to **`_custom_CV/`** (or `_custom_cover_letter/` for a
letter). Both are already in `.gitignore` — someone's phone number and address
should not land in a public fork by accident. Say this out loud when you create
the file; don't let them assume it's tracked.

**Compile from the repo root**, not from inside the output directory: the
classes live at the root and `\profilepic` paths are resolved relative to it.
Run it **twice** — the grey band and the photo frame are tikz nodes using
`remember picture`, which needs a second pass:

```bash
lualatex -halt-on-error -interaction=nonstopmode \
         -output-directory=build _custom_CV/my_cv.tex
lualatex -halt-on-error -interaction=nonstopmode \
         -output-directory=build _custom_CV/my_cv.tex
```

Use the layout environments rather than opening boxes by hand — they own the
column widths, so there is nothing to keep in sync:

```latex
\begin{cvbody}                 % optional arg: vertical offset in cm (default 3.5)
  \begin{cvleft}  ... \end{cvleft}
  \begin{cvright} ... \end{cvright}
\end{cvbody}
```

Older CVs open a `textblock` and two `minipage`s by hand with `0.37` / `0.61`
widths. That still works, and three of the shipped examples use it — but if you
copy one of those, leave those numbers alone: they pair with widths hard-coded
in the class.

## Step 5 — Compile, then actually look at it

Run the compile, then **both** checks from the top of this skill. Show the
rendered page to the user — they will spot wording problems you cannot.

## Step 6 — Fix overflow

When content runs off the page, fix it in this order — cheapest and least
damaging first:

1. **Cut words.** Descriptions of three lines become one. This is almost always
   the right fix for a CV and the user usually agrees once they see the page.
2. **Drop the weakest entries.** Old internships, redundant skills.
3. **Tighten the spacing** locally with a `\vspace{-2mm}` after a section — a
   couple of millimetres, not a redesign.
4. **Go to two pages** with `\newcvpage`, following `examples/Two_Pages_CV.tex`.
   With the layout environments, the page after it opens with
   `\begin{cvbody}[0.0]`.
   Do this only if they want a two-page CV; in many markets it is a downgrade.
   Note that `\newcvpage` re-draws the grey band but does *not* repeat the
   header.

Do not shrink the base font or widen the text block to buy space. Those cascade
through a hand-calibrated layout and break alignment elsewhere.

## Step 7 — Hand over

Tell them where the `.tex` and the `.pdf` are, that the `.tex` is the source to
edit for future updates, and that `_custom_CV/` is gitignored. If they want the
CV tracked in their own fork, that is their call — make the privacy trade-off
explicit rather than deciding for them.

## Known sharp edges

- **The classes need `arthur-cv-header.sty` alongside them.** If the user is
  copying the template into a project of their own rather than working inside a
  clone, they need the `.cls` *and* the `.sty`, or the compile dies with
  ``File `arthur-cv-header.sty' not found``.
- **`\subsectionleft` takes two braces**, not one: `\subsectionleft{Python}{}`.
  Passing only the first compiles, but silently feeds the next blank line's
  `\par` in as the description, which throws off the spacing between items.
- `\section{...}` colours its first three tokens in the main colour. A title
  shorter than three tokens, or one starting with a macro or a brace group,
  misbehaves. Keep section titles plain words of at least three letters.
- The side bar and body are independent columns: a long side bar does not push
  the body down, it just overflows on its own.
- `fontawesome` here is version 4.7, so only FA4 icon names exist
  (`\faEnvelopeO`, not `\faEnvelope`).
- Accented characters are fine (LuaLaTeX + `fontspec`), but the font is
  ClearSans — check that any unusual glyph actually renders rather than
  silently dropping.
