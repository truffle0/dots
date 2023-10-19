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
. ~/.zshcomp
autoload -U promptinit
promptinit; prompt gentoo

# custom prompt
RPROMPT='%(?..[%F{yellow}%?%f])'
PROMPT='%B%F{green}%n%f@%F{magenta}%m%f %F{blue}%~%f %#%b '

# alias'
alias ls="ls --color=auto"
alias ip="ip --color=auto"
alias dots='/usr/bin/git --git-dir=$HOME/.dots --work-tree=$HOME'

# Env
umask 0027
GPG_TTY=`tty`
export GPG_TTY

# functions
unset swayin # doesn't port well from .bashrc
function swayin() {
	# Verify this is a raw tty, not a pty
	if [[ ! `tty` =~ "/dev/tty[1234567890]" ]] ; then
		echo "Not a valid TTY!"
		return 1
	fi

	# Set env variables
	export XDG_CURRENT_DESKTOP="sway"
	export MOZ_ENABLE_WAYLAND=1
	
	export LESS="${LESS} --mouse"

	# Start sway
	exec dbus-run-session -- sway
}

function rootme() {
	exec sudo -i su
}

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
