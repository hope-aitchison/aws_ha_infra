#!/bin/bash

# Fetching updates from remote
git fetch --prune

# Getting a list of local branches
local_branches=$(git branch | sed 's/\*//')

# Looping through each local branch
for branch in $local_branches; do
    # Checking if the branch exists in the remote
    if ! git branch -r | grep -q "\sorigin/$branch$"; then
        # Deleting the local branch
        git branch -d $branch
        echo "Deleted local branch: $branch"
    fi
done
