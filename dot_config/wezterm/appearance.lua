local wezterm = require("wezterm")

local M = {}

function M.apply(config)
  config.automatically_reload_config = true
  config.font_size = 14.0
  config.font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "Hiragino Sans",
  })
  config.default_cursor_style = "BlinkingBlock"
  config.use_ime = true
  config.macos_forward_to_ime_modifier_mask = "SHIFT"
  config.window_background_opacity = 0.7
  config.macos_window_background_blur = 20

  -- タイトルバーを非表示
  config.window_decorations = "RESIZE"
  -- タブバーの表示
  config.show_tabs_in_tab_bar = true
  -- タブが一つの時は非表示
  config.hide_tab_bar_if_only_one_tab = true
  -- タブバーの透過
  config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  }
  -- タブバーを背景色に合わせる
  config.window_background_gradient = {
    colors = { "#000000" },
  }
  -- タブの追加ボタンを非表示
  config.show_new_tab_button_in_tab_bar = false
  -- タブの閉じるボタンを非表示
  config.show_close_tab_button_in_tabs = false
  -- タブ同士の境界線を非表示
  config.colors = {
    tab_bar = {
      inactive_tab_edge = "none",
    },
  }
end

return M
