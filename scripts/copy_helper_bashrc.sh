#!/bin/bash

# This script will copy bashrc files from my root directory to the helper file folder
# This will help me keep the helper files up to date as I add onto them

SOURCE_DIR="$HOME"
DEST_DIR="../helper-files/bash"

# Loop through all files in the home directory that end with '.bashrc' (excluding '.bashrc' itself)
for file in "$SOURCE_DIR"/*.bashrc; do
  # Skip the main .bashrc file
  if [ "$file" != "$SOURCE_DIR/.bashrc" ]; then
    # Copy the file to the destination directory
    cp "$file" "$DEST_DIR/"
    echo "Copied $file to $DEST_DIR/"
  fi
done

echo "All .bashrc files (except .bashrc itself) have been copied to $DEST_DIR"
