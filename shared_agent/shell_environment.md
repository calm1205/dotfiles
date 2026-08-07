# シェル環境前提

Cursor / Claude Code の Shell 実行時も `.zshrc` が読み込まれ、以下の alias が有効。

## ディレクトリ移動

- `cd` は zoxide（`z`）への alias
- プロジェクト名等の fuzzy jump には `cd <名前>` が使える
- 相対パス移動（`..`, `./subdir` 等）は `builtin cd` を使う
- ディレクトリ移動は Shell の `working_directory` に絶対パス指定を優先する

## ファイル表示

- `cat` は `gat`（Go 製 cat 代替）への alias

## 対話前提（エージェントから使わない）

- `gco` — git branch を fzf で選択して checkout
- `gpr` — gh pr list を fzf で選択して view
- `cdi` — zoxide の対話的ディレクトリ選択（`zi`）

## 自動有効化されるツール

- `direnv` — ディレクトリ入場時に `.envrc` を評価
- `mise` — ランタイムバージョン切替
- `starship` — プロンプト（出力に ANSI が含まれる場合あり）

## 利用可能な CLI

- `gh` — GitHub 操作（Issue / PR / checks 等）
- `jq` — Shell での JSON 処理

## エディタ

- `$EDITOR` は `nvim`
