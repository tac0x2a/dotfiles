
# 補完
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
compinit

# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ディレクトリ履歴
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
	# cdr, add-zsh-hook を有効にする
	autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
	add-zsh-hook chpwd chpwd_recent_dirs

	# cdr の設定
	zstyle ':completion:*' recent-dirs-insert both
	zstyle ':chpwd:*' recent-dirs-max 500
	zstyle ':chpwd:*' recent-dirs-default true
	# zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
	zstyle ':chpwd:*' recent-dirs-pushd true
fi

# Emacs風キーバインド
bindkey -e

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# コマンド履歴検索をC-pとC-nに割り当てる
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# コマンド関連etc
setopt auto_cd           # ディレクトリ名を入れるとcd
setopt auto_pushd        # tabキーでcd履歴
setopt correct           # コマンド補完
setopt list_packed       # 補完リストを圧縮表示
setopt nolistbeep        # ビープ音を殺す
setopt multios           # マルチリダイレクト(ちょっと危険)
setopt magic_equal_subst # = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt list_types        # 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
unsetopt no_clobber      # リダイレクトで上書きを許可


##############
# Appearance #
##############
# バージョン管理ツールのブランチ表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
		psvar=()
		LANG=en_US.UTF-8 vcs_info
		[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
#RPROMPT="%1(v|%F{green}%1v%f|)"

# プロンプト
case ${UID} in
		0)
				PROMPT="
[%{[31m%}%U%n@%M %~%u%{[m%}]% %1(v|%F{green}%1v%f|) %{[31m%} # "
						PROMPT2="%{[31m%}%_%{[m%}]%> "
						SPROMPT="%{[31m%}%r is correct? [n,y,a,e]%{[m%}%: "
						[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="
[%{[37m%}%U%n@%M %~%u%{[m%}]% %1(v|%F{green}%1v%f|) %{[31m%} # "

						;;

		*)
				PROMPT="
%{[33m%}[%/] %1(v|%F{green}%1v%f|)
%{[33m%}[%n@%M ]%#%{[m%} "
				PROMPT2="%{[33m%}%_%{[m%}]%> "
				SPROMPT="%{[33m%}%r is correct? [n,y,a,e]%{[m%}%: "
				[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="
%{[37m%}[%/] %1(v|%F{white}%1v%f|)
[%n@%M ]%#%{[m%} "

				;;
esac

# 色を付ける
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls -h --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'


############
# 環境変数 #
############
export PATH="${HOME}/.bin:${PATH}"
export MANPAGER="/usr/bin/less -is"

#git用
export GIT_PAGER="lv -c"
export LV='-z -la -Ou8 -c'

##############
# エイリアス #
##############
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -la'
alias lal='ls -al'
alias lf='ls -F'

#適切なサイズで表示
alias df='df -h'
alias du='du -h'

#tmux
alias tm='tmux'
alias ta='tmux attach-session'
alias tl='tmux list-session'

#クリップボード
# alias clip='xsel --clipboard'
# Todo: fix for WSL

##################
# tmuxを自動起動 #
##################
if [ $SHLVL = 1 ];then
		tmux
fi

##########
# gibo用 #
##########
_gibo()
{
    local_repo="$HOME/.gitignore-boilerplates"
    if [ -e "$local_repo" ]; then
        compadd $( find "$local_repo" -name "*.gitignore" -exec basename \{\} .gitignore \; )
    fi
}
compdef _gibo gibo

#########
# Zinit #
#########
[[ -e ~/.zinit/bin/zinit.zsh ]] && {
	source ~/.zinit/bin/zinit.zsh

	autoload -Uz _zinit
	(( ${+_comps} )) && _comps[zinit]=_zinit

	# 補完
	zinit light zsh-users/zsh-autosuggestions

	# シンタックスハイライト
	zinit light zdharma/fast-syntax-highlighting

	# クローンしたGit作業ディレクトリで、コマンド `git open` を実行するとブラウザでGitHubが開く
	zinit light paulirish/git-open

	# Gitの変更状態がわかる ls。ls の代わりにコマンド `k` を実行するだけ。
	zinit light supercrabtree/k

	# for Peco
	zinit light mollifier/anyframe
}

#######################
# Init *env, Homebrew #
#######################
# Homebrew
[[ -d /home/linuxbrew/ ]] && {
	eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
}

# rbenv
[[ -d ~/.rbenv/bin ]] && {
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init - zsh)"
}

# pyenv
[[ -d ~/.pyenv ]] && {
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
}

# sdkman
[[ -d ~/.sdkman ]] && {
	export SDKMAN_DIR="$HOME/.sdkman"
	[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

# nvm
[[ -d ~/.nvm ]] && {
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

########
# peco #
########
# Ctrl+x -> Ctrl+f でディレクトリの移動履歴を表示
bindkey '^x^f' anyframe-widget-cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Ctrl+r
# peco でコマンドの実行履歴を表示
bindkey '^r' anyframe-widget-put-history

# Ctrl+x -> Ctrl+b
# peco でGitブランチを表示して切替え
bindkey '^x^b' anyframe-widget-checkout-git-branch

##############################
# Overwrite Command settings #
##############################
[[ -x $(whereis -b bat | awk '{print $2}') ]] && {
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	alias cat='bat --paging=never -p'
}

##################################
# ローカル設定ファイルを読み込む #
##################################
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
