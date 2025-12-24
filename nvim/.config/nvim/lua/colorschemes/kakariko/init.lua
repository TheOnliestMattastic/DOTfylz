-- WHAT: Main entry point for the Kakariko colorscheme
-- WHY: Orchestrates loading config, palette, and applying highlights
-- HOW: Export setup() and colorscheme() functions, handle highlight application
-- NOTE: Callable as require("colorschemes.kakariko").setup() and colorscheme("kakariko")

local M = {}
local config = require("colorschemes.kakariko.config")

-- WHAT: Main function to load and apply all highlights
-- WHY: Centralizes the process of loading palette, applying highlights, terminal colors
-- HOW: Get palette and highlights, parse colors, apply with nvim_set_hl
local function set_highlights()
	local utilities = require("colorschemes.kakariko.utilities")
	local palette = require("colorschemes.kakariko.palette")
	local highlights = require("colorschemes.kakariko.highlights")

	-- WHAT: Apply before_highlight hook if defined
	-- WHY: Allows advanced users to modify highlights programmatically
	-- HOW: Call hook for each highlight before setting
	for group, highlight in pairs(highlights) do
		if config.options.before_highlight ~= nil then
			config.options.before_highlight(group, highlight, palette)
		end

		-- WHAT: Handle blend effects (alpha transparency)
		-- WHY: Creates subtle visual hierarchy with blended colors
		-- HOW: Calculate blended color, store in highlight
		if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and highlight.bg ~= nil then
			highlight.bg = utilities.blend(highlight.bg, highlight.blend_on or palette.base, highlight.blend / 100)
		end

		highlight.blend = nil
		highlight.blend_on = nil

		if highlight._nvim_blend ~= nil then
			highlight.blend = highlight._nvim_blend
		end

		-- WHAT: Apply the highlight group
		-- WHY: Neovim requires explicit setting via nvim_set_hl
		-- HOW: Call API with group name and highlight table
		vim.api.nvim_set_hl(0, group, highlight)
	end

	-- WHAT: Configure terminal color palette
	-- WHY: Ensures consistency when using embedded terminal in Neovim
	-- HOW: Set vim.g.terminal_color_* for ANSI colors 0-15
	-- NOTE: Only if enable.terminal is true
	if config.options.enable.terminal then
		vim.g.terminal_color_0 = palette.overlay      -- black
		vim.g.terminal_color_8 = palette.subtle       -- bright black
		vim.g.terminal_color_1 = palette.love         -- red
		vim.g.terminal_color_9 = palette.love         -- bright red
		vim.g.terminal_color_2 = palette.pine         -- green
		vim.g.terminal_color_10 = palette.pine        -- bright green
		vim.g.terminal_color_3 = palette.gold         -- yellow
		vim.g.terminal_color_11 = palette.gold        -- bright yellow
		vim.g.terminal_color_4 = palette.foam         -- blue
		vim.g.terminal_color_12 = palette.foam        -- bright blue
		vim.g.terminal_color_5 = palette.iris         -- magenta
		vim.g.terminal_color_13 = palette.iris        -- bright magenta
		vim.g.terminal_color_6 = palette.rose         -- cyan
		vim.g.terminal_color_14 = palette.rose        -- bright cyan
		vim.g.terminal_color_7 = palette.text         -- white
		vim.g.terminal_color_15 = palette.text        -- bright white

		-- WHAT: Support StatusLineTerm styling in terminal buffers
		-- WHY: Terminal windows should have distinct status line styling
		-- HOW: Autocmd to set window highlight on TermOpen
		vim.cmd([[
		augroup kakariko
			autocmd!
			autocmd TermOpen * if &buftype=='terminal'
				\|setlocal winhighlight=StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC
				\|else|setlocal winhighlight=|endif
			autocmd ColorSchemePre * autocmd! kakariko
		augroup END
		]])
	end
end

-- WHAT: Setup function for user configuration
-- WHY: Allows users to customize options before loading colorscheme
-- HOW: Extend config options, don't apply highlights yet
---@param options table | nil
function M.setup(options)
	config.extend_options(options or {})
end

-- WHAT: Main colorscheme loading function
-- WHY: Called when user runs :colorscheme kakariko
-- HOW: Set options, initialize Neovim, apply all highlights
---@param variant string | nil
function M.colorscheme(variant)
	-- WHAT: Extend config with variant if provided
	-- WHY: Allows :colorscheme kakariko to override variant
	-- HOW: Pass variant to config.extend_options
	config.extend_options({ variant = variant })

	-- WHAT: Enable true color support
	-- WHY: Hex colors (#RRGGBB) require GUI colors enabled
	-- HOW: Set termguicolors option
	vim.opt.termguicolors = true

	-- WHAT: Clear existing highlights
	-- WHY: Prevents conflicts with previously loaded colorscheme
	-- HOW: Clear highlight definitions, reset syntax
	if vim.g.colors_name then
		vim.cmd("hi clear")
		vim.cmd("syntax reset")
	end

	-- WHAT: Set colorscheme name
	-- WHY: Lets other plugins know which colorscheme is active
	-- HOW: Set global variable
	vim.g.colors_name = "kakariko"

	-- WHAT: Apply all highlights
	-- WHY: Load palette and highlight groups
	-- HOW: Call set_highlights()
	set_highlights()
end

return M
