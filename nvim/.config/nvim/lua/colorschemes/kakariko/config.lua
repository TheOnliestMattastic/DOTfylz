-- WHAT: Configuration system for the Kakariko colorscheme
-- WHY: Separates configuration from highlight definitions for flexibility
--      Users can customize theme behavior without modifying highlights
-- HOW: Provide sensible defaults, allow deep extension/override
-- NOTE: Follows rose-pine's config pattern for consistency

---@alias Variant "main"
---@alias Highlight { link: string, inherit: boolean } | { fg: string, bg: string, sp: string, bold: boolean, italic: boolean, undercurl: boolean, underline: boolean, underdouble: boolean, underdotted: boolean, underdashed: boolean, strikethrough: boolean, inherit: boolean }

local config = {}

---@class Options
config.options = {
	-- WHAT: Variant selection (main, future: moon, dawn)
	-- WHY: Allows multiple color variants of the same theme
	-- HOW: Used by palette.lua to select color scheme
	---@type Variant
	variant = "main",

	-- WHAT: Dim inactive windows for focus
	-- WHY: Helps with visual hierarchy when multiple windows open
	-- NOTE: Requires HYPERfix terminal/UI support
	dim_inactive_windows = false,

	-- WHAT: Extend background color behind borders
	-- WHY: Visual polish - borders blend with panels instead of floating
	-- NOTE: Appearance depends on border characters used
	extend_background_behind_borders = true,

	-- WHAT: Feature flags
	enable = {
		-- WHAT: Support legacy treesitter highlight groups (@attribute, @parameter, etc.)
		-- WHY: Some plugins/setups still use old treesitter naming
		-- NOTE: New treesitter uses @-prefixed groups like @variable, @function
		legacy_highlights = true,

		-- WHAT: Run configuration migrations for backwards compatibility
		-- WHY: Allows deprecating old options gracefully
		migrations = true,

		-- WHAT: Configure terminal color palette (vim.g.terminal_color_0, etc.)
		-- WHY: Ensures consistency when using terminal within Neovim
		terminal = true,
	},

	-- WHAT: Text styling options
	styles = {
		bold = true,      -- Enable bold text
		italic = true,    -- Enable italic text
		transparency = false, -- Remove backgrounds (use terminal background)
	},

	-- WHAT: User palette overrides
	-- WHY: Allows customizing individual colors without modifying theme files
	-- HOW: Merged with base palette in palette.lua
	-- EXAMPLE: palette = { main = { love = "#FF0000" } }
	---@type table<string, table<string, string>>
	palette = {},

	-- WHAT: Color groups - semantic color references
	-- WHY: Users can remap entire semantic categories (e.g., all errors to a different color)
	-- HOW: References palette colors, used in highlight definitions
	-- NOTE: These can be palette colors or hex values
	---@type table<string, string>
	groups = {
		-- UI elements
		border = "muted",         -- Window borders, separators
		link = "hearth",          -- URLs, links (warm cozy brown)
		panel = "surface",        -- Floating windows, popups

		-- Diagnostics
		error = "ruby",           -- Error messages, red squiggles (ruby gems)
		hint = "hearth",          -- Hint text (warm, helpful)
		info = "lantern",         -- Info messages (bright glow)
		ok = "spring",            -- Success, git additions (fresh water)
		warn = "amber",           -- Warnings, golden glow
		note = "twilight",        -- Notes, reminders (deep green)
		todo = "fairy",           -- TODO items (magical, soft)

		-- Git status colors
		git_add = "lantern",      -- Added files (bright glowing green)
		git_change = "fairy",     -- Modified files (soft fairy green)
		git_delete = "ruby",      -- Deleted files (red gem)
		git_dirty = "fairy",      -- Dirty/modified indicator
		git_ignore = "muted",     -- Ignored files (gray)
		git_merge = "hearth",     -- Merge conflicts (warm brown)
		git_rename = "twilight",  -- Renamed files (deep green)
		git_stage = "hearth",     -- Staged changes (warm brown)
		git_text = "fairy",       -- Diff text changes (soft green)
		git_untracked = "subtle", -- Untracked files

		-- Markdown heading colors
		h1 = "hearth",            -- # Heading 1 (warm fire)
		h2 = "lantern",           -- ## Heading 2 (bright glow)
		h3 = "fairy",             -- ### Heading 3 (magical soft)
		h4 = "amber",             -- #### Heading 4 (torch light)
		h5 = "twilight",          -- ##### Heading 5 (deep green)
		h6 = "spring",            -- ###### Heading 6 (water)
	},

	-- WHAT: Custom highlight group overrides
	-- WHY: Users can customize any highlight group without touching the theme
	-- HOW: Deep merged with default highlights after palette is loaded
	-- EXAMPLE: highlight_groups = { Normal = { bg = "NONE" } }
	---@type table<string, Highlight>
	highlight_groups = {},

	-- WHAT: Hook called before setting each highlight
	-- WHY: Advanced customization - modify highlights programmatically
	-- HOW: Called with (group_name, highlight_table, palette)
	-- EXAMPLE: Adjust all function colors, add blend effects, etc.
	---@type function | nil
	---@diagnostic disable-next-line: unused-local
	before_highlight = function(group, highlight, palette) end,
}

-- WHAT: Migration function for backwards compatibility
-- WHY: Allows deprecating old option names gracefully
-- HOW: Transform old options into new format
local function migrate(options)
	-- Future migrations can go here
	-- Example: if options.old_option then ... end
	return options
end

-- WHAT: Extend options with user-provided configuration
-- WHY: Allows users to customize theme without modifying files
-- HOW: Deep merge with defaults, run migrations
---@param options Options | nil
function config.extend_options(options)
	config.options = vim.tbl_deep_extend("force", config.options, options or {})

	if config.options.enable.migrations then
		config.options = migrate(config.options)
	end
end

return config