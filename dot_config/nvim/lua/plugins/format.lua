return {
  "stevearc/conform.nvim",
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        vue = { "oxfmt" },
      },
      formatters = {
        oxfmt = {
          command = "oxfmt",
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
        },
      },
    })

    vim.keymap.set("n", "<Leader>of", function()
      conform.format({ async = true })
    end, { desc = "Format current file" })
  end,
}
