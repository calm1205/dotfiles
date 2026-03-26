---
name: pr
description: GitHub PRをDraftで新規作成
disable-model-invocation: true
---

# 役割
githubのpull requestの新規作成

# 対象
実行したディレクトリのリポジトリ

# ルール
- PRタイトルはconventional commitのprefixを付与（例: `feat:`, `fix:`, `refactor:` 等）。本文は日本語で簡潔に。
- PRのTEMPLATE.mdがリポジトリ内に存在していればそれを用いてPRのbodyを埋める。
- PRはDraftで作成すること。
- PRのbodyやキーワードでissueを自動クローズしないこと（`Closes #xx`, `Fixes #xx` 等を使わない）。
