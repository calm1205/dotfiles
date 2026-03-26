---
name: fix-issue
description: GitHub Issue番号を受け取り、内容に基づいてコード修正・commit・PR Draft作成まで一括実行
args: issue_number
---

# 役割
GitHub Issueの内容に基づくコード修正からPR作成までの一括実行

# 入力
- `$ARGUMENTS` にissue番号が渡される（例: `123`, `#123`）

# 手順

## 1. Issue取得
- `gh issue view <番号>` でissueのタイトル・本文・ラベルを取得
- issueの内容を理解し、修正方針を決定

## 2. ブランチ作成
- mainブランチから新規ブランチを作成
- ブランチ名: `fix/issue-<番号>` または `feat/issue-<番号>`（issueの種類に応じて）

## 3. コード修正
- issueの要件に基づきコードを修正
- 必要に応じてテストも追加・修正

## 4. コミット
- stageされていない変更を対象
- メッセージは日本語で簡潔に
- 1コミット1責務で小さく分割
- conventional commit形式
- Co-Authored-Byは含めない
- コミットメッセージの末尾に `(close #<番号>)` を付与

## 5. PR Draft作成
- PRタイトルはconventional commitのprefixを付与（例: `feat:`, `fix:` 等）。本文は日本語で簡潔に。
- PRのTEMPLATE.mdがリポジトリ内に存在していればそれを用いてPRのbodyを埋める。
- PRはDraftで作成
- bodyに `Close #<番号>` を含める

# ルール
- issueが見つからない場合はエラーを報告して終了
- 修正方針が不明確な場合はユーザーに確認
