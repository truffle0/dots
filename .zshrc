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
		# Generate a unique color from the machine prompt
		# Change $1 to use a different option (changes substring offset)
		local HASH=$(echo $HOST | md5sum)
		local MACHINE_COLOR=${HASH:${1:-6}:6}
		PROMPT="${PROMPT}%B%F{green}%n%f@%F{#${MACHINE_COLOR}}%m%f "
	else
		PROMPT="${PROMPT}%B%F{red}%m%f "
	fi

	# Shell level indicator for levels > 1
	#PROMPT="${PROMPT}%(2L.%F{red}(%L%)%f .)"
	
	# CWD indicator & root/user symbol
	# includes a conditional newline for terminals with <30 character space
	local NL=$'\n'
	PROMPT="${PROMPT}%F{blue}%~%f%-30(l. .${NL})%#%b "

	# Show (non 0) return status of command on the right
	RPROMPT='%(?..[%F{yellow}%?%f])'
}
generate_color_prompt 8

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
		# doing it this way allows the operation to be cancelled and return to shell
		sudo true && exec sudo -i
		sudo --reset-timestamp
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
			source ~/.config/sway/launch.sh || exec dbus-run-session -- sway || sway
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
FZF_SUM="ac0afadb98f2650e5ee8e83e7ea8cc8094a6ce9ef571d0453c96153d824bdeec"
if `which fzf &> /dev/null` && [ "$FZF_SUM" ]; then
	`echo "$FZF_SUM $(which fzf)" | sha256sum --status -c 2>/dev/null` || echo "FAILED TO VERIFY `which fzf`!"
	eval "$(fzf --zsh)"
fi
unset FZF_SUM
