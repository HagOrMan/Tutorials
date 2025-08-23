#!/bin/bash

# Used for VSCode copying relative path, and then taking that file path to fix the styling using eslint. Done because the path has backslashes but we want to convert those to forward slashes and then run the eslint fix command
# NOTE: must use `fixeslint 'path'` with single quotes around the path
fixeslint() {
  npx eslint "$(echo "$1" | sed 's|\\|/|g')" --fix
}

