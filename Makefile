# Makefile for Resume

PACKAGE = resume_xia
DATA = data
RESUME  = resume
CLSFILE = $(PACKAGE).cls

LATEXMK = latexmk
XELATEX = xelatex
PYTHON = python3
SHELL  := /bin/bash

# make deletion work on Windows
ifdef SystemRoot
	RM = del /Q
else
	RM = rm -rf
endif

.PHONY: clean cleandata cleanall cls data data-chinese rebuild rebuild-chinese resume FORCE_MAKE

cls: $(CLSFILE)

data:
	mkdir -p $(DATA)
	$(PYTHON) generate_data.py

data-chinese:
	mkdir -p $(DATA)
	$(PYTHON) generate_data.py --language chinese

clean:
	$(LATEXMK) -c $(RESUME)

cleandata: clean
	-@$(RM) data/ xiasetup.tex

cleanall: clean cleandata
	-@$(RM) $(RESUME).pdf $(RESUME).synctex.gz $(RESUME).dvi

resume:
	$(XELATEX) $(RESUME).tex

rebuild: cleandata data FORCE_MAKE resume

rebuild-chinese: cleandata data-chinese FORCE_MAKE resume
