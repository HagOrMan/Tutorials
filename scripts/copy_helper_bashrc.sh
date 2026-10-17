#!/bin/bash

# This script will copy bashrc files from my root directory to the helper file folder
# This will help me keep the helper files up to date as I add onto them

# Directory this script lives in, regardless of where it's called from
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOURCE_DIR="$HOME/bash_helpers"
DEST_DIR="$SCRIPT_DIR/../helper-files/bash"

# Loop through all files in the source directory that end with '.bashrc'
for file in "$SOURCE_DIR"/*.bashrc; do
  # Copy the file to the destination directory
  cp "$file" "$DEST_DIR/"
  echo "Copied $file to $DEST_DIR/"
done

echo "All .bashrc files have been copied to $DEST_DIR"