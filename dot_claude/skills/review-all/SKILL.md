---
name: review-all
description: 7観点（architecture/logic/security/test/tradeoff/readable/refactorable）を並列レビューし、review-verifyで誤指摘を除去して統合報告
---

# 役割
全レビュー観点を並列実行→検証→統合する単一エントリ

# 入力
- 引数にPR番号があればPRモード（`gh pr diff <num>`）
- なければローカルモード（`git diff HEAD`）
- 差分が空なら「レビュー対象なし」と出力して終了

# 手順
Workflowツールで以下スクリプトを実行:

```js
export const meta = {
  name: 'review-all',
  description: '7観点並列レビュー→verify→統合',
  phases: [
    { title: 'Review', detail: 'architecture/logic/security/test/tradeoff/readable/refactorable を並列実行' },
    { title: 'Verify', detail: 'review-verify で各観点の指摘を事実確認' },
  ],
}

const target = args?.target ?? null
const diffCmd = target ? `gh pr diff ${target}` : 'git diff HEAD'
log(`Target: ${target ?? 'local (git diff HEAD)'}`)

const DIMENSIONS = [
  'review-architecture',
  'review-logic',
  'review-security',
  'review-test',
  'review-tradeoff',
  'review-readable',
  'review-refactorable',
]

const reviewPrompt = (dim) => `
レビュー対象差分は \`${diffCmd}\` の出力。
あなたの担当観点に従い指摘を列挙。
出力は markdown 箇条書き、各指摘に file:line を明記。
指摘なしなら「指摘なし」とだけ返す。
`

const verifyPrompt = (dim, review) => `
以下は ${dim} 観点のレビュー結果。
\`${diffCmd}\` とソースを照合し、各指摘が事実か検証。
誤指摘・ハルシネーションを除去し、確証ある指摘のみ残して返す。

---
${review}
`

const results = await pipeline(
  DIMENSIONS,
  (dim) => agent(reviewPrompt(dim), {
    label: dim,
    phase: 'Review',
    agentType: dim,
  }),
  (review, dim) => agent(verifyPrompt(dim, review), {
    label: `verify:${dim}`,
    phase: 'Verify',
    agentType: 'review-verify',
  }).then(verified => ({ dimension: dim, verified })),
)

return results.filter(Boolean)
```

# 出力形式
観点ごとに以下の構造で統合提示:

```markdown
## <dimension>
<verified findings>
```

指摘なし観点は見出しのみ＋「指摘なし」表記。

# ルール
- 差分取得はWorkflow内で1度だけ（各reviewerは差分コマンドを文字列で受け取る）
- review-verifyを通過した指摘のみを最終出力
- 集計時に観点を超えた重複指摘があれば1件に集約
