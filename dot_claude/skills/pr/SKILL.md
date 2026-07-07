---
name: pr
description: GitHub PRをDraftで新規作成
disable-model-invocation: true
---

# 役割
GitHub Pull Requestの新規Draft作成

# ワークフロー

## 1. 事前確認
- `git status`で未コミットの変更がないことを確認。あればユーザーに報告して中断
- `git log <base>..HEAD`で含まれるコミットを確認
- リモートに未pushのコミットがあれば`git push -u`

## 2. PR作成
- `gh pr create --draft`で作成
- PRテンプレート（`.github/PULL_REQUEST_TEMPLATE.md`等）があれば使用
- base branchは引数指定があればそれを使用、なければ`development`

# 完了条件
- [ ] Draftとして作成済み
- [ ] タイトルが日本語かつ簡潔
- [ ] タイトルにconventional commitプレフィックス付き（`feat:`, `fix:`, `refactor:`等）
- [ ] base branchが引数指定（なければ`development`）と一致
- [ ] PRテンプレートがあれば反映済み
- [ ] issue参照は番号のみ（`#100`）で自動クローズ構文（`Closes #100`等）を含まない
