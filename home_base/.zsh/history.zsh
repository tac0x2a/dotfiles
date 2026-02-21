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
