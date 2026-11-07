# doc/figures Makefile - built manually
# NOTES:
# - xfig MUST be run in the repo directory, not the build directory,
#   because an xfig save destroys the link and creates the fig file locally
#   
# - figures produced in xfig may use Latex math, e.g.
#   % 12 pt font ---v
#     4 0 0 50 -1 0 12 0.0000 2 150 495 3092 1588 $\\int$\001
#   % Notice the 2 here ------^ which means latex fonts; also the double backslash

# - Figures from xfig are converted to eps with fig2eps

# - To extract pages from manual.pdf and create a new pdf file:
#      texexec --pdfselect --selection=78,79,80 manual.pdf

SUFFIXES = .fig .tex .eps .ps .pdf

nosrc = \
goland-contour.jpg \
controls_vso.png \
goland-vso.jpg \
lco_screen.png \
methods-g-freq.png \
methods-v-g.png \
ss-compare.png \
viz-amviz.png

FIGS = \
beta.fig \
bif.fig \
globalcs.fig \
goland.fig \
goland-fuel.fig \
whirl-lbar.fig \
whirl-vso.fig

%.eps:	%.fig
	fig2eps --packages=amsmath,graphicx,color --nogv $<

EPS = $(FIGS:.fig=.eps)
all: $(EPS)

# list of stuff to include in dist tarfile XXX no eps?
EXTRA_DIST = $(nosrc) $(figs) $(eps)

FORCE:

list:		FORCE
	sed -n 's/^.*includegraphics.*{\([^}]*\)}.*$/\1/' ../manual.tex

tarfile:		FORCE
	tar zcf manual.tgz manual.tex fig *.eps Makefile


CLEANFILES = \
$(eps)
