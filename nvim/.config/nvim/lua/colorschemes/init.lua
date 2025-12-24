-- WHAT: Top-level colorschemes module entry point
-- WHY: Allows easy loading of any colorscheme
-- HOW: Re-export individual colorscheme modules
-- NOTE: Can extend with more themes as they're refactored

return {
	-- Dark themes
	kakariko = require("colorschemes.kakariko"),        -- Dark theme (Kakariko Village - deep green/blue)
}
