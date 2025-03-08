#!/bin/bash

# Function to perform an action that requires confirmation.
confirm_action() {
    local message=$1
    local action=$2
    read -p "Are you sure you want to $message? This cannot be undone. (y/n) " -n 1 -r
    echo    # move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        eval "$action"
    else
        echo "Action cancelled."
    fi
}

