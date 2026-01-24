local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

function M.apply(config)
  config.keys = {
    {
      key = "[",
      mods = "CTRL",
      action = act.SendKey({ key = "Escape" }),
    },
    {
      key = "c",
      mods = "SUPER|ALT",
      action = act.ActivateCopyMode,
    },
    {
      key = "]",
      mods = "SUPER|ALT",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "n",
      mods = "SUPER|ALT",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "[",
      mods = "SUPER",
      action = act.ActivatePaneDirection("Prev"),
    },
    {
      key = "]",
      mods = "SUPER",
      action = act.ActivatePaneDirection("Next"),
    },
  }
end

return M
