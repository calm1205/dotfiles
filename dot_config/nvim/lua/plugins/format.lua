return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<Leader>of",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format current file",
    },
  },
  opts = {
    formatters_by_ft = {
      ["_"] = { "oxfmt" },
    },
    formatters = {
      oxfmt = {
        command = "oxfmt",
        args = { "--stdin-filepath", "$FILENAME" },
        stdin = true,
      },
    },
  },
}
