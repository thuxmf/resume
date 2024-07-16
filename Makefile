# Makefile for Resume

PACKAGE = resume_xia
DATA = data
RESUME  = resume
CLSFILE = $(PACKAGE).cls
STYLE_FILE = mengfei_xia.sty

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

.PHONY: clean clean-data clean-all cls data data-chinese rebuild rebuild-chinese resume

cls: $(CLSFILE)

sync-data:
	if [ -d "${DATA}" ]; then \
		$(SLEEP) 0.5; \
	fi

data:
	mkdir -p $(DATA)
	@echo 'Using style file `$(STYLE_FILE)`'
	$(PYTHON) generate_data.py --style_file $(STYLE_FILE)

data-chinese:
	mkdir -p $(DATA)
	@echo 'Using style file `$(STYLE_FILE)`'
	$(PYTHON) generate_data.py --style_file $(STYLE_FILE) --language chinese

clean:
	$(LATEXMK) -c $(RESUME)

clean-data: clean
	-@$(RM) data/ xiasetup.tex

clean-all: clean clean-data
	-@$(RM) $(RESUME).pdf $(RESUME).synctex.gz $(RESUME).dvi

resume:
	$(XELATEX) $(RESUME).tex

rebuild: clean-data data sync-data resume

rebuild-chinese: clean-data data-chinese sync-data resume
