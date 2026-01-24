local map = vim.api.nvim_set_keymap

-- window移動
map('n', '<Leader>j', '<C-w>j', { noremap = true, silent = true })
map('n', '<Leader>k', '<C-w>k', { noremap = true, silent = true })
map('n', '<Leader>l', '<C-w>l', { noremap = true, silent = true })
map('n', '<Leader>h', '<C-w>h', { noremap = true, silent = true })

-- window分割
map('n', '<Leader>s', ':<C-u>sp\n', { noremap = true })
map('n', '<Leader>v', ':<C-u>vs\n', { noremap = true })

-- window閉じる
map('n', '<Leader>w', ':<C-u>w\n',  { noremap = true })
map('n', '<Leader>q', ':<C-u>q\n',  { noremap = true })
map('n', '<Leader>wq',':<C-u>wq\n',{ noremap = true })

-- ターミナルを開く
map('n', '<Leader>tt', ':terminal\n', { noremap = true })

-- LSP警告表示
map(
  'n',
  '<Leader>d',
  ':lua vim.diagnostic.open_float()<CR>',
  { noremap = true }
)

-- カーソル移動
map('i', '<C-k>', '<Up>',    {})
map('i', '<C-j>', '<Down>',  {})
map('i', '<C-h>', '<Left>',  {})
map('i', '<C-l>', '<Right>', {})

-- Telescope
map('n', '<Leader>p', ':Telescope find_files<CR>', { noremap = true, silent = true })
map('n', '<Leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true })

