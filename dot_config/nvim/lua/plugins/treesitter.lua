return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
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
  }
}
