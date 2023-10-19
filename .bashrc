# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Similar to default, but removes all 'other' permissions
umask 0027

# Gpg stuff
GPG_TTY=$(tty)
export GPG_TTY

# Env variables that stop history being stored for stuff, it's annoying
unset HISTFILE
export LESSHISTORYFILE=-
export MYSQL_HISTFILE=/dev/null


# Put your fun stuff here.
function swayin() {
	# Start by verifying we're in a valid TTY
	if [[ `tty` =~ "/dev/tty[1234567890]" ]] ; then
		echo "Not in a valid TTY!"
		return 1
	fi

	# Set env variables
	export XDG_CURRENT_DESKTOP="sway"
	export MOZ_ENABLE_WAYLAND=1

	# Start sway
	exec dbus-run-session -- sway
}

function trim() {
	# Sets or unsets the dirtrim, since I use it alot
	if [[ -z $PROMPT_DIRTRIM ]] ; then
		PROMPT_DIRTRIM=1
	else
		unset PROMPT_DIRTRIM
	fi
}

function rootme() {
	exec sudo -i su
}

function logtls() {
	touch /tmp/ssl-key.log
	chmod 700 /tmp/ssl-key.log
	export SSLKEYLOGFILE=/tmp/ssl-key.log
}
