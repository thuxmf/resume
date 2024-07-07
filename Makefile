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
	SLEEP = timeout
else
	RM = rm -rf
	SLEEP = sleep
endif

.PHONY: clean cleandata cleanall cls data data-chinese rebuild rebuild-chinese resume

cls: $(CLSFILE)

sync-data:
	if [ -d "${DATA}" ]; then \
		$(SLEEP) 0.5; \
	fi

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

rebuild: cleandata data sync-data resume

rebuild-chinese: cleandata data-chinese sync-data resume
