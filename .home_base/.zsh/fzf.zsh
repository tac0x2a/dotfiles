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
	BUFFER=$(fc -R .zsh_history && history -r -i -n 1 | fzf --query "$LBUFFER" --no-sort | sed -E 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}\s+//')
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

# Ctrl+x -> Ctrl+p : gh pr の の切り替え
function fzf-select-gh-pr(){
	local pr_number=$(gh pr list --json number,title,headRefName,updatedAt --template '{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") .title .headRefName (timeago .updatedAt)}}{{end}}' | fzf | awk '{print $1}')
	if [ ! -z $pr_number ]; then
		BUFFER="gh pr checkout '${pr_number}'"
		CURSOR="${#BUFFER}"
	else
		BUFFER=""
		CURSOR=0
	fi
	zle -R -c
}
zle -N fzf-select-gh-pr
bindkey '^x^p' fzf-select-gh-pr
