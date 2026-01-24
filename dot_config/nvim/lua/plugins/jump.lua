return {
  'echasnovski/mini.jump2d',
  version = '*',
  config = function()
    require('mini.jump2d').setup({
      spotter = require('mini.jump2d').builtin_opts.word_start.spotter,
    })
  end,
}
