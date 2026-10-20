
# sfp/repo/figures/asy Makefile
# files to be processed with Asymptote (asy)
# NOTES:
#  - on older hardware asy might fail with a GLX error if
#    render=4, so I commented out that line in all .asy files.
#  - create a file ~/.asy/config.asy with at least:
#      render=4
#    if your hardware doesn't get the GLX error

FORBIDDEN_DIR := /home/eem2314/sfe/repo/figures/asy
ifeq ($(abspath $(CURDIR)),$(abspath $(FORBIDDEN_DIR)))
$(error "do not run make in the repo!")
endif

SUFFIXES = .asy .pdf

ASY = \
COexample.asy \
contour.dpress.asy \
contourpv.asy \
contour3pv.asy \
contours.asy \
contoursX3.asy \
contours3D.asy

%.pdf:	%.asy
	asy -f pdf $<

PDFS = $(ASY:.asy=.pdf)

all: $(PDFS)

# list of stuff to include in dist tarfile
EXTRA_DIST = $(ASY)
