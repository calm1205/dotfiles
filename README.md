# dotfiles

chezmoiで管理するdotfilesリポジトリ。

## セットアップ

```bash
brew install chezmoi
chezmoi init <repository>
chezmoi apply
```

## プロファイル設定

`~/.config/chezmoi/chezmoi.toml` でプロファイルを設定する。

### 会社用 (work)

```toml
[data]
  profile = "work"
```

### 個人用 (private)

```toml
[data]
  profile = "private"
```

## プロファイルによる違い

| 設定 | work | private |
|------|------|---------|
| `~/.mntsq_private` の読み込み | あり | なし |

## 手動管理ファイル

以下のファイルはchezmoiで管理せず、手動で配置する。

| ファイル | 説明 | 必要なプロファイル |
|----------|------|-------------------|
| `~/.config/zsh/mntsq.zsh` | 会社固有の秘密情報 | work |
