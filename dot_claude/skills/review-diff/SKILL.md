---
name: review-diff
description: レビュー対象の差分（未コミット変更 or PR）を取得して返す。各レビュー観点サブエージェントの前段で共通利用。
disable-model-invocation: true
---

# 役割
レビュー対象の差分取得処理を共通化。観点別レビューagent群（review-security, review-architecture, review-logic, review-test, review-tradeoff）の前段で利用。

# ワークフロー

## 1. 差分取得
- **PR番号/URLが引数にある場合**
  - `gh pr diff <番号>` で差分取得
  - `gh pr view <番号> --json title,body,baseRefName,headRefName` でメタ情報取得
- **引数なし**
  - `git diff HEAD` で未コミット差分取得
  - `git status` で未追跡ファイルを確認し、未追跡があれば `git diff --no-index /dev/null <file>` で内容を含める

## 2. 差分なし判定
- 取得結果が空なら「レビュー対象なし」と出力して終了

## 3. 差分サイズ算出
- テストファイル（`*_test.*`, `*.test.*`, `*.spec.*`, `test_*`, `tests/`, `__tests__/`）の差分行数を除外
- テスト以外の修正行数を算出

# 出力形式
```markdown
## モード
<pr | local>

## メタ情報（PRモードのみ）
- PR番号: #<num>
- タイトル: <title>
- base: <baseRefName>
- head: <headRefName>

## 差分サイズ
- テスト除外修正行数: <num>

## 差分
<gh pr diff or git diff の生出力>
```

# ルール
- 加工せず取得した差分をそのまま返す
- 差分が大きい場合も切り詰めず全量を返す
