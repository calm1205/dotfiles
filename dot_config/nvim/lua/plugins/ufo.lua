return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.number = true

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        -- LSP対応言語はLSP、それ以外はTreesitter→indentのフォールバック
        return { 'treesitter', 'indent' }
      end
    })

    -- キーマップ
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = '全fold展開' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = '全fold閉じる' })
  end,
}
