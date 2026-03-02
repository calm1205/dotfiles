local wezterm = require("wezterm")

local M = {}

function M.setup()
  -- Show which key table is active in the status area
  wezterm.on("update-right-status", function(window, pane)
    local name = window:active_key_table()
    if name then
      name = "TABLE: " .. name
    end
    window:set_right_status(name or "")
  end)

  -- Custom tab title format
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local background = "#000000"
    local foreground = "#808080"
    if tab.is_active then
      background = "#444444"
      foreground = "#ffffff"
    end

    local title = tab.active_pane.title
    -- カレントディレクトリがあればディレクトリ名を表示
    local cwd_uri = tab.active_pane.current_working_dir
    if cwd_uri then
      local cwd = cwd_uri.file_path or tostring(cwd_uri)
      -- パスの末尾スラッシュを除去して最後のディレクトリ名を取得
      cwd = cwd:gsub("/$", "")
      local dir_name = cwd:match("([^/]+)$") or cwd
      -- ホームディレクトリの場合は ~ を表示
      local home = os.getenv("HOME") or ""
      if cwd == home then
        dir_name = "~"
      end
      title = dir_name
    end

    return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = " " .. title .. " " },
    }
  end)
end

return M
