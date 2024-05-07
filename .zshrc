unsetopt beep
bindkey -e

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/theme.json)"
eval "$(zoxide init zsh --cmd cd)"
source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias cat="bat"

mkcd() {
	mkdir -p $@ && cd ${@:$#}
}
