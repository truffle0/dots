#!/bin/bash
declare CLAM_OUTPUT=${2:-eDP-1}
declare CONNECTED_OUTPUTS=$(swaymsg -p -t get_outputs | awk '{ if ($1=="Output") print $2; }')
declare NUM_OUTPUTS=${#CONNECTED_OUTPUTS[@]}

function close() {
	echo "clamshell.sh: disabling $CLAM_OUTPUT"
	swaymsg output $CLAM_OUTPUT disable
}

function open() {
	echo "clamshell.sh: enabling $CLAM_OUTPUT"
	swaymsg output $CLAM_OUTPUT enable
}

function update() {
	sleep 4
	if grep -q closed /proc/acpi/button/lid/LID?/state; then
		close
	else
		open
	fi
}

if [[ NUM_OUTPUTS > 1 ]] ; then
	if [[ ${1,,} == "close" ]] ; then
		close
	elif [[ ${1,,} == "open" ]] ; then
		open
	else
		update
	fi
fi