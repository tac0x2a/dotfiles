
#######
# Env #
#######
export PATH="${HOME}/.bin:${PATH}"
[[ -e ~/.gnubinrc ]] && source ~/.gnubinrc

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
	zstyle ':chpwd:*' recent-dirs-max 20000
	zstyle ':chpwd:*' recent-dirs-default true
	zstyle ':chpwd:*' recent-dirs-pushd true
fi

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_all_dups # ignore duplication command history list
setopt hist_ignore_space    # ignore if start with white space
setopt hist_save_no_dups    # ignore duplicated
setopt hist_reduce_blanks   # ignore white spaces
setopt share_history        # share command history data
setopt hist_expand          # 補完時にヒストリを自動的に展開
setopt hist_no_store        # historyコマンドは履歴に登録しない
setopt extended_history     # 履歴に時刻を追加


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

#######################
# Init *env, Homebrew #
#######################
# Homebrew
[[ -d /opt/homebrew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -d /home/linuxbrew ]] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

[[ -d $HOMEBREW_PREFIX ]] && {
	eval "$(starship init zsh)"
	eval "$(mise activate zsh)"
}

#################
# Auto-Complete #
#################
# for brew zsh-completions #
[[ $(type brew) ]] && {
	chmod -R go-w "$(brew --prefix)/share"
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
}
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit -u && compinit
compinit

# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

##############
# Appearance #
##############
# About prompt, please edit ~/.config/starship.toml

########
# tmux #
########
#tmux
alias tm='tmux'
alias ta='tmux attach-session'
alias tl='tmux list-session'

[[ $SHLVL = 1 ]] && tmux

# TMUX のウィンドウ名をカレントディレクトリに
show-current-dir-as-window-name() {
	if [ $SHLVL -gt 1 ];then
		tmux set-window-option window-status-format "[${PWD:t}]" > /dev/null
		tmux set-window-option window-status-current-format "#[fg=colour16,bg=colour220,bold][${PWD:t}]" > /dev/null
	fi
}
show-current-dir-as-window-name
add-zsh-hook chpwd show-current-dir-as-window-name


# uv
[[ $(which uv) && $? == 0 ]] && eval "$(uv generate-shell-completion zsh)"
[[ $(which uvx) && $? == 0 ]] && eval "$(uvx --generate-shell-completion zsh)"

###########
# sheldon #
###########
eval "$(sheldon source)"
# Please edit ~/.config/sheldon/plugins.toml


#######
# fzf #
#######
export FZF_DEFAULT_OPTS=" -e \
 --bind=ctrl-k:kill-line,ctrl-v:page-down,alt-v:page-up,change:top \
 --reverse \
 --no-scrollbar \
 --prompt='🔍 ' --pointer='👉' \
 --color=hl:red,hl+:red,bg+:239"

# Ctrl-x -> Ctrl-f : ディレクトリの移動履歴を表示
function fzf-select-cdr() {
	local -r selected_dir=$(cdr -l |  awk '{print $2}' | fzf --no-sort)
	if [[ -n "$selected_dir" ]]; then
		BUFFER="cd ${selected_dir}"
		zle accept-line
	fi
	zle reset-prompt
}
zle -N fzf-select-cdr
bindkey '^x^f' fzf-select-cdr

# Ctrl-r : コマンドの実行履歴を表示
function fzf-select-history() {
	BUFFER=$(fc -R .zsh_history && history -i -n 1 | fzf --query "$LBUFFER" --tac --no-sort | sed -E 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}\s+//')
	CURSOR=$#BUFFER
	zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# Ctrl+x -> Ctrl+g : gcloud config configuration の切り替え
function fzf-select-gcloud-config(){
	which gcloud 2>&1 > /dev/null
	[[ $? -ne 0 ]] && return;

	local config_name=$(gcloud config configurations list | tail -n +2 | fzf | awk '{print $1}')
	if [ ! -z $config_name ]; then
		BUFFER="gcloud config configurations activate '${config_name}'"
		CURSOR="${#BUFFER}"
	else
		BUFFER=""
		CURSOR=0
	fi
	zle -R -c
}
zle -N fzf-select-gcloud-config
bindkey '^x^g' fzf-select-gcloud-config


# Ctrl+x -> Ctrl+b : git branch の切り替え
function fzf-select-git-branch(){
	git status 2>&1 > /dev/null
	[[ $? -ne 0 ]] && return;

	local branch_name=$(git branch --list | cut -c 3- | fzf --preview "git log --graph --pretty='format:%as %aN %d %s' {}" --preview-window down,70%,nowrap)
	if [ ! -z $branch_name ]; then
		BUFFER="git checkout '${branch_name}'"
		CURSOR="${#BUFFER}"
	else
		BUFFER=""
		CURSOR=0
	fi
	zle -R -c
}
zle -N fzf-select-git-branch
bindkey '^x^b' fzf-select-git-branch


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

#クリップボード
alias clip='clip.exe' # for wsl
# alias clip='xsel --clipboard'


##################################
# ローカル設定ファイルを読み込む #
##################################
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

