# zsh opts
setopt autocd extendedglob nomatch notify autolist
unsetopt beep
bindkey -v

# History config (don't save it, it's annoying)
export LESSHISTORYFILE=/dev/null
export MYSQL_HISTFILE=/dev/null
export SQLITE_HISTORY=/dev/null
export PYTHONSTARTUP="$HOME/.pythonrc"
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

	# Helpful prompt that shows (non 0) return status
	RPROMPT='%(?..[%F{yellow}%?%f])'
}
generate_color_prompt 9

# aliaseses
alias ls="ls --color=auto"
alias ip="ip --color=auto"
[[ -d ~/.dots ]] && alias dots='/usr/bin/git --git-dir=$HOME/.dots --work-tree=$HOME'
alias fucking=sudo # yes, I'm immature :P

# Useful env
[[ `id -u` != 0 ]] && umask 0027 || umask 0022
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
			
			# Either launch sway using launcher script, fallback to dbus-run, or just sway
			source "~/.config/sway/launch.sh" || exec dbus-run-session -- sway || sway
		}
		
		# Variables that assume this is within a sway environment
		if [ -S $SWAYSOCK ] ; then
			# Gets sway to run something, so it's not a child of the terminal :)
			alias swaydo="swaymsg exec --"
			unset swayin
		fi
	fi

fi


# expanded zsh behaviour
tcsh_autolist() { if [[ -z ${LBUFFER// } ]]
	# list dir with TAB, when there are only spaces/no text before cursor,
	# or complete words, that are before cursor only (like in tcsh)
    then BUFFER="ls " CURSOR=3 zle list-choices
    else zle expand-or-complete-prefix; fi }
zle -N tcsh_autolist
bindkey '^I' tcsh_autolist

# fzf integration & verification (paranoia alert)
FZF_SUM="1c44bf524e708a5334fa2f9d0fb0d38f84dc241a33bd4da05cfd460c24d01c60"
if `which fzf &> /dev/null` && [ "$FZF_SUM" ]; then
	`echo "$FZF_SUM $(which fzf)" | sha256sum --status -c 2>/dev/null` || echo "FAILED TO VERIFY `which fzf`!"
	eval "$(fzf --zsh)"
fi
unset FZF_SUM
