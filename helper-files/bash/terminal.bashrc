#!/bin/bash

source ~/util.bashrc

# moving around
alias ..='cd ..'                     # Move up one directory
alias ...='cd ../..'                 # Move up two directories
alias ~='cd ~'                       # Go to home directory
alias mkdir='mkdir -p'               # Create a directory and parents if needed

# In terminal
alias c='clear'                      # Clear the terminal
alias lla='ls -lah --color=auto'     # List all files (detailed, human-readable)

# Process stuff
alias psg='ps aux | grep'            # Find a running process (e.g., `psg node`)
alias fk='function _force_kill() { confirm_action "force kill this process" "kill -9"; }; _force_kill'

findbig() {
    find . -type f -exec du -h {} + | sort -rh | head -n 10
}
alias fb="findbig"

