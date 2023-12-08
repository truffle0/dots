# zsh opts
setopt autocd extendedglob nomatch notify autolist
unsetopt beep
bindkey -v

# History config
export LESSHISTORYFILE=/dev/null
export MYSQL_HISTFILE=/dev/null
HISTFILE=/dev/null
HISTSIZE=1000

# auto completions and prompt
zstyle ':completion:*' completer _complete _ignored _correct
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'

autoload -Uz compinit
compinit

# prompt makery
function generate_color_prompt() {
	unset PROMPT

	# Create the user/machine name prefix
	if [[ `id -u` != 0 ]] ; then
		# Generate a unique color for the machine's prompt
		# Change $1 to use a different option
		local OFFSET=${1:-6}
		local MACHINE_COLOR=`hostname | md5sum | awk '{ print substr($1, '"${OFFSET}"', 6) }'`
		PROMPT="${PROMPT}%B%F{green}%n%f@%F{#${MACHINE_COLOR}}%m%f "
	else
		PROMPT="${PROMPT}%B%F{red}%m%f "
	fi

	# CWD indicator
	PROMPT="${PROMPT}%F{blue}%~%f %#%b "

	# Helpful prompt that shows (non 0) command status
	RPROMPT='%(?..[%F{yellow}%?%f])'
}
generate_color_prompt 9

# alias
alias ls="ls --color=auto"
alias ip="ip --color=auto"
alias dots='/usr/bin/git --git-dir=$HOME/.dots --work-tree=$HOME'

# Env
umask 0027
export GPG_TTY=`tty`
export LESS="${LESS} --mouse"

# Utility function declarations
if [[ `id -u` != 0 ]] ; then
	# Only available to non-root users
	function rootme() {
		exec sudo -i su
	}

	if `which sway &> /dev/null` ; then
		# Makes no sense to have this function if sway isn't installed

		function swayin() {
			# Verify this is a raw tty, not a pty
			if [[ ! `tty` =~ "/dev/tty[1234567890]" ]] ; then
				echo "Not a TTY!"
				return 1
			fi

			# General env
			export XDG_CURRENT_DESKTOP="sway"
			export MOZ_ENABLE_WAYLAND=1
			export _JAVA_AWT_WM_NONREPARENTING=1

			export QT_QPA_PLATFORMTHEME=qt5ct

			export LESS="${LESS} --mouse"
			
			# wlroots env
			export WLR_NO_HARDWARE_CURSORS=1
			#export WLR_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"
			
			# Initialise agents
			eval `ssh-agent`

			# Start sway
			exec dbus-run-session -- sway
		}
	fi
fi

function reenv() {
	echo "Restoring default system environment"
	source /etc/profile
	source ~/.zshrc
}

# expanded zsh behaviour
tcsh_autolist() { if [[ -z ${LBUFFER// } ]]
	# list dir with TAB, when there are only spaces/no text before cursor,
	# or complete words, that are before cursor only (like in tcsh)
    then BUFFER="ls " CURSOR=3 zle list-choices
    else zle expand-or-complete-prefix; fi }
zle -N tcsh_autolist
bindkey '^I' tcsh_autolist
