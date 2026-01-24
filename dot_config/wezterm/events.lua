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
    return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = " " .. title .. " " },
    }
  end)
end

return M
