# git checkout with fzf
gco() {
  local branch
  branch=$(git branch -a | fzf | sed 's/remotes\/origin\///' | sed 's/^\* //' | xargs)
  [ -n "$branch" ] && git checkout "$branch"
}

# gh pr view with fzf
gpr() {
  local pr
  pr=$(gh pr list | fzf --preview 'gh pr view {1}' | awk '{print $1}')
  [ -n "$pr" ] && gh pr view "$pr"
}

# ディレクトリ移動時に.venvがあれば自動activate
# VIRTUAL_ENV が存在しないパスを指している場合は deactivate してから再activate
function auto_activate_venv() {
  if [[ -n "$VIRTUAL_ENV" && ! -d "$VIRTUAL_ENV" ]]; then
    if typeset -f deactivate > /dev/null; then
      deactivate
    else
      unset VIRTUAL_ENV VIRTUAL_ENV_PROMPT
    fi
  fi
  if [[ -d ".venv" && -f ".venv/bin/activate" ]]; then
    if [[ "$VIRTUAL_ENV" != "$PWD/.venv" ]]; then
      source .venv/bin/activate
    fi
  fi
}
auto_activate_venv
