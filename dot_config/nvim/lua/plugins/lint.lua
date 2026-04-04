return {
  "mfussenegger/nvim-lint",
  keys = {
    {
      "<Leader>ol",
      function()
        require("lint").try_lint()
      end,
      desc = "Lint current file",
    },
  },
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "oxlint" },
      javascriptreact = { "oxlint" },
      typescript = { "oxlint" },
      typescriptreact = { "oxlint" },
      vue = { "oxlint" },
    }
  end,
}
