# simple makefile to automate the generation of manuals
# "$Header: /dynebolic/manual/Makefile,v 1.4 2003/08/17 12:44:06 jaromil Exp $"

# list of all files
DEPS = \
dynebolic-manual.sgml \
EN/intro.sgml \
EN/system.sgml \
EN/video.sgml \
EN/audio.sgml \
EN/text.sgml 


DSSSL-print = ../dsssl-stylesheets-1.79/print/docbook.dsl
DSSSL-pdf   = ../dsssl-stylesheets-1.79/pdf/docbook.dsl
DSSSL-html  = ../dsssl-stylesheets-1.79/html/docbook.dsl

# DSSSL-html = /usr/share/sgml/docbook/stylesheet/dsssl/modular/html/docbook.dsl
# DSSSL-print = /usr/share/sgml/docbook/stylesheet/dsssl/modular/print/docbook.ds
# DSSSL-pdf = /usr/share/sgml/docbook/stylesheet/dsssl/modular/print/docbook.dsl

# check which language is set to compile, english is default
# to choose another language run: make man-language=ES
man-language ?= EN




all : lang index pdf html

lang: dynebolic-manual-$(man-language).sgml
	ln -sf ../dynebolic-manual.sgml $(man-language)/dynebolic-manual-$(man-language).sgml

# jade omissis options: -V nochunks

index :
	collateindex.pl -N -o $(man-language)/index.sgml -t index
	rm -f $(man-language)/HTML.index
	cd $(man-language) && openjade -wno-valid -t sgml -V html-index \
		-d $(DSSSL-html) -D $(man-language) \
		dynebolic-manual-$(man-language).sgml >/dev/null
	collateindex.pl -o $(man-language)/index.sgml $(man-language)/HTML.index
	rm -f $(man-language)/HTML.index $(man-language)/*.htm

html : $(DEPS)
	rm -rf html/*.htm
	images/convert_for_html.sh $(man-language) html
	cd $(man-language) && docbook2html -u -d $(DSSSL-html) \
		-o html dynebolic-manual-$(man-language).sgml

pdf : $(DEPS)
	rm -f $(man-language)/dynebolic-manual-$(man-language).pdf
	images/convert_for_html.sh $(man-language) pdf
	cd $(man-language) && docbook2pdf  -d $(DSSSL-pdf) \
		dynebolic-manual-$(man-language).sgml


txt : $(DEPS)
	rm -f $(man-language)/dynebolic-manual-$(man-language).txt
	cd $(man-language) && docbook2txt -d $(DSSSL-print) \
		dynebolic-manual-$(man-language).sgml


texi : $(DEPS)
	rm -f $(man-language)/dynebolic-manual-$(man-language).txt
	cd $(man-language) && docbook2texi -d $(DSSSL-print) \
		dynebolic-manual-$(man-language).sgml

info : $(DEPS) texi
	cd $(man-language); \
	(makeinfo --force dynebolic-manual-$(man-language).texi 2>/dev/null; return 0)


book : $(DEPS)
	rm -f dynebolic-manual.pdf
	docbook2pdf -d $(DSSSL-print) -D $(man-language) \
		dynebolic-manual.sgml

postscript : $(DEPS)
	rm -f dynebolic-manual.pdf
	docbook2ps -d $(DSSSL-print) -D $(man-language) \
		dynebolic-manual.sgml

rtf : $(DEPS)
	rm -f dynebolic-manual.rtf
	docbook2rtf -d $(DSSSL-pdf) -D $(man-language) \
		dynebolic-manual.sgml

tex : $(DEPS)
	rm -f dynebolic-manual.tex
	docbook2tex -d $(DSSSL-print) -D $(man-language) \
		dynebolic-manual.sgml

dvi : $(DEPS)
	rm -f dynebolic-manual.dvi
	docbook2dvi -d $(DSSSL-print) -D $(man-language) \
		dynebolic-manual.sgml

man : $(DEPS)
	rm -f dynebolic.man
	docbook2man -d $(DSSSL-html) -D $(man-language) \
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

