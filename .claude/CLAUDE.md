# chezmoi dotfiles リポジトリ

## 概要
- macOS開発環境のdotfilesをchezmoiで管理
- 対象: zsh, neovim, wezterm, karabiner, starship, brew, Claude Code

## ディレクトリ構造
- `dot_*` — chezmoiが`~/.*`にデプロイするファイル群
- `dot_config/*` — `~/.config/*`にデプロイ
- `dot_claude/` — `~/.claude/`にデプロイ（グローバルCLAUDE.md等）
- `run_once_*.sh` — chezmoi初回適用時に実行されるセットアップスクリプト
- `.tmpl`拡張子 — chezmoiテンプレート（profileによる条件分岐等）

## 注意事項
- `run_once_*`スクリプトはchezmoiが一度だけ実行する。内容変更時はファイル名変更が必要な場合あり
- `.tmpl`ファイルはchezmoi templateとして処理される。Go template構文を使用
- このリポジトリ自体の`.claude/`はchezmoiデプロイ対象外（gitignoreされない作業用設定）
- `dot_claude/`がchezmoiデプロイ対象のClaude Code設定
