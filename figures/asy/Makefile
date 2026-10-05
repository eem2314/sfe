
# sfp/repo/figures/asy Makefile
# files to be processed with Asymptote (asy)
# NOTES:

FORBIDDEN_DIR := /home/eem2314/sfe/repo/figures/asy
ifeq ($(abspath $(CURDIR)),$(abspath $(FORBIDDEN_DIR)))
$(error "do not run make in the repo!")
endif

SUFFIXES = .asy .pdf

ASY = contour.dpress.asy

%.pdf:	%.asy
	asy -f pdf $<

PDFS = $(ASY:.asy=.pdf)

all: $(PDFS)

# list of stuff to include in dist tarfile
EXTRA_DIST = $(ASY)
