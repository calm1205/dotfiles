-- lualine.nvim: mode/branch/diagnostics等を表示するステータスライン
return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'filetype' },
                lualine_y = {},
                lualine_z = { 'location' },
            },
        })
    end,
}
