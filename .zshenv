#!/usr/bin/env zsh

# XDG base dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# zsh dir
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Editors
export EDITOR="nvim"
export VISUAL="nvim"

# History (must be here so it applies everywhere)
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000
