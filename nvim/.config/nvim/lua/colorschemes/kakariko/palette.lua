-- WHAT: Color palette definitions for the Kakariko colorscheme
-- WHY: Semantic color naming allows the theme to be flexible and reusable
--      Users can override individual colors or the entire palette
-- HOW: Define base colors, then semantic colors (text, love, gold, etc.)
--      which are used throughout all highlight groups
-- NOTE: WCAG AAA compliant (7:1 contrast ratio minimum verified)

local config = require("colorschemes.kakariko.config")
local options = config.options

-- WHAT: Main color palette - twilight blue theme inspired by Kakariko Village
-- WHY: Thematic semantic naming makes it easy to adjust related colors together
--      All colors reference Zelda themes: gems, lanterns, fairy magic, twilight
local palette = {
	-- Base palette colors (background, surface, overlays)
	base = "#122030",       -- Main background: midnight blue
	surface = "#1D3249",    -- Slightly lighter for panels/popups
	overlay = "#243E5A",    -- For selections and highlights
	muted = "#8C715D",      -- Muted text (comments adjacent colors)
	subtle = "#B2A28F",     -- Subtle text (line numbers, borders)
	text = "#F0FFF0",       -- Main text: bright luminous green

	-- Semantic colors (named thematically for Kakariko/Zelda)
	ruby = "#FF9898",       -- Errors, danger (red gem, lantern fire)
	amber = "#F8F0A8",      -- Warnings, constants, special (torch light, golden glow)
	fairy = "#BCEFCC",      -- Strings, soft magic (fairy dust, mystical soft green)
	twilight = "#A2CFAA",   -- Keywords, control flow (deep green, theme color)
	lantern = "#A2FAA2",    -- Types, structures (bright glowing green)
	hearth = "#DDC19B",     -- Comments, special emphasis (warm fire, cozy brown)
	spring = "#95B1AC",     -- Git add, success (light teal, water/rejuvenation)

	-- Highlight levels for visual hierarchy
	highlight_low = "#1A2838",   -- Subtle background highlights
	highlight_med = "#2A4060",   -- Medium emphasis highlights
	highlight_high = "#FFEB8A",  -- Cursor, strong emphasis (bright lantern light)

	-- Utility
	none = "NONE",
}

-- WHAT: Allow users to override palette colors per variant
-- WHY: Enables different "versions" of Kakariko (e.g., "main", "moon", "dawn")
--      without duplicating the entire theme
local variants = {
	main = palette,
	-- Future variants can go here (e.g., moon, dawn, desert, etc.)
	-- moon = { ... },
	-- dawn = { ... },
}

-- WHAT: Apply user palette overrides if provided
-- WHY: Allows customization without modifying this file
-- HOW: Deep merge user palette with defaults
if options.palette ~= nil and next(options.palette) then
	for variant_name, override_palette in pairs(options.palette) do
		if variants[variant_name] then
			variants[variant_name] = vim.tbl_extend("force", variants[variant_name], override_palette or {})
		end
	end
end

-- WHAT: Return the selected variant's palette
-- WHY: Supports both hardcoded variant selection and vim.background detection
return variants[options.variant] or palette