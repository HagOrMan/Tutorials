#!/bin/bash

# All the git commands I want to run with aliases
source ~/util.bashrc

alias gl='git log'
alias glg='git log --all --graph --oneline --decorate -n 25'
alias diff-words="git diff --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'"
alias changedfiles='git diff-tree --no-commit-id -r --name-only'

alias ga='git add' # use: `ga file.py` to stage specific files
alias gaa='git add .' # use: `gaa` to stage all files
alias grs='git restore --staged' # use: `grs file.py` to unstage specific files
alias grsa='git restore --staged .' # use: `grs file.py` to unstage all files
alias gc='git commit -m' # use: `gc "commit message"` to commit
alias gpll='git pull'
alias gplr='git pull --rebase'
alias gplsf='git pull --squash --ff'
alias gpsh='git push'
alias gpshn='git push -u origin HEAD' # useful to push a branch that only exists locally, and will push to the remote with the same name as the local

alias gco='git checkout' # use: `gco main`, checkout an existing branch
alias gcob='git checkout -b' # use: `gcob new-branch`, checkout a new branch
alias gb='git branch' # view a list of all branches

alias gs='git status' # see the status of your current repo
alias gss='git status -s' # see the status in simple form
alias gcl='git clone'

alias gf='git fetch'
alias gfp='git fetch --prune' # fetch all changes AND remove upstream pointers to deleted branches

# Discard all current changes in your repo
alias discard='function _discard() { confirm_action "discard all changes" "git reset HEAD --hard"; }; _discard'

# Delete a branch
alias gbd='function _delete_branch() { confirm_action "delete the specified branch" "git branch -D $1"; }; _delete_branch'

delete_branches_with_no_upstream() {
	local branches=$(git branch -vv | grep ': gone]' | awk '{print $1}')
	if [ -z "$branches" ]; then
	        echo "No branches to delete."
	        return
	fi

        echo "The following branches will be deleted:"
	echo "$branches"
	confirm_action "delete the above branches" "$(for branch in $branches; do echo git branch -D $branch; done)"
}
# Delete any branches that have no upstream (often run after `gfp`)
alias gbdnu='delete_branches_with_no_upstream'

