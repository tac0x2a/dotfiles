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
