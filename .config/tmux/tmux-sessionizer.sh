#!/bin/bash

switch_to(){
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

session=$(find ~/workspace ~/workspace/Uni -mindepth 1 -maxdepth 1 -type d | fzf)
session_name=$(basename "$session" | tr . _)

if [ -z "$session" ]; then
    exit 0
fi

if ! tmux has-session -t "$session_name" 2> /dev/null; then
    tmux new-session -s "$session_name" -c "$session" -d
fi

switch_to "$session_name"
