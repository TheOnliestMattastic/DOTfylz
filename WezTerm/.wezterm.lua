-- WezTerm Configuration
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- =============================================================================
-- DISPLAY & APPEARANCE
-- -----------------------------------------------------------------------------
config.font_size = 18
config.font = wezterm.font(
  'JetBrains Mono',
  { weight = 'Medium' }
)
config.color_scheme = 'tokyonight'

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
  { key = 'Enter', mods = 'SHIFT', action = act.SendString '\n' }
}

return config
