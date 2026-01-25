return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local map = vim.keymap.set

    -- cmp-nvim-lspのcapabilitiesを全LSPサーバーに適用
    vim.lsp.config('*', {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })

    -- LSPがアタッチされた時のキーマップ設定
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local function opts(desc)
          return { buffer = ev.buf, desc = "LSP " .. desc }
        end

        local buf = vim.lsp.buf
        map("n", "gD", buf.declaration, opts "Go to declaration")
        map("n", "gd", buf.definition, opts "Go to definition")
        map("n", "gi", buf.implementation, opts "Go to implementation")
        map("n", "<leader>D", buf.type_definition, opts "Go to type definition")
        map("n", "K", buf.hover, opts "Hover")
        map("n", "<leader>rn", buf.rename, opts "Rename")
        map({ "n", "v" }, "<leader>ca", buf.code_action, opts "Code action")
        map("n", "gr", buf.references, opts "References")
      end,
    })

    -- lua_ls
    vim.lsp.config.lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              vim.fn.expand "$VIMRUNTIME/lua",
              vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
              vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
              "${3rd}/luv/library",
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    }

    -- ts_ls
    vim.lsp.config.ts_ls = {}

    -- ruby_lsp
    vim.lsp.config.ruby_lsp = {}

    -- pyright
    vim.lsp.config.pyright = {}

    -- vue_ls
    vim.lsp.config.vue_ls = {}

    -- LSPサーバーを有効化
    vim.lsp.enable({ "lua_ls", "ts_ls", "ruby_lsp", "pyright", "vue_ls" })
  end,
}
