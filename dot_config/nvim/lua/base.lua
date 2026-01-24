-- 基本設定
vim.cmd('syntax on')           -- シンタックスハイライトを有効化
vim.o.encoding = 'utf-8'       -- 文字エンコーディングをUTF-8に設定
vim.o.number = true            -- 行番号を表示
vim.o.clipboard = 'unnamed'    -- システムクリップボードと連携（yank/pasteで共有）
vim.opt.list = true                    -- 不可視文字を表示
vim.opt.listchars = { space = '·' }    -- スペースを「·」で表示
vim.o.laststatus = 2           -- ステータスラインを常に表示
vim.o.smartindent = true       -- スマートインデントを有効化（自動で適切なインデント）
vim.o.expandtab = true         -- タブをスペースに変換
vim.o.tabstop = 2              -- タブ幅を2スペースに設定
vim.o.shiftwidth = 2           -- 自動インデント幅を2スペースに設定
vim.o.wrap = false             -- 行の折り返しを無効化（横スクロール表示）
vim.o.wildmenu = true          -- コマンドライン補完を拡張モードで表示
vim.o.ruler = true             -- カーソル位置（行・列）を右下に表示
vim.o.smartcase = true         -- 検索時、大文字を含む場合のみ大文字小文字を区別
vim.o.showmatch = true         -- 対応する括弧をハイライト表示

-- ハイライト設定
vim.o.cursorline = true                           -- カーソル行をハイライト（CursorLineNrに必要）
vim.cmd('highlight LineNr ctermfg=239')           -- 行番号の色をグレー（239）に設定
vim.cmd('highlight CursorLineNr ctermfg=yellow')  -- 現在行の行番号を黄色に設定
vim.cmd('highlight NonText ctermfg=239')          -- 改行記号など非テキスト文字の色を設定
vim.cmd('highlight SpecialKey ctermfg=239')       -- タブや不可視文字の色を設定
