#!/bin/bash

switch_to(){
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

echo "Repo Url:"
read repo_url

git ls-remote "$repo_url" --exit-code
repo_reachable=$?
if [ "$repo_reachable" -gt 0 ]; then
    read -n 1 -s -r -p $"Repo not reachable. Press enter to exit" 
    exit 1
fi

repo_name=$(basename $repo_url .git)
path_to_repo="$HOME/workspace/$repo_name"

if [ -d "$path_to_repo" ]; then
    read -n 1 -s -r -p $"Repo exists. Press enter to switch to it" 
    # Guard in case session exists already, shouldnt happen
    if ! tmux has-session -t "=$repo_name" 2> /dev/null; then
        tmux new-session -s "$repo_name" -c "$path_to_repo" -d
    fi
    switch_to "$repo_name"
    exit 0
fi
git clone "$repo_url" "$HOME/workspace/$repo_name" 
read -n 1 -s -r -p $"Press enter to go to the repo" 
# Guard in case session exists already, shouldnt happen
if ! tmux has-session -t "=$repo_name" 2> /dev/null; then
    tmux new-session -s "$repo_name" -c "$path_to_repo" -d
fi
switch_to "$repo_name"
exit 0

