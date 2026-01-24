# load secret (work only)
{{- if eq .profile "work" }}
[[ -f ./mntsq.zsh ]] && source ./mntsq.zsh
{{- end }}

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init - zsh)"

