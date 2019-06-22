.PHONY: help update clean

REPO:=iancleary/gnome-extensions

# Argos folder
ARGOS:=$(HOME)/.config/argos

# Shell that make should use
SHELL:=bash

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

update: DARGS?=
update: ## Copy the files in this folder to the ARGOS folder
	@if ! [ -d $(ARGOS) ]; then \
		mkdir $(ARGOS); \
	fi
	# use rsync rather than cp -r to exclude folders
	rsync -rv --exclude=.gitignore --exclude=.vscode --exclude=.git --exclude=Makefile . $(ARGOS)

clean: ## removes all extensions by deleting the ARGOS folder
	rm -rf $(ARGOS)/