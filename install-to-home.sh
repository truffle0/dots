#!/bin/bash

printf "Installing to %s...\n" $(realpath ~)

FILES_BRANCH="main"
SCRIPT_DIR=$(realpath $(dirname $0))

# dots command alias
dots="git --git-dir=$HOME/.dots --work-tree=$HOME"

# Do some preliminary sanity checks
[[ $(pwd) != $SCRIPT_DIR ]] && cd $SCRIPT_DIR
git rev-parse || exit

if [ -d ~/.dots ] || [ -d ~/.git ]; then
    printf "FATAL: %s already exist!\n" $(realpath $HOME/.dots)
    exit
fi

# Create a bare repository under ~/.dots
# use only the top commit, wasting space is bad :3
git clone --bare --depth 1 --branch $FILES_BRANCH file:///$SCRIPT_DIR $HOME/.dots

# OPTIONS TO MAKE EVERYTHING LESS ANNOYING #

# Correct origin location for push/pull
$dots remote set-url origin `git remote get-url origin`

# Dont print out your entire home each time
$dots config status.showUntrackedFiles no

# Deletes of files that don't exist are automatically staged
# for some reason, fix that
$dots restore --staged $HOME/