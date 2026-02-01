return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = {
        "lua",
        "python",
        "typescript",
        "html",
        "css",
        "yaml",
        "json",
        "sql",
        "markdown",
      },
      auto_install = true,
    })
  end,
}
