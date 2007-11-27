# simple makefile to automate the generation of manuals
# "$Header: /dynebolic/manual/Makefile,v 1.4 2003/08/17 12:44:06 jaromil Exp $"

# list of all files
DEPS = \
dynebolic-manual.sgml \
intro.sgml \
system.sgml \
video.sgml \
audio.sgml \
text.sgml \
index.sgml

all : index pdf html

# jade omissis options: -V nochunks

index :
	collateindex.pl -N -o index.sgml -t index
	rm -f HTML.index
	jade -wno-valid -t sgml -V html-index -d dsssl-stylesheets-1.79/html/docbook.dsl dynebolic-manual.sgml >/dev/null
	collateindex.pl -o index.sgml HTML.index
	rm -f HTML.index *.htm

html : $(DEPS)
	rm -rf html/*.htm
	images/convert_for_html.sh
	docbook2html -d dsssl-stylesheets-1.79/html/docbook.dsl \
		-o html dynebolic-manual.sgml

pdf : $(DEPS)
	rm -f dynebolic-manual.pdf
	docbook2pdf -d dsssl-stylesheets-1.79/pdf/docbook.dsl \
		dynebolic-manual.sgml

book : $(DEPS)
	rm -f dynebolic-manual.pdf
	docbook2pdf -d dsssl-stylesheets-1.79/print/docbook.dsl \
		dynebolic-manual.sgml

postscript : $(DEPS)
	rm -f dynebolic-manual.pdf
	docbook2ps -d dsssl-stylesheets-1.79/print/docbook.dsl \
		dynebolic-manual.sgml

rtf : $(DEPS)
	rm -f dynebolic-manual.rtf
	docbook2rtf -d dsssl-stylesheets-1.79/pdf/docbook.dsl \
		dynebolic-manual.sgml

tex : $(DEPS)
	rm -f dynebolic-manual.tex
	docbook2tex -d dsssl-stylesheets-1.79/print/docbook.dsl \
		dynebolic-manual.sgml

dvi : $(DEPS)
	rm -f dynebolic-manual.dvi
	docbook2dvi -d dsssl-stylesheets-1.79/print/docbook.dsl \
		dynebolic-manual.sgml



clean :
	rm -f html/*.htm \
	dynebolic-manual.pdf \
	dynebolic-manual.ps  \
	dynebolic-manual.tex \
	dynebolic-manual.rtf \
	dynebolic-manual.txt \
	dynebolic-manual.aux \
	dynebolic-manual.log \
	dynebolic-manual.out \
	dynebolic-manual.dvi

