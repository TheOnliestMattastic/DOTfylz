-- WezTerm Configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- =============================================================================
-- DISPLAY & APPEARANCE
-- -----------------------------------------------------------------------------
config.font_size = 13
config.color_scheme = "Tokyo Night"
config.font = wezterm.font "JetBrainsMono Nerd Font"
config.warn_about_missing_glyphs = false

-- ============================================================================
-- GENERAL BEHAVIOR
-- -----------------------------------------------------------------------------
config.use_fancy_tab_bar = true
config.tab_max_width = 32
config.window_background_opacity = 0.95

-- =============================================================================
-- KEYMAPS
-- -----------------------------------------------------------------------------
local act = wezterm.action
config.keys = {
	{ key = "Enter", mods = "SHIFT", action = act.SendString("\n") },
}

return config
