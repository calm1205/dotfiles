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
| **引数重複** | `extractFromCsv(csv_path)`, `OrderRepository#fetchFromDb(user_id)` 等、引数名・型または所属クラスで取得元・対象が自明 | 名前と引数（または文脈）が同じ事実を二重に述べる | 引数・文脈で自明な修飾子（`FromCsv`, `FromDb`, `InDir` 等）を削除 |
| **曖昧動詞** | `require~`, `prepare~`, `read~`, `load~`, `parse~`, `assert~`（単体または取得元・戻り値・検証対象不足）、`get~`, `has~`, `isValid~`（対象・条件不足） | 処理内容・戻り値・検証内容が想像できない | 具体動詞+取得元/キー/条件（`fetchOrderById`, `getAuthenticatedUser`, `isAuthenticated`, `hasMinimumOrderAmount(cart)` 等） |
| **for目的語** | `buildForUser`, `validateForOrder`, `calculateForCheckout` | 目的語を関数名に置くのは責務分離の失敗 | 目的語をクラス化し動詞1語化（`UserBuilder#build`, `OrderValidator#validate` 等） |
| **複数責務（And）** | `validateAndSave`, `fetchAndProcess`, `createAndNotify` | 1関数が複数操作を束ね、分割・テスト困難 | 操作ごとに関数分割、オーケストレーション層へ |
| **拡張表現（With）** | `UserWithProfile`, `OrderWithItems`, `ProductModelWithDetails` | ベース+αの付加命名で目的・役割が見えない | +αの目的を表すドメイン名（`EnrichedUser`, `ShippableOrder` 等） |
| **意図不明** | `tmp`, `data`, `result`, `flag`, `info`, `value01` | 翻訳コスト・誤解・バグ誘発 | 目的・計算内容を表す具体名 |
| **技術駆動** | `Memory`, `Flag`, `Int`, `Manager`, `Handler`, 型名そのまま | ビジネス目的が見えない | ドメイン用語・達成目的で命名 |
| **ロジックなぞり** | `isAAndBAndC...`, 条件式の直写 | 意図が伝わらない | 判定の目的名（例: `canChant`） |
| **驚き違反** | getter/カウント系が副作用を持つ | 呼び出し側の想定を裏切る | 責務分離（取得 / 判定 / 実行） |
| **データクラス名** | `~Info`, `~Data`, `~Model`（DTO 意図以外） | ロジック実装を抑制し低凝集化 | ドメイン名（`Product` 等）へ |
| **巨大化誘発** | `Manager`, `Processor`, `Controller`, `WorkflowManager` | 何でも追加可能に見える | 狭い概念ごとにクラス分割 |
| **コンテキスト混在** | 同一クラス名が文脈で意味が変わる（e.g. `Car`といっても自動車を貨物として扱い配送元、配送経路を考慮する場合と、商品として扱い価格、販売オプションを考慮する場面は大きく文脈が異なる） | 密結合・変更影響拡大 | コンテキスト別パッケージ/クラス |
| **連番命名** | `Class001`, `method002`, `changeIntValue01` | リネーム困難・コピペ増殖・テスト困難化 | 目的ベース名への組織的移行 |
| **動詞+目的語** | `addItemToParty`, `exportParamsToCsv` が関係ないクラスに存在 | 責務外メソッド増殖 | 目的語をクラス化し動詞1語化 |
| **boolean 居場所違い** | `Common.isMemberInConfusion(member)` | 関心事と定義場所の不一致 | 「クラス名 is 状態」テストで移動 |
| **不自然な省略** | `trFee`, `LRF`, `dod` | コメント依存・意図不明 | フルスペル（`totalRentalFee` 等） |
| **形容詞混在** | 同一クラスを形容詞をつけて呼び分けている（e.g. 同じTicketクラスだが60歳以上ならシニア料金） | 概念の境界が曖昧 | 形容詞差分を別クラス化 |

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

### 処理・戻り値テスト

名前だけで次の両方が想像できるか。

- **処理:** 何をするか（取得・検証・構築・永続化等）
- **戻り値:** 何が返るか（`Order`, `Config`, `void` 等）

取得元（`FromFile`, `FromDb`, `ById` 等）は、**引数・文脈だけでは判別できないとき**名前に含める。
引数名・型、または所属クラスで取得元や対象が一意に決まるなら、名前に含めない。

- ❌ `loadConfig()`, `parseConfig()`, `read(id)` — 処理・戻り値のどちらかが不明
- ❌ `extractDriveDocumentUrlsFromCsv(csv_path)` — `csv_path` で CSV 由来は自明
- ✅ `fetchOrderById(id)`, `getUserFromRepository(id)` — `id` だけでは取得元が不明
- ✅ `extractDriveDocumentUrls(csv_path)`, `fetchConfig(config_file_path)` — 引数で取得元が自明
- ✅ `OrderRepository#fetch(user_id)` — Repository 文脈で DB 取得は自明

### 曖昧動詞アラート

`require` / `prepare` / `read` / `load` / `parse` / `assert` は汎用動詞であり、処理内容と戻り値が名前から読み取れない。

- ❌ `require(user)`, `prepare(order)`, `read(id)`, `loadConfig()`, `parseConfig()`, `loadUser(id)`, `assert(user)`, `getData()`, `hasPermission()`, `isValid(order)` — 何を保証・構築・取得・検証するか不明
- ✅ `buildShipment(order)`, `fetchOrderById(id)`, `getConfig(config_file_path)`, `canCheckout(order)`, `hasMinimumOrderAmount(cart)`

名前だけで次を答えられるか確認する。

