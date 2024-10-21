#!/bin/sh

# General Env #
export XDG_CURRENT_DESKTOP="sway"
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1

export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=qt6ct

export LESS="${LESS} --mouse"

# wlroots Env
export WLR_NO_HARDWARE_CURSORS=1
#export WLR_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"

# Everybody needs an agent
eval `ssh-agent`

exec dbus-run-session -- sway
