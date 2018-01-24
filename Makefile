# default parameters
ROOT:=$(PWD)
SRCDIR:=src
BINDIR:=bin
FIGDIR:=figures
BUILDDIR:=build

# usefull parameter from above 
# assumes there is a tikz folder in figures to compile them
TKIZDIR:=$(ROOT)/$(FIGDIR)/tikz
# get the main tex and seve the name wihtout extension in FILENAME
FILENAME:=$(shell grep -Elr 'documentclass' src/* | cut -d':' -f1)
FILENAME:=$(notdir $(FILENAME))
FILENAME:=$(basename $(FILENAME))
$(info The main tex is $(FILENAME).tex)
TEXFILENAME:=$(FILENAME).tex
DEPEND_SRCS:= $(shell find $(SRCDIR) -name '*.tex')
DEPEND_SRCS_FIG:= $(shell find $(TKIZDIR) -name '*.tex')

define prepare_build
	if [ ! -d "$(BUILDDIR)" ]; then mkdir $(BUILDDIR); fi
	if [ ! -d "$(BINDIR)" ]; then mkdir $(BINDIR); fi
	ln -sf $(ROOT)/$(SRCDIR)/*.bib $(ROOT)/$(BUILDDIR)/
	ln -sf $(ROOT)/$(SRCDIR)/*.bst $(ROOT)/$(BUILDDIR)/
	ln -sf $(ROOT)/$(SRCDIR)/*.sty $(ROOT)/$(BUILDDIR)/
endef

define end_build
# 	create a link to the log file for texmaker
	ln -sf $(ROOT)/$(BUILDDIR)/$(FILENAME).log $(ROOT)/$(SRCDIR)/
	cp $(ROOT)/$(BUILDDIR)/$(FILENAME).pdf $(ROOT)/$(BINDIR)/
endef

define pdf_latex
	cd $(1) ; pdflatex --output-directory=$(ROOT)/$(BUILDDIR) $(2).tex ; cd $(ROOT) ; pwd
endef

define build
	$(call pdf_latex,$(1),$(2))
	cd $(ROOT)/$(BUILDDIR) ; bibtex $(2).aux ; cd $(ROOT)/
	$(call pdf_latex,$(1),$(2))
	$(call pdf_latex,$(1),$(2))
endef

define build_fast
	$(call pdf_latex,$(1),$(2))
endef

all: $(DEPEND_SRCS)
	$(call prepare_build)
	$(call build,$(ROOT)/$(SRCDIR),$(FILENAME))
	$(call end_build)

figures: $(DEPEND_SRCS_FIG)
	$(call prepare_build)
	$(foreach source, $(DEPEND_SRCS_FIG), $(call build,$(TIKZDIR),$(basename $(source))) ; cp $(ROOT)/$(BUILDDIR)/$(basename $(source))).pdf $(ROOT)/$(FIGDIR))

fast: $(DEPEND_SRCS)
	$(call prepare_build)
	$(call build_fast,$(ROOT)/$(SRCDIR),$(FILENAME))
	$(call end_build)

count: $(DEPEND_SRCS)
	wc -w $(DEPEND_SRCS)

clean:
	rm -f ./build/*
