---
name: pr-sync
description: 現在のブランチに紐づくPRのタイトル/概要を最新のコミット内容と整合させる。git push 後の自動同期にも使用
---

# 役割
PRタイトル/概要を最新のコミット内容と整合させる更新

# 前提
- 現在のブランチに紐づくPRが存在すること
- PRが存在しなければ何もせず終了

# 手順

## 1. PR取得
- `gh pr view --json number,title,body,baseRefName` でPR情報取得
- 該当PRが無ければ即終了（`no pull requests found` 等）

## 2. 差分把握
- `git log <base>..HEAD --oneline` でコミット一覧
- `git diff <base>...HEAD` で全変更内容

## 3. 整合性チェック
- タイトルが最新のコミット群の主目的を反映しているか
- 概要（Summary / 変更内容 / Test plan等）が現在の差分と齟齬がないか
- 整合していれば更新せず終了

## 4. 更新
- `gh pr edit <番号> --title "..." --body "..."` で必要な箇所のみ更新
- bodyテンプレート構造（見出し）は維持
- issue番号の参照（`#100` 等）は残す
- Co-Authored-Byは含めない

# ルール
- タイトル: conventional commitプレフィックス付き、日本語で簡潔に
- bodyでissueを自動クローズしない（`#100` のみ、`Closes #100` 禁止）
- 既存PRテンプレートの章立てを尊重
- 不要な情報・冗長な解説を書かない
