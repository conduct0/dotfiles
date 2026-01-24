#!/usr/bin/env zsh

if [ -e /home/pluto/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pluto/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# General
export BACKGROUND_IMAGE="$HOME/Pictures/Fotots/Rollos/Rollo\ 59/R1-06710-0014.JPG"
export GTK_THEME=Adwaita:dark 

# xdg
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# android
export CAPACITOR_ANDROID_STUDIO_PATH="$HOME/Downloads/android-studio/bin/studio.sh"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

# qt on wayland
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export ELECTRON_OZONE_PLATFORM_HINT="auto"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"

# java
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
