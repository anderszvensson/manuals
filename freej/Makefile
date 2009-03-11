# simple makefile to automate the generation of manuals
# - by jaromil (2003-2008)

# check which language is set to compile in config.mk
# english is usually default

include ../config.mk

lang = $(man-language)

filename = freej-manual-$(lang)

# list of all files
DEPS = $(lang)/$(filename).sgml

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
#	utils/collatemanual.sh $(lang)

$(lang)/$(filename).sgml:
	./collate.sh $(lang)

# jade omissis options: -V nochunks
# setting the SP_ENCODING=XML is necessary for UTF-8 based typesetting

index : $(lang)/$(filename).sgml
	collateindex.pl -N -o $(lang)/index.sgml -t index
	rm -f $(lang)/HTML.index
	cd $(lang) && openjade -wno-valid -t sgml -V html-index \
		-d $(DSSSL-index) -D $(lang) \
		$(filename).sgml >/dev/null
	collateindex.pl -o $(lang)/index.sgml $(lang)/HTML.index
	rm -f $(lang)/HTML.index $(lang)/*.htm

html : $(DEPS)
	rm -rf html/*.htm
	$(utils)/formatimages.sh $(lang) html
	cd $(lang) && SP_ENCODING=XML \
	docbook2html -d $(DSSSL-html) \
		-o html $(filename).sgml
	cp -f ../stylesheets/dyne.css $(lang)/html


pdf : $(DEPS)
	rm -f $(lang)/$(filename).pdf
	$(utils)/formatimages.sh $(lang) pdf
	cd $(lang) && SP_ENCODING=XML \
	docbook2pdf  -d $(DSSSL-pdf) \
		$(filename).sgml


txt : $(DEPS)
	rm -f $(lang)/$(filename).txt
	cd $(lang) && SP_ENCODING=XML \
	docbook2txt -d $(DSSSL-print) \
		$(filename).sgml


texi : $(DEPS)
	rm -f $(lang)/$(filename).txt
	cd $(lang) && SP_ENCODING=XML \
	docbook2texi -d $(DSSSL-print) \
		$(filename).sgml

info : $(DEPS) texi
	cd $(lang); \
	(makeinfo --force $(filename).texi 2>/dev/null; return 0)


book : $(DEPS)
	rm -f $(filename).pdf
	cd $(lang) && SP_ENCODING=XML \
	docbook2pdf -d $(DSSSL-print) \
		$(filename).sgml

postscript : $(DEPS)
	rm -f $(filename).pdf
	cd $(lang) && SP_ENCODING=XML \
	docbook2ps -d $(DSSSL-print) \
		$(filename).sgml


rtf : $(DEPS)
	rm -f $(filename).rtf
	$(utils)/formatimages.sh $(lang) rtf
	cd $(lang) && SP_ENCODING=XML \
	docbook2rtf -d $(DSSSL-pdf) -s . \
		$(filename).sgml

tex : $(DEPS)
	rm -f $(filename).tex
	cd $(lang) && SP_ENCODING=XML \
	docbook2tex -d $(DSSSL-print) \
		$(filename).sgml

dvi : $(DEPS)
	rm -f $(filename).dvi
	cd $(lang) && SP_ENCODING=XML \	
	docbook2dvi -d $(DSSSL-print) \
		$(filename).sgml

man : $(DEPS)
	rm -f dynebolic.man
	cd $(lang) && SP_ENCODING=XML \	
	docbook2man -d $(DSSSL-html) \
		$(filename).sgml


clean :
	rm -f html/*.htm \
	$(filename).pdf \
	$(filename).ps  \
	$(filename).tex \
	$(filename).rtf \
	$(filename).txt \
	$(filename).aux \
	$(filename).log \
	$(filename).out \
	$(filename).dvi
	rm -rf $(lang)/images
	rm -rf $(lang)/html
	rm -ff $(lang)/index.sgml
	rm -ff $(lang)/db2texi.refs
	rm -rf $(lang)/ruby.sgml
	rm -rf $(lang)/python.sgml
	rm -rf $(lang)/$(filename).*


