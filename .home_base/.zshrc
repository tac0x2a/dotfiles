# Load split zshrc files
source "${HOME}/.zsh/env.zsh"
source "${HOME}/.zsh/history.zsh"
source "${HOME}/.zsh/keybinds.zsh"
source "${HOME}/.zsh/options.zsh"
source "${HOME}/.zsh/init.zsh"
source "${HOME}/.zsh/tmux.zsh"
source "${HOME}/.zsh/fzf.zsh"
source "${HOME}/.zsh/aliases.zsh"

##################################
# ローカル設定ファイルを読み込む #
##################################
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
