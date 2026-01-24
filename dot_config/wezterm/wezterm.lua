local wezterm = require("wezterm")
local config = wezterm.config_builder()

local events = require("events")
local appearance = require("appearance")
local keybinds = require("keybinds")

events.setup()
appearance.apply(config)
keybinds.apply(config)

return config
