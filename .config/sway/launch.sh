#!/bin/sh

# General Env #
export XDG_CURRENT_DESKTOP="sway"
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1

export GDK_BACKEND=wayland
export QT_QPA_PLATFORMTHEME=qt6ct

export LESS="${LESS} --mouse"

# wlroots Env
export WLR_NO_HARDWARE_CURSORS=1
#export WLR_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"

# Everybody needs an agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

exec dbus-run-session -- sway
