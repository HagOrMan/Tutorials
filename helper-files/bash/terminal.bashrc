#!/bin/bash

source ~/bash_helpers/util.bashrc

# moving around
alias ..='cd ..'                     # Move up one directory
alias ...='cd ../..'                 # Move up two directories
alias ~='cd ~'                       # Go to home directory
alias mkdir='mkdir -p'               # Create a directory and parents if needed

# In terminal
alias c='clear'                      # Clear the terminal
alias lla='ls -lah --color=auto'     # List all files (detailed, human-readable)
alias pretty-tree='tree -a -I ".git|node_modules|__pycache__|dist|build|.DS_Store|*.pyc" --dirsfirst -C'             # List all files in directory and subdirectories in pretty tree fashion, ignoring useless stuff like .git

# Process stuff
alias psg='ps aux | grep'            # Find a running process (e.g., `psg node`)
alias fk='function _force_kill() { confirm_action "force kill this process" "kill -9"; }; _force_kill'

findbig() {
    find . -type f -exec du -h {} + | sort -rh | head -n 10
}
alias fb="findbig"

# Special version of cd which lets me use the output from vscode 'copy relative path' in order to cd into a given directory
cds() {
  cd "$(echo "$1" | sed 's|\\|/|g')"
}

