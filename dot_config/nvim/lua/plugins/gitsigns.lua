-- gitsigns.nvim: git差分サイン表示・カーソル行blame表示プラグイン
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
    },
  },
}
