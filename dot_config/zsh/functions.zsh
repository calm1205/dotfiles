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
function auto_activate_venv() {
  if [[ -d ".venv" && -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  fi
}
