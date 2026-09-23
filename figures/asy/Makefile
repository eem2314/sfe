
# sfp/repo/figures/asy Makefile
# files to be processed with Asymptote (asy)
# NOTES:

SUFFIXES = .asy .pdf

ASY = optim4.asy

%.pdf:	%.asy
	asy -f pdf $<

PDFS = $(ASY:.asy=.pdf)

all: $(PDFS)

# list of stuff to include in dist tarfile
EXTRA_DIST = $(ASY)
