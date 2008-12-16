# simple makefile to automate the generation of manuals
# "$Header: /dynebolic/manual/Makefile,v 1.4 2003/08/17 12:44:06 jaromil Exp $"

# check which language is set to compile, english is default
# to choose another language run: make man-language=ES

include ../config.mk

# list of all files
DEPS = \
$(man-language)/intro.sgml

stylesheets = ../../stylesheets/dsssl-1.79
utils = ../utils

DSSSL-print = $(stylesheets)/print/docbook.dsl
DSSSL-pdf   = $(stylesheets)/pdf/docbook.dsl
# DSSSL-html  = ../stylesheets/dsssl-1.79/html/docbook.ds
DSSSL-index = $(stylesheets)/html/docbook.dsl
DSSSL-html  = $(stylesheets)/html/docbook.dsl

# DSSSL-html = /usr/share/sgml/docbook/stylesheet/dsssl/modular/html/docbook.dsl
# DSSSL-print = /usr/share/sgml/docbook/stylesheet/dsssl/modular/print/docbook.ds
# DSSSL-pdf = /usr/share/sgml/docbook/stylesheet/dsssl/modular/print/docbook.dsl





all : index pdf html

#collate:
#	utils/collatemanual.sh $(man-language)

$(man-language)/dynebolic-manual-$(man-language).sgml:
	$(utils)/collatemanual.sh $(man-language)

# jade omissis options: -V nochunks
# setting the SP_ENCODING=XML is necessary for UTF-8 based typesetting

index : $(man-language)/dynebolic-manual-$(man-language).sgml
	collateindex.pl -N -o $(man-language)/index.sgml -t index
	rm -f $(man-language)/HTML.index
	cd $(man-language) && openjade -wno-valid -t sgml -V html-index \
		-d $(DSSSL-index) -D $(man-language) \
		dynebolic-manual-$(man-language).sgml >/dev/null
	collateindex.pl -o $(man-language)/index.sgml $(man-language)/HTML.index
	rm -f $(man-language)/HTML.index $(man-language)/*.htm

html : $(DEPS)
	rm -rf html/*.htm
	$(utils)/formatimages.sh $(man-language) html
	cd $(man-language) && SP_ENCODING=XML \
	docbook2html -d $(DSSSL-html) \
		-o html dynebolic-manual-$(man-language).sgml
	cp -f ../stylesheets/dyne.css $(man-language)/html


pdf : $(DEPS)
	rm -f $(man-language)/dynebolic-manual-$(man-language).pdf
	$(utils)/formatimages.sh $(man-language) pdf
	cd $(man-language) && SP_ENCODING=XML \
	docbook2pdf  -d $(DSSSL-pdf) \
		dynebolic-manual-$(man-language).sgml


txt : $(DEPS)
	rm -f $(man-language)/dynebolic-manual-$(man-language).txt
	cd $(man-language) && SP_ENCODING=XML \
	docbook2txt -d $(DSSSL-print) \
		dynebolic-manual-$(man-language).sgml


texi : $(DEPS)
	rm -f $(man-language)/dynebolic-manual-$(man-language).txt
	cd $(man-language) && SP_ENCODING=XML \
	docbook2texi -d $(DSSSL-print) \
		dynebolic-manual-$(man-language).sgml

info : $(DEPS) texi
	cd $(man-language); \
	(makeinfo --force dynebolic-manual-$(man-language).texi 2>/dev/null; return 0)


book : $(DEPS)
	rm -f dynebolic-manual.pdf
	cd $(man-language) && SP_ENCODING=XML \
	docbook2pdf -d $(DSSSL-print) \
		dynebolic-manual-$(man-language).sgml

postscript : $(DEPS)
	rm -f dynebolic-manual.pdf
	cd $(man-language) && SP_ENCODING=XML \
	docbook2ps -d $(DSSSL-print) \
		dynebolic-manual-$(man-language).sgml


rtf : $(DEPS)
	rm -f dynebolic-manual.rtf
	cd $(man-language) && SP_ENCODING=XML \
	docbook2rtf -d $(DSSSL-pdf) \
		dynebolic-manual-$(man-language).sgml

tex : $(DEPS)
	rm -f dynebolic-manual.tex
	cd $(man-language) && SP_ENCODING=XML \
	docbook2tex -d $(DSSSL-print) \
		dynebolic-manual-$(man-language).sgml

dvi : $(DEPS)
	rm -f dynebolic-manual.dvi
	cd $(man-language) && SP_ENCODING=XML \	
	docbook2dvi -d $(DSSSL-print) \
		dynebolic-manual-$(man-language).sgml

man : $(DEPS)
	rm -f dynebolic.man
	cd $(man-language) && SP_ENCODING=XML \	
	docbook2man -d $(DSSSL-html) \
		dynebolic-manual-$(man-language).sgml


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
	rm -rf $(man-language)/images
	rm -rf $(man-language)/html
	rm -ff $(man-language)/index.sgml
	rm -ff $(man-language)/db2texi.refs
	rm -rf $(man-language)/dynebolic-manual-$(man-language).*
