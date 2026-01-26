return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('telescope').setup{
        defaults = {
          file_ignore_patterns = {
            "^%.git/",
            "node_modules/",
            "%.venv/",
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
          },
        },
      }
    end
}
