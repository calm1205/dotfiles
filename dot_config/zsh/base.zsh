export EDITOR=nvim
export PYTHONDONTWRITEBYTECODE=1

# alias
alias ls='ls --color=auto'
alias cd='z'
alias cdi='zi'
alias cat='gat'
alias vim='nvim'

# history: 入力中に矢印上下で前方一致のhistry検索
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# edit command line: Esc → e で現在入力中のコマンドラインをvimで編集
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^[e' edit-command-line
