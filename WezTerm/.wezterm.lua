-- WezTerm Configuration
-- Leader key: Ctrl+X

local wezterm = require 'wezterm'
local config = wezterm.config_builder()
--config.disable_default_key_bindings = true

-- ============================================================================
-- DISPLAY & APPEARANCE
-- ============================================================================
config.font_size = 14
--config.color_scheme = 'tokyonight'

-- ============================================================================
-- GENERAL BEHAVIOR
-- ============================================================================
config.use_fancy_tab_bar = true
config.tab_max_width = 32
config.window_background_opacity = 0.95

-- ============================================================================
-- KEYBINDINGS: WINDOW SPLITS & NAVIGATION
-- ============================================================================
local act = wezterm.action
local keys = {}

-- Leader key: Ctrl+X
config.leader = { key = ' ', mods = 'CTRL' }

-- Window/pane splits (Ctrl+X followed by key)
-- Ctrl+X, - = split to right
keys[#keys + 1] = { key = 'v', mods = 'LEADER', action = act.SplitHorizontal }
-- Ctrl+X, \ = split to bottom
keys[#keys + 1] = { key = 'h', mods = 'LEADER', action = act.SplitVertical }
-- Ctrl+X, X = kill current pane
keys[#keys + 1] = { key = 'q', mods = 'LEADER', action = act.CloseCurrentPane { confirm = false } }

-- Tab operations (Ctrl+X followed by key)
-- Ctrl+X, T = new tab
keys[#keys + 1] = { key = 't', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' }
-- Ctrl+X, W = new window
keys[#keys + 1] = { key = 'w', mods = 'LEADER', action = act.SpawnWindow }
-- Ctrl+X, N = next tab
keys[#keys + 1] = { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) }
-- Ctrl+X, P = previous tab
keys[#keys + 1] = { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) }

-- Copy mode
-- Ctrl+X, V = enter copy mode
keys[#keys + 1] = { key = 'y', mods = 'LEADER', action = act.ActivateCopyMode }

-- Pane navigation (Ctrl+h/j/k/l)
keys[#keys + 1] = { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' }
keys[#keys + 1] = { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' }
keys[#keys + 1] = { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' }
keys[#keys + 1] = { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' }

-- Pane resizing (Ctrl+Arrow keys)
keys[#keys + 1] = { key = 'LeftArrow', mods = 'CTRL', action = act.AdjustPaneSize { 'Left', 5 } }
keys[#keys + 1] = { key = 'RightArrow', mods = 'CTRL', action = act.AdjustPaneSize { 'Right', 5 } }
keys[#keys + 1] = { key = 'UpArrow', mods = 'CTRL', action = act.AdjustPaneSize { 'Up', 5 } }
keys[#keys + 1] = { key = 'DownArrow', mods = 'CTRL', action = act.AdjustPaneSize { 'Down', 5 } }

-- ============================================================================
-- STANDARD WEZTERM COMMANDS (preserve common functionality)
-- ============================================================================
-- Copy/Paste
keys[#keys + 1] = { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' }
keys[#keys + 1] = { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' }

-- Tab switching (standard shortcuts)
keys[#keys + 1] = { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) }
keys[#keys + 1] = { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) }

-- Close tab
keys[#keys + 1] = { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } }

-- New window
keys[#keys + 1] = { key = 'n', mods = 'CTRL|SHIFT', action = act.SpawnWindow }

-- Scrollback
keys[#keys + 1] = { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) }
keys[#keys + 1] = { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) }

-- Zoom
keys[#keys + 1] = { key = 'Equal', mods = 'CTRL', action = act.IncreaseFontSize }
keys[#keys + 1] = { key = 'Minus', mods = 'CTRL', action = act.DecreaseFontSize }
keys[#keys + 1] = { key = '0', mods = 'CTRL', action = act.ResetFontSize }

-- Fullscreen
keys[#keys + 1] = { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen }

-- New Line
keys[#keys + 1] = { key = 'Enter', mods = 'SHIFT', action = act.SendString('\n') }

config.keys = keys

-- ============================================================================
-- RETURN CONFIG
-- ============================================================================
return config
