##############################
# Overwrite Command settings #
##############################
# ls
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lal='ls -al'


# colors
[ -x /usr/bin/dircolors ] && { # 色を付ける
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
		export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
		zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

		alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
}

# pagers
export MANPAGER="/usr/bin/less -is"
[[ -x $(command -v bat) ]] && {
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export GIT_PAGER="bat -p"

	# cat to bat
	alias cat='bat -pp'
}

[[ -x $(command -v eza) ]] && {
	alias ls='eza'
	alias ll='eza -l  --icons=auto --time-style=iso --git'
	alias la='eza -la --icons=auto --time-style=iso --git'
	alias lt="eza -T -a -I 'node_modules|.git|.cache' --icons=auto"
}

#クリップボード
if [[ "$(uname)" == 'Darwin' ]]; then
	alias clip='pbcopy' # for mac
else [[ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]];
	# alias clip='xsel --clipboard'
	alias clip='clip.exe' # for wsl
fi
