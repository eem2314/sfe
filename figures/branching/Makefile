
# sfp/repo/figures/branching Makefile
# files to be processed with Asymptote (asy)
# NOTES:
#  - on older hardware asy might fail with a GLX error if
#    render=4, so I commented out that line in all .asy files.
#  - create a file ~/.asy/config.asy with at least:
#      render=4
#    if your hardware doesn't get the GLX error

FORBIDDEN_DIR := /home/eem2314/sfe/repo/figures/branching
ifeq ($(abspath $(CURDIR)),$(abspath $(FORBIDDEN_DIR)))
$(error "do not run make in the repo!")
endif

SUFFIXES = .asy .pdf .apf

APF = \
vso12.apf

ASY = \
vso12.asy \
vsofuel.asy

%.pdf:	%.asy
	asy -f pdf $<

PDFS = $(ASY:.asy=.pdf)

all: $(PDFS)

# list of stuff to include in dist tarfile
EXTRA_DIST = $(APF) $(ASY)
