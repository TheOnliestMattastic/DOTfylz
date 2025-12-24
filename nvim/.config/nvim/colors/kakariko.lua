-- WHAT: Colorscheme loader for Kakariko theme
-- WHY: Neovim needs a colors/*.lua file for :colorscheme command to work
-- HOW: Thin wrapper that calls the modular colorscheme setup and loader
-- NOTE: All actual logic is in /lua/colorschemes/kakariko/

local colorschemes = require("colorschemes")
colorschemes.kakariko.setup()
colorschemes.kakariko.colorscheme()
