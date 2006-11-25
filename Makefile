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

all : pdf html

# jade omissis options: -V nochunks

index :
	collateindex.pl -N -o index.sgml -t index
	rm -f HTML.index
	jade -wno-valid -t sgml -V html-index -d dsssl-stylesheets-1.79/html/docbook.dsl dynebolic-manual.sgml >/dev/null
	collateindex.pl -o index.sgml HTML.index
	rm -f HTML.index *.htm

html : index $(DEPS)
	rm -rf html/*.htm
	docbook2html -d dsssl-stylesheets-1.79/html/docbook.dsl \
		-o html dynebolic-manual.sgml

pdf : index $(DEPS)
	rm -f dynebolic-manual.pdf
	docbook2pdf -d dsssl-stylesheets-1.79/pdf/docbook.dsl \
		dynebolic-manual.sgml

book : index $(DEPS)
	rm -f dynebolic-manual.pdf
	docbook2pdf -d dsssl-stylesheets-1.79/print/docbook.dsl \
		dynebolic-manual.sgml

clean :
	rm -f html/*.htm \
	dynebolic-manual.pdf \
	dynebolic-manual.ps  \
	dynebolic-manual.tex \
	dynebolic-manual.txt

