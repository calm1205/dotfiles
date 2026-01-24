# fzf
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# direnv
eval "$(direnv hook zsh)"

# mise
eval "$(mise activate zsh)"

# starship
eval "$(starship init zsh)"
