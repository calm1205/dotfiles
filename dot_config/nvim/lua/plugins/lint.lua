return {
  "mfussenegger/nvim-lint",
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "oxlint" },
      javascriptreact = { "oxlint" },
      typescript = { "oxlint" },
      typescriptreact = { "oxlint" },
      vue = { "oxlint" },
    }

    vim.keymap.set("n", "<Leader>ll", function()
      lint.try_lint()
    end, { desc = "Lint current file" })
  end,
}
