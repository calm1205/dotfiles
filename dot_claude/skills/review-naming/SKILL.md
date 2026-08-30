---
name: review-naming
description: 目的駆動名前設計にもとづき不適切な命名を検出し改善案を提示する。変数・メソッド・クラス名のレビュー、命名の指摘、リファクタ提案、PRの命名チェック、名前設計の相談時に使用する。「命名」「名前設計」「naming review」等を明示しなくても、コード変更に新規命名が含まれるなら使用する。
---

# 不適切な命名を指摘する

## 概要

命名は可読性だけでなく、関心の分離・疎結合高凝集に直結する設計行為。
本Skillは**目的駆動名前設計**の観点で、名前から意図・目的・責務が読み取れるかを検査する。

**指摘の基準:** 名前が構造を歪めたり、解釈コストを増やしたり、驚きを生むなら指摘する。
慣習的省略（`i`, `j`, `SNS`, `VIP`）や CQRS 参照系 DTO など、意図が明確な例外は過剰指摘しない。

## 使用すべきとき

- 新規・変更コードの命名レビュー
- PR / diff にクラス・メソッド・変数名が含まれるとき
- リファクタ前の命名監査
- 「この名前どう？」「命名を見て」等の相談

## レビュー手順

1. **対象を列挙** — 変更・追加された識別子（クラス / メソッド / 変数 / パッケージ）
2. **スメル照合** — 下記「命名スメル早見表」で該当パターンを特定
3. **意図テスト** — 各名前について「何の目的か」を1文で言えるか確認
4. **構造影響** — 名前がクラス肥大化・責務混在・密結合を誘発していないか確認
5. **改善案提示** — 指摘ごとに具体的な代替名と、必要ならクラス分割案を示す

## 命名スメル早見表

| スメル | 検出シグナル | 問題 | 改善の方向 |
|--------|-------------|------|-----------|
| **意図不明** | `tmp`, `data`, `result`, `flag`, `info`, `value01` | 翻訳コスト・誤解・バグ誘発 | 目的・計算内容を表す具体名 |
| **技術駆動** | `Memory`, `Flag`, `Int`, `Manager`, `Handler`, 型名そのまま | ビジネス目的が見えない | ドメイン用語・達成目的で命名 |
| **ロジックなぞり** | `isAAndBAndC...`, 条件式の直写 | 意図が伝わらない | 判定の目的名（例: `canChant`） |
| **驚き違反** | getter/カウント系が副作用を持つ | 呼び出し側の想定を裏切る | 責務分離（取得 / 判定 / 実行） |
| **データクラス名** | `~Info`, `~Data`（DTO 意図以外） | ロジック実装を抑制し低凝集化 | ドメイン名（`Product` 等）へ |
| **巨大化誘発** | `Manager`, `Processor`, `Controller`, `WorkflowManager` | 何でも追加可能に見える | 狭い概念ごとにクラス分割 |
| **コンテキスト混在** | 同一クラス名が文脈で意味が変わる（`Account`, `Car`） | 密結合・変更影響拡大 | コンテキスト別パッケージ/クラス |
| **連番命名** | `Class001`, `method002`, `changeIntValue01` | リネーム困難・TPS化 | 目的ベース名への組織的移行 |
| **動詞+目的語** | `addItemToParty`, `exportParamsToCsv` が関係ないクラスに存在 | 責務外メソッド増殖 | 目的語をクラス化し動詞1語化 |
| **boolean 居場所違い** | `Common.isMemberInConfusion(member)` | 関心事と定義場所の不一致 | 「クラス名 is 状態」テストで移動 |
| **不自然な省略** | `trFee`, `LRF`, `dod` | コメント依存・意図不明 | フルスペル（`totalRentalFee` 等） |
| **形容詞混在** | 同一変数に「新品/中古」「要注意」等の差が形容詞のみ | 概念の境界が曖昧 | 形容詞差分を別クラス化 |

## クイック検証ヒューリスティック

### 目的テスト

名前だけを見て次を答えられるか。

