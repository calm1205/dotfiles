-- mini.jump2d: ラベル選択で画面内の単語へ高速ジャンプするプラグイン
return {
  'echasnovski/mini.jump2d',
  version = '*',
  config = function()
    require('mini.jump2d').setup({
      spotter = require('mini.jump2d').builtin_opts.word_start.spotter,
    })
  end,
}
