# Build and check the example documents.
#
# Compiling every example IS the test suite: there is no unit-test framework for
# a LaTeX document class, and the examples between them exercise every documented
# command, both languages, both letter conventions and the multi-page path.
#
# lualatex must run from the repo root: the classes live here, and the examples
# reference pictures/ relative to the root rather than to examples/.

SHELL    := /bin/bash
LUALATEX ?= lualatex
PDFINFO  ?= pdfinfo
CHKTEX   ?= chktex
BUILD    ?= build

SRCS     := $(wildcard examples/*.tex)
NAMES    := $(basename $(notdir $(SRCS)))
PDFS     := $(addprefix $(BUILD)/,$(addsuffix .pdf,$(NAMES)))
CLASSES  := $(wildcard *.cls) $(wildcard *.sty)

TEXFLAGS := -halt-on-error -interaction=nonstopmode -file-line-error \
            -output-directory=$(BUILD)

# Two passes, deliberately: there is no bibliography, index or TOC here, but the
# grey band and the photo frame are tikz nodes using `remember picture`, which
# needs a second pass to resolve. latexmk would do this for us; it is a separate
# package on Debian and one more thing for a forker to install, so we just run
# lualatex twice.
PASSES := 2

# Expected page count per example. The layout is absolutely positioned, so a
# broken change usually still *compiles* — it just pushes content off the page or
# onto an extra one. A clean exit code alone is not evidence; this is.
# Adding an example without adding its expected count here fails `make test`.
PAGES_example_cv           := 1
PAGES_minimal_cv           := 1
PAGES_example_cover_letter := 1
PAGES_Arthur_Bernard_CV_En := 1
PAGES_Arthur_Bernard_CV_Fr := 1
PAGES_Two_Pages_CV         := 2

.PHONY: all build test lint clean toolchain

all: test

## build — compile every example into $(BUILD)/
build: toolchain $(PDFS)

$(BUILD)/%.pdf: examples/%.tex $(CLASSES)
	@echo "==> compiling $<"
	@mkdir -p $(BUILD)
	@for pass in $$(seq $(PASSES)); do \
	    $(LUALATEX) $(TEXFLAGS) $< > $(BUILD)/$*.pass$$pass.out 2>&1 || { \
	        echo "FAILED: $< (pass $$pass)"; \
	        grep -E ':[0-9]+:|^!' $(BUILD)/$*.log 2>/dev/null | head -20; \
	        echo "  full log: $(BUILD)/$*.log"; \
	        exit 1; \
	    }; \
	done

## test — compile everything, then assert each output's page count
test: build
	@echo "==> checking page counts"
	@fail=0; \
	$(foreach n,$(NAMES), \
	  want='$(PAGES_$(n))'; \
	  if [ -z "$$want" ]; then \
	    echo "  MISSING  $(n): no PAGES_$(n) declared in the Makefile"; fail=1; \
	  else \
	    got=$$($(PDFINFO) $(BUILD)/$(n).pdf 2>/dev/null | awk '/^Pages:/{print $$2}'); \
	    if [ "$$got" != "$$want" ]; then \
	      echo "  FAIL     $(n): expected $$want page(s), got $$got"; fail=1; \
	    else \
	      echo "  ok       $(n) ($$got p.)"; \
	    fi; \
	  fi; \
	) \
	if [ $$fail -ne 0 ]; then echo "page-count check failed"; exit 1; fi; \
	echo "all examples compile and match their expected page count"

# chktex exits 0 even when it reports problems, so `make lint` fails on any
# output instead of on the exit code. Each suppression below is here for a
# reason -- do not add one just to make the target green:
#   -n1  "Command terminated with space"   deliberate in the icon macros
#   -n12 "Interword spacing"               false positive after abbreviations
#   -n13 "Intersentence spacing"           false positive after "LLM:"
#   -n26 "Space in front of punctuation"   correct in French typography
#   -n36 "Space in front of parenthesis"   class-internal math/array code
# Notably NOT suppressed: -n8 (wrong dash length), which caught two real
# hyphen/en-dash inconsistencies in the English CV.
CHKTEXFLAGS ?= -q -n1 -n12 -n13 -n26 -n36

## lint — static check of the sources
#
# chktex is a separate package (`sudo apt install chktex`) and is not needed to
# *use* the template, so a missing chktex skips loudly rather than failing: a
# forker running `make` should not be blocked by a linter. CI always has it, so
# the gate is real there. Never let this print "clean" when it did not run.
lint:
	@if ! command -v $(CHKTEX) >/dev/null; then \
	    echo "SKIPPED: chktex not installed (sudo apt install chktex)"; \
	    echo "         lint is enforced in CI regardless."; \
	    exit 0; \
	fi; \
	out=$$($(CHKTEX) $(CHKTEXFLAGS) $(CLASSES) $(SRCS) 2>&1); \
	if [ -n "$$out" ]; then echo "$$out"; echo "lint failed"; exit 1; fi; \
	echo "lint clean"

## toolchain — fail early with a useful message rather than a cryptic one
toolchain:
	@command -v $(LUALATEX) >/dev/null || { \
	    echo "lualatex not found. On Debian/Ubuntu:"; \
	    echo "  sudo apt install -y texlive-luatex texlive-latex-extra \\"; \
	    echo "      texlive-latex-recommended texlive-fonts-extra \\"; \
	    echo "      texlive-pictures texlive-lang-french"; \
	    exit 1; }
	@command -v $(PDFINFO) >/dev/null || { \
	    echo "pdfinfo not found — install poppler-utils"; exit 1; }

## clean — remove build artifacts
clean:
	@rm -rf $(BUILD)
	@echo "cleaned"