- 何を**達成**する名前か（存在ではなく目的）
- どの**関心事**に属するか
- より具体的・狭い名前に置き換えられないか

### boolean 配置テスト

`is~` / `has~` / `can~` メソッドは **「{クラス名} is {状態}」** と読んで自然な英語になるか。

- ❌ `Common is member in confusion.`
- ✅ `Member is in confusion.` → `Member#isInConfusion()`

### 驚き最小テスト

名前から想像される副作用と、実装の副作用は一致するか。

- ❌ `itemCount()` がギフトポイント加算も行う
- ✅ `itemCount()` / `shouldAddGiftPoint()` / `tryAddGiftPoint()` に分離

### 動詞1語テスト

メソッドが「動詞+目的語」なら、目的語をクラスに抽出できないか。

- ❌ `Enemy#addItemToParty`
- ✅ `PartyItems#add`

### 形容詞アラート

説明に形容詞が必要なら、別概念の可能性。

- 「要注意会員の User」→ `FlaggedUser` / `WatchlistMember`
- 「補正後の最大 HP」→ `CorrectedMaxHitPoint`

## 指摘の重大度

| レベル | 基準 | 例 |
|--------|------|-----|
| 🔴 **Critical** | 誤解・バグ・設計崩壊を直接招く | 驚き違反、`tmp` だらけ、Manager への無制限追加 |
| 🟡 **Warning** | 保守性・拡張性を著しく下げる | 技術駆動命名、動詞+目的語の責務逸脱 |
| 🟢 **Suggestion** | より良い名前があり改善余地 | やや広い名前、省略の余地 |

## 出力フォーマット

```markdown
# 命名レビュー

## サマリー
- 指摘: Critical N / Warning N / Suggestion N
- 総評: （1〜2文）

## 指摘一覧

### 🔴 [Critical] `{識別子}` — {スメル名}
- **現状:** `{現在の名前}`
- **問題:** {なぜ不適切か}
- **提案:** `{改善後の名前}`
- **補足:** {クラス分割等が必要なら記載}

### 🟡 [Warning] ...
```

指摘がゼロの場合は「問題なし」のみ出力する。問題のない命名は出力に含めない。

## 代表例

### 例1: 意図不明 + 省略

```java
int trFee = brFee + LRF * dod;
```

- 🔴 省略により意図が読めない
- 提案: `totalRentalFee = basicRentalFee + LATE_RENTAL_FEE_PER_DAY * daysOverdue`

### 例2: ロジックなぞり

```java
boolean isMemberHpMoreThanZeroAndIsMemberCanActAnd...
```

- 🔴 目的が不明
- 提案: `canChant(Member member)`

### 例3: 驚き最小違反

```java
int itemCount() {
    // カウント以外にギフトポイント加算
}
```

- 🔴 名前と振る舞いの不一致
- 提案: `itemCount()` / `shouldAddGiftPoint()` / `tryAddGiftPoint()` に分離

### 例4: Manager 肥大化

```java
class MemberManager {
    int getHitPoint(...);
    void startWalkAnimation(...);
    void exportParamsToCsv();
    boolean enemyIsAlive(...);
    void playBgm(...);
}
```

- 🔴 単一責任違反、巨大化の温床
- 提案: `HitPoint`, `WalkAnimation`, `MemberCsvExporter`, `Enemy`, `BgmPlayer` 等へ分割

### 例5: 動詞+目的語の居場所違い

```java
class Enemy {
    boolean addItemToParty(List<Item> items) { ... }
}
```

- 🟡 敵の関心事外
- 提案: `PartyItems#add(Item)`

## 例外（指摘しない／慎重に）

| ケース | 条件 |
|--------|------|
| ループカウンタ | `i`, `j` 等、スコープが極小 |
| 慣習的略語 | `SNS`, `VIP`, `DTO`, `HTTP` 等、チーム内共通 |
| CQRS 参照系 DTO | 参照専用・`final` フィールド・更新系で未使用 |
| 組込み/low-level | ハードウェア直アクセス層（可能な限り目的は残す） |

