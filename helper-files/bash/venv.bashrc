#!/bin/bash

# venv related
alias nvenv='python -m venv .venv' # make a new venv
alias venv='source .venv/Scripts/activate'  # Quickly activate a Python virtualenv

# package related
alias pi='pip install'
alias pir='pip install -r requirements.txt'
alias pui='pip uninstall'
alias pl='pip list'
alias plf='pip list --format=freeze' # requirements in format for requirements file
alias plr='pip list --format=freeze > requirements.txt' # directly sends to requirements file
alias pln='pip list --not-required --format=freeze' # lists top level dependencies
alias plnr='pip list --not-required --format=freeze > requirements.txt' # sends only top level dependencies to requirements file

