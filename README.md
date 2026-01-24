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

dotfilesで管理できない機密情報は`~/.config/zsh/work_credential.zsh`に別途記載

```toml
[data]
  profile = "work"
```

### 個人用 (private)

```toml
[data]
  profile = "private"
```

