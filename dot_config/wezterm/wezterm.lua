local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

config.automatically_reload_config = true
config.font_size = 14.0
config.font = wezterm.font_with_fallback({
    "JetBrains Mono",  -- 英語用
    "Hiragino Sans",   -- 日本語用（macOS標準）
  })
config.default_cursor_style = 'BlinkingBlock'
config.use_ime = true
config.macos_forward_to_ime_modifier_mask = 'SHIFT'
config.window_background_opacity = 0.80
--config.window_background_opacity = 1
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

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#000000"  -- 非アクティブ: 真っ黒
  local foreground = "#808080"  -- 非アクティブ: グレー文字
  if tab.is_active then
    background = "#444444"  -- アクティブ: 明るい背景
    foreground = "#ffffff"  -- アクティブ: 白文字
  end
  local title = tab.active_pane.title
  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. title .. " " },
  }
end)

-- keybinds
config.keys = {
  {
    key = "[",
    mods = "CTRL",
    action = act.SendKey { key = "Escape" },
  },
  {
    key = "c",
    mods = "SUPER|ALT",
    action = act.ActivateCopyMode
  },
  {
    key = "]",
    mods = "SUPER|ALT",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    key = "n",
    mods = "SUPER|ALT",
    action = act.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    key = "[",
    mods = "SUPER",
    action = act.ActivatePaneDirection "Prev"
  },
  {
    key = "]",
    mods = "SUPER",
    action = act.ActivatePaneDirection "Next"
  },
}


return config
