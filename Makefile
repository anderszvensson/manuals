# simple makefile to automate the generation of manuals
# "$Header: /dynebolic/manual/Makefile,v 1.4 2003/08/17 12:44:06 jaromil Exp $"

# list of all files
DEPS = \
dynebolic-manual.sgml \
intro.sgml \
system.sgml \
video.sgml \
audio.sgml \
text.sgml

all : pdf

html : $(DEPS)
	rm -f html/*.html
	docbook2html -d dsssl-stylesheets-1.79/html/docbook.dsl \
		-o html dynebolic-manual.sgml

pdf : $(DEPS)
	docbook2pdf -d dsssl-stylesheets-1.79/print/docbook.dsl \
		dynebolic-manual.sgml

clean :
	rm -f html/*.html \
	dynebolic-manual.pdf \
	dynebolic-manual.ps  \
	dynebolic-manual.tex \
	dynebolic-manual.txt

