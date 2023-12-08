#!/bin/bash
declare CLAM_OUTPUT=${2:-eDP-1}

declare -a OUTPUTS
while IFS= read -r line; do
	OUTPUTS+=("$line")
done <<< $(swaymsg -p -t get_outputs | awk '{if ($1=="Output") print $2; }')


close() {
	echo "clamshell.sh: disabling $CLAM_OUTPUT"
	swaymsg output $CLAM_OUTPUT disable
}

open() {
	echo "clamshell.sh: enabling $CLAM_OUTPUT"
	swaymsg output $CLAM_OUTPUT enable
}

update() {
	if grep -q closed /proc/acpi/button/lid/LID?/state; then
		close
	else
		open
	fi
}

if [[ ${#OUTPUTS[@]} > 1 ]] ; then
	if [[ ${1,,} == "close" ]] ; then
		close
	elif [[ ${1,,} == "open" ]] ; then
		open
	else
		update
	fi
else
	echo "clamshell.sh: Only 1 (or 0) display's connected, skipping..."
fi
