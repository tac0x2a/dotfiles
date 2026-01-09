# Load split zshrc files
for file in "${HOME}/.zsh/"*.zsh; do
    source "$file"
done

##################################
# ローカル設定ファイルを読み込む #
##################################
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
