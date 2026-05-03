
# sfe Makefile
# NOTES:
#   to extract pages from sfe.pdf and create a new pdf file:
#      texexec --pdfselect --selection=78,79,80 sfe.pdf

SUFFIXES = .fig .tex .eps .ps .pdf

SUBDIRS = figures

docdir=${prefix}/doc

all-am:
	make sfe.pdf

# We must ignore errors from pdflatex because it always
# returns with an exit status of 1 - I believe this is
# due to the fact that the book is using some extensions
# evidenced by the fact that pdflatex prints "This is pdfTeXk"
# which according to the man page is because we are using extensions.

SRC = \
sfe.tex \
params-eqns.tex \
params-units.tex \
preface.tex

sfe.pdf:	$(SRC) figures/$(FIGS)
	cd figures && make all
	pdflatex sfe.tex
	biber sfe
	makeindex sfe.idx
	pdflatex sfe.tex
	pdflatex sfe.tex
	detex -l sfe.tex | wc
	hunspell -t -p sfe.words -l sfe.tex | sort | uniq -i
	@ echo "words listed by hunspell that are legit should be added to sfe.words"


refined.pdf:	refined.tex
	cd figures && make
	pdflatex refined.tex
	biblatex refined
	makeindex refined.idx
	pdflatex refined.tex
	pdflatex refined.tex

FORCE:

refs:		FORCE
		sed -n 's/^.*label{eqn:\([^}]*\)}.*/\1/p' sfe.tex >eqn.ref
		sed -n 's/^.*label{sect:\([^}]*\)}.*/\1/p' sfe.tex >sect.ref
		sed -n 's/^.*label{chap:\([^}]*\)}.*/\1/p' sfe.tex >chap.ref
		sed -n 's/^.*label{table:\([^}]*\)}.*/\1/p' sfe.tex >table.ref
		sed -n 's/^.*label{ex:\([^}]*\)}.*/\1/p' sfe.tex >ex.ref
		sed -n 's/^.*label{opt:\([^}]*\)}.*/\1/p' sfe.tex >opt.ref


EXTRA_DIST = $(SRC) sfe.pdf myindexstyle.ist

clean:
	rm -f $(CLEANFILES)

CLEANFILES = \
sfe.aux \
sfe.bcf \
sfe.bbl \
sfe.log \
sfe.out \
sfe.pdf \
sfe.idx \
sfe.lof \
sfe.lot \
sfe.toc \
sfe.ilg \
sfe.ind \
sfe.blg

checkeqns:	FORCE
	./checkeqns >checkeqns.out 2>&1
