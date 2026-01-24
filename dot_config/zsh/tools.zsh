# fzf
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# direnv
eval "$(direnv hook zsh)"

# br
source ~/.config/broot/launcher/bash/br

# mise
eval "$(mise activate zsh)"

# starship
eval "$(starship init zsh)"
