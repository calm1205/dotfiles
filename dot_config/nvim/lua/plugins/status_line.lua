return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        sections = {
            lualine_c = {
                { 'filename', path = 3 },
            },
            lualine_x = { 'filetype' },
        },
    },
}
