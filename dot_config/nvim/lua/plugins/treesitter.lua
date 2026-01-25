return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = { "lua", "python", "typescript", "rust", "html", "css" },
    auto_install = true,
  }
}
