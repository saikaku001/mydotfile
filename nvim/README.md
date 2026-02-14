# setting-files

## Telescope

強力なファジーファインダーとして、Telescopeが設定されています。高速な検索のために `telescope-fzf-native.nvim` 拡張が含まれています。

### 主なキーバインド

- `<leader>ff` - ファイル検索
- `<leader>fg` - 文字列検索 (live grep)
- `<leader>fb` - バッファ検索
- `<leader>fh` - ヘルプタグ検索
- `<leader>fr` - 最近開いたファイル
- `<leader>fgf` - Gitファイル検索
- `<leader>fc` - カラースキーム選択
- `<leader>fch` - コマンド履歴
- `<leader>fk` - キーマップ検索

### 必要な依存関係

`telescope-fzf-native.nvim` を使用するには、makeとCコンパイラが必要です。

#### macOS
```bash
xcode-select --install
```

#### Linux
```bash
sudo apt-get install build-essential  # Debian/Ubuntu
sudo yum groupinstall "Development Tools"  # RHEL/CentOS
```

## IME自動切り替え (im-select.nvim)

ノーマルモードに戻った際に、自動的に入力モードを英数（半角）に切り替える設定が含まれています。
この機能を使用するには、OSに応じた外部ツールのインストールが必要です。

### macOS

Homebrewを使用して `im-select` をインストールしてください。

```bash
brew tap daipeihust/tap && brew install im-select
```

### Linux (Desktop)

使用しているIMEに対応したコマンドラインツールが必要です。

- **Fcitx5**: `fcitx5-remote` (通常 `fcitx5` パッケージに含まれます)
- **Fcitx**: `fcitx-remote`
- **IBus**: `ibus` コマンド

### WSL (Windows Subsystem for Linux)

Windows側のIMEを制御するため、Windows側にツールをインストールする必要があります。

1. [im-select の Releases](https://github.com/daipeihust/im-select/releases) から `im-select.exe` をダウンロードします。
2. `im-select.exe` をWindowsのパスが通っている場所（例: `C:\Windows\System32`）に配置してください。
