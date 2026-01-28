#!/usr/bin/env zsh

if [ -e /home/pluto/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/pluto/.nix-profile/etc/profile.d/nix.sh; 
fi # added by Nix installer

# General
export BACKGROUND_IMAGE="$HOME/Pictures/Fotots/Rollos/Rollo\ 59/R1-06710-0014.JPG"
export GTK_THEME=Adwaita:dark 

# Languages / sdk setup
export GOPATH=$HOME/go
export CAPACITOR_ANDROID_STUDIO_PATH="$HOME/Downloads/android-studio/bin/studio.sh"
export ANDROID_HOME=$HOME/Android/Sdk
export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$HOME/.nvm"
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
# Cargo
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# qt on wayland
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export ELECTRON_OZONE_PLATFORM_HINT="auto"
# is this needed?
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

# dedup
typeset -U path

path=(
  $HOME/.local/bin
  $HOME/.cargo/bin
  $PYENV_ROOT/bin
  $GOPATH/bin
  $ANDROID_HOME/emulator
  $ANDROID_HOME/platform-tools
  $ANDROID_HOME/tools
  $JAVA_HOME/bin
  $path
)