- 副作用はあるか（検証失敗で例外、DB書込、外部API呼出等）
- 副作用がなければ、なぜその汎用動詞なのか

### 引数自明テスト

関数名から `FromX` / `InY` / `ByZ` 等の修飾子を取り除き、**引数シグネチャだけ**で同じ事実が読めるか。

- ❌ `extractDriveDocumentUrlsFromCsv(csv_path: Path)` → `csv_path` で CSV は自明
- ✅ `extractDriveDocumentUrls(csv_path: Path)`
- ❌ `collectDriveDocumentUrlsInMappingsDir(mappings_dir: Path)` → `mappings_dir` でディレクトリ走査は自明
- ✅ `collectDriveDocumentUrls(mappings_dir: Path)`
- ❌ `OrderRepository#fetchFromDb(user_id: UserId)` → Repository 文脈で DB 取得は自明
- ✅ `OrderRepository#fetch(user_id: UserId)`
- ✅ `fetchOrderById(id: OrderId)` — `id` だけでは DB / キャッシュ / API の区別がつかないため `ById` は残す

**原則:** 引数または所属クラスで自明な事実は命名に含めない。名前は引数・文脈が伝えない情報（戻り値の意味、処理の目的、取得元の曖昧さの解消）に使う。

### for目的語アラート

関数名に `for{目的語}` が含まれる場合、**禁止**。
目的語を関数名に置くのは、その概念への責務が分離できていない証拠。

- ❌ `buildPayloadForWebhook(event)`, `validateForCheckout(cart)`, `calculateTaxForOrder(order)`
- ✅ `WebhookPayloadBuilder#build(event)`, `CheckoutValidator#validate(cart)`, `OrderTaxCalculator#calculate(order)`

目的語（`User`, `Order`, `Checkout` 等）をクラス名に抽出し、メソッドは動詞1語にする。

名前だけで次を答えられるか確認する。

- 目的語（`User`, `Order`, `Checkout` 等）をクラス名に抽出できているか
- メソッド名は動詞1語になっているか

### And アラート

関数名に `And` が含まれる場合、複数責務の危険信号として扱う。

- ❌ `validateAndSave(order)` — 検証と永続化が混在
- ✅ `validate(order)` / `save(order)`、呼び出し側またはユースケース層で合成

「AしてBする」が1語で読めるなら、分割またはオーケストレーション層への移動を検討する。

### With / Data / Model アラート

型名の `With` は、ベースモデルへの付加（+α）を示す。
`~Data` / `~Model` も容器名であり、目的・役割を隠す。

- ❌ `UserWithProfile`, `OrderData`, `ProductModelWithInventory`
- ✅ `RegisteredUser`, `CheckoutOrder`, `StockedProduct`（+αの目的を名前化）

「何を足したか」ではなく「その合成が何のためか」を名前に反映する。

## 指摘の重大度

| レベル | 基準 | 例 |
|--------|------|-----|
| 🔴 **Critical** | 誤解・バグ・設計崩壊を直接招く | 驚き違反、`tmp` だらけ、Manager への無制限追加 |
| 🟡 **Warning** | 保守性・拡張性を著しく下げる | 曖昧動詞（`load~`/`parse~`/`assert~` 含む）、引数重複（`FromCsv` 等）、`for~` 目的語、技術駆動命名、And 複数責務、With 拡張命名、動詞+目的語の責務逸脱 |
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

### 例6: And 複数責務

```java
void validateAndSave(Order order) { ... }
```

- 🟡 検証と永続化が1関数に混在
- 提案: `validate(order)` / `save(order)`、ユースケース層で順序制御

### 例7: With 拡張命名

```java
class UserWithProfile { ... }
class OrderData { ... }
```

- 🟡 ベース+α・容器名で目的が不明
- 提案: `RegisteredUser`, `CheckoutOrder` 等、+αの役割を表す名前

### 例8: 曖昧動詞

```java
void prepare(CheckoutSession session) { ... }
Order read(String id) { ... }
void require(Member member) { ... }
void assert(Member member) { ... }
Object getData() { ... }
boolean isValid(Order order) { ... }
```

- 🟡 初期化・取得・検証のどれか不明、処理・戻り値・検証内容が想像できない
- 提案: `initializePayment(session)`, `fetchOrderById(id)`, `member.canPurchase(item)`, `isAuthenticated(member)`, `fetchCheckoutSummary()`, `canCheckout(order)`

### 例9: for目的語

```java
Payload buildPayloadForWebhook(Event event) { ... }
void validateForCheckout(Cart cart) { ... }
```

- 🟡 目的語が関数名に残り、責務分離が不十分
- 提案: `WebhookPayloadBuilder#build(event)`, `CheckoutValidator#validate(cart)`

### 例10: 引数重複（FromX）

```python
def extract_drive_document_urls_from_csv(csv_path: Path) -> list[str]: ...
```

- 🟡 `csv_path` 引数で CSV 由来は自明。`from_csv` は冗長
- 提案: `extract_drive_document_urls(csv_path: Path)`

## 例外（指摘しない／慎重に）

| ケース | 条件 |
|--------|------|
| ループカウンタ | `i`, `j` 等、スコープが極小 |
| 慣習的略語 | `SNS`, `VIP`, `DTO`, `HTTP` 等、チーム内共通 |
| CQRS 参照系 DTO | 参照専用・`final` フィールド・更新系で未使用 |
| フルエント API | `withRetryPolicy()` 等、ビルダー/設定チェーンの `with~` |
| I/O プロトコル | `InputStream#read`, `Reader#read` 等、入出力がクラスの本質である場合 |
| 言語/フレームワーク慣習 | Node.js `require()`, Rust `std::io::Read` 等、エコシステム標準 |

