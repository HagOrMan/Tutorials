#!/bin/bash

source ~/util.bashrc

# In terminal
alias c='clear'                      # Clear the terminal
alias lla='ls -lah --color=auto'      # List all files (detailed, human-readable)

# Process stuff
alias psg='ps aux | grep'            # Find a running process (e.g., `psg node`)
alias fk='function _force_kill() { confirm_action "force kill this process" "kill -9"; }; _force_kill'

# Things that need confirmation, overriden so I don't accidentally ruin something
alias mv='mv -i'                     # Prevent accidental overwrites when moving files
alias rm='rm -i'                     # Ask before deleting files

