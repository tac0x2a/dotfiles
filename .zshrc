
#################
# Auto-Complete #
#################
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit
compinit

# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# AWS
aws_completer_path=$(whereis aws_completer | awk '{print $2}')
[[ -x $aws_completer_path ]] && {
	complete -C $aws_completer_path aws
}

###########
# History #
###########
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

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt hist_ignore_all_dups # ignore
setopt hist_ignore_space    # ignore if start with white space
setopt hist_save_no_dups    # ignore duplicated
setopt share_history        # share command history data
setopt hist_reduce_blanks   # ignore white spaces
setopt hist_expand          # 補完時にヒストリを自動的に展開
setopt inc_append_history   # 履歴をインクリメンタルに追加


#############
# Key Binds #
#############
# Emacs風キーバインド
bindkey -e

# コマンド履歴検索をC-pとC-nに割り当てる
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-beginning-search-backward-end history-beginning-search-forward-end) # https://github.com/zsh-users/zsh-autosuggestions/issues/619#issuecomment-904193190

############
# Zsh Misc #
############
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
# Prompt は starship.toml を参照

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

show-current-dir-as-window-name() {
	if [ $SHLVL -gt 1 ];then
		tmux set-window-option window-status-format "[${PWD:t}]" > /dev/null
		tmux set-window-option window-status-current-format "#[fg=colour16,bg=colour220,bold][${PWD:t}]" > /dev/null
	fi
}
show-current-dir-as-window-name
add-zsh-hook chpwd show-current-dir-as-window-name

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

######
# Zi #
######
if [[ -e ~/.zi/bin/zi.zsh ]]; then
  source ~/.zi/bin/zi.zsh

	autoload -Uz _zi
	(( ${+_comps} )) && _comps[zi]=_zi
	zicompinit

	# 補完
	zi light zsh-users/zsh-autosuggestions

	# シンタックスハイライト
	# zi light zdharma/fast-syntax-highlighting # 重すぎる

	# クローンしたGit作業ディレクトリで、コマンド `git open` を実行するとブラウザでGitHubが開く
	zi light paulirish/git-open

	# Gitの変更状態がわかる ls。ls の代わりにコマンド `k` を実行するだけ。
	zi light supercrabtree/k

	# for Peco
	zi light mollifier/anyframe
fi

#######################
# Init *env, Homebrew #
#######################
# Homebrew
[[ -d /home/linuxbrew/ ]] && {
	eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

	eval "$(starship init zsh)"
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

# Ctrl+x -> Ctrl+g
# peco で gcloud config configuration の切り替え
switch_gcloud_config(){
	which gcloud 2>&1 > /dev/null
	if [ $? -ne 0 ]; then
		return
	fi

	BUFFER="⌛Loading gcloud configurations ...⌛"
	zle -R -c

	local config_name=$(gcloud config configurations list | tail -n +2 | peco | awk '{print $1}')
	if [ ! -z $config_name ]; then
		BUFFER="gcloud config configurations activate '${config_name}'"
		CURSOR=$(( ${#BUFFER} ))
	else
		BUFFER=""
		CURSOR=0
	fi
	zle -R -c
}
zle -N switch_gcloud_config
bindkey '^x^g' switch_gcloud_config


##############################
# Overwrite Command settings #
##############################
[[ -x $(whereis -b bat | awk '{print $2}') ]] && {
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export GIT_PAGER="bat -p"
	alias cat='bat --paging=never -p'
}

##################################
# ローカル設定ファイルを読み込む #
##################################
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
