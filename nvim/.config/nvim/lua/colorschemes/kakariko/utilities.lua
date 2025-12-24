-- WHAT: Utility functions for color manipulation
-- WHY: Provides color parsing and blending for sophisticated highlight effects
-- HOW: Cache colors, parse hex/named colors, blend colors with alpha
-- NOTE: Based on rose-pine's utilities for consistency

local utilities = {}

-- WHAT: Convert color name to RGB triplet
-- WHY: Needed for blending calculations
-- HOW: Use Neovim's built-in color lookup, fallback to black/white
---@param color string
local function color_to_rgb(color)
	local function byte(value, offset)
		return bit.band(bit.rshift(value, offset), 0xFF)
	end

	local new_color = vim.api.nvim_get_color_by_name(color)
	if new_color == -1 then
		-- Fallback: black for dark background, white for light
		new_color = vim.opt.background:get() == "dark" and 0 or 16777215 -- 0xFFFFFF
	end

	return { byte(new_color, 16), byte(new_color, 8), byte(new_color, 0) }
end

local color_cache = {}

-- WHAT: Parse color string to normalized form
-- WHY: Supports both palette color names and hex values
-- HOW: Check cache first, then resolve from palette or Neovim color names
-- NOTE: Caching improves performance for repeated color lookups
---@param color string Palette key or hex value
function utilities.parse_color(color)
	if color_cache[color] then
		return color_cache[color]
	end

	if color == nil then
		return nil
	end

	color = color:lower()

	-- WHAT: If not hex, look up in palette
	-- WHY: Allows using semantic color names in highlights
	if not color:find("#") and color ~= "none" then
		color = require("colorschemes.kakariko.palette")[color] or vim.api.nvim_get_color_by_name(color)
	end

	color_cache[color] = color
	return color
end

local blend_cache = {}

-- WHAT: Blend two colors with alpha transparency
-- WHY: Creates subtle visual hierarchy without harsh contrast
--      e.g., blend foreground over background with 20% opacity
-- HOW: Convert to RGB, interpolate channels, convert back to hex
-- NOTE: Alpha between 0 (all background) and 1 (all foreground)
---@param fg string Foreground color
---@param bg string Background color
---@param alpha number Between 0 (background) and 1 (foreground)
function utilities.blend(fg, bg, alpha)
	local cache_key = fg .. bg .. alpha
	if blend_cache[cache_key] then
		return blend_cache[cache_key]
	end

	local fg_rgb = color_to_rgb(fg)
	local bg_rgb = color_to_rgb(bg)

	local function blend_channel(i)
		local ret = (alpha * fg_rgb[i] + ((1 - alpha) * bg_rgb[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	local result = string.format("#%02X%02X%02X", blend_channel(1), blend_channel(2), blend_channel(3))

	blend_cache[cache_key] = result
	return result
end

return utilities
