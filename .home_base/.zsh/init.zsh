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

# これらは mise で管理するので Homebrew にインストールさせない
export HOMEBREW_FORBIDDEN_FORMULAE="node python python3 pip"

#################
# Auto-Complete #
#################
# for brew zsh-completions #
[[ $(type brew) && $? == 0 ]] && {
	chmod -R go-w "$(brew --prefix)/share"
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
}
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit -u && compinit
compinit

# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# uv
[[ $(which uv) && $? == 0 ]] && eval "$(uv generate-shell-completion zsh)"
[[ $(which uvx) && $? == 0 ]] && eval "$(uvx --generate-shell-completion zsh)"

###########
# sheldon #
###########
eval "$(sheldon source)"
# Please edit ~/.config/sheldon/plugins.toml
