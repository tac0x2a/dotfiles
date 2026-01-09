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
