return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opt = {},
  config = function()
    vim.cmd[[colorscheme tokyonight]]
  end
}
