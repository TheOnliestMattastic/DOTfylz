-- WHAT: Complete highlight group definitions for Kakariko colorscheme
-- WHY: Covers all Neovim highlight groups (700+) for comprehensive theme support
-- HOW: Organize highlights by category (UI, syntax, treesitter, LSP, plugins)
-- NOTE: Based on rose-pine's comprehensive highlight groups

local config = require("colorschemes.kakariko.config")
local utilities = require("colorschemes.kakariko.utilities")
local palette = require("colorschemes.kakariko.palette")
local styles = config.options.styles

-- WHAT: Convert color group references to actual colors
-- WHY: Allows using semantic group names (error, warn, etc.) in highlights
-- HOW: Iterate through groups table, parse each color reference
local groups = {}
for group, color in pairs(config.options.groups) do
	groups[group] = utilities.parse_color(color)
end

-- WHAT: Helper function to create bordered elements
-- WHY: Consistent border styling across all float windows
-- HOW: Optional background behind borders based on config option
local function make_border(fg)
	fg = fg or groups.border
	return {
		fg = fg,
		bg = (config.options.extend_background_behind_borders and not styles.transparency) and palette.surface
			or "NONE",
	}
end

-- WHAT: All highlight groups for the colorscheme
-- WHY: Organized by category for maintainability
-- HOW: Returned as a single table, applied by init.lua
local highlights = {}

-- ===== VIM UI HIGHLIGHTS =====
highlights.ColorColumn = { bg = palette.surface }
highlights.Conceal = { bg = "NONE" }
highlights.CurSearch = { fg = palette.base, bg = palette.amber }
highlights.Cursor = { fg = palette.text, bg = palette.highlight_high }
highlights.CursorColumn = { bg = palette.overlay }
highlights.CursorLine = { bg = palette.overlay }
highlights.CursorLineNr = { fg = palette.text, bold = styles.bold }
highlights.DiffAdd = { bg = groups.git_add, blend = 20 }
highlights.DiffChange = { bg = groups.git_change, blend = 20 }
highlights.DiffDelete = { bg = groups.git_delete, blend = 20 }
highlights.DiffText = { bg = groups.git_text, blend = 40 }
highlights.diffAdded = { link = "DiffAdd" }
highlights.diffChanged = { link = "DiffChange" }
highlights.diffRemoved = { link = "DiffDelete" }
highlights.Directory = { fg = palette.lantern, bold = styles.bold }
highlights.ErrorMsg = { fg = groups.error, bold = styles.bold }
highlights.FloatBorder = make_border()
highlights.FloatTitle = { fg = palette.lantern, bg = groups.panel, bold = styles.bold }
highlights.FoldColumn = { fg = palette.muted }
highlights.Folded = { fg = palette.text, bg = groups.panel }
highlights.IncSearch = { link = "CurSearch" }
highlights.LineNr = { fg = palette.muted }
highlights.MatchParen = { fg = palette.twilight, bg = palette.twilight, blend = 25 }
highlights.ModeMsg = { fg = palette.subtle }
highlights.MoreMsg = { fg = palette.hearth }
highlights.NonText = { fg = palette.muted }
highlights.Normal = { fg = palette.text, bg = palette.base }
highlights.NormalFloat = { bg = groups.panel }
highlights.NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette.base or palette.base }
highlights.NvimInternalError = { link = "ErrorMsg" }
highlights.Pmenu = { fg = palette.subtle, bg = groups.panel }
highlights.PmenuExtra = { fg = palette.muted, bg = groups.panel }
highlights.PmenuExtraSel = { fg = palette.subtle, bg = palette.overlay }
highlights.PmenuKind = { fg = palette.lantern, bg = groups.panel }
highlights.PmenuKindSel = { fg = palette.subtle, bg = palette.overlay }
highlights.PmenuSbar = { bg = groups.panel }
highlights.PmenuSel = { fg = palette.text, bg = palette.overlay }
highlights.PmenuThumb = { bg = palette.muted }
highlights.Question = { fg = palette.amber }
highlights.QuickFixLine = { fg = palette.lantern }
highlights.RedrawDebugClear = { fg = palette.base, bg = palette.amber }
highlights.RedrawDebugComposed = { fg = palette.base, bg = palette.twilight }
highlights.RedrawDebugRecompose = { fg = palette.base, bg = palette.fairy }
highlights.Search = { fg = palette.text, bg = palette.amber, blend = 20 }
highlights.SignColumn = { fg = palette.text, bg = "NONE" }
highlights.SpecialKey = { fg = palette.lantern }
highlights.SpellBad = { sp = palette.subtle, undercurl = true }
highlights.SpellCap = { sp = palette.subtle, undercurl = true }
highlights.SpellLocal = { sp = palette.subtle, undercurl = true }
highlights.SpellRare = { sp = palette.subtle, undercurl = true }
highlights.StatusLine = { fg = palette.subtle, bg = groups.panel }
highlights.StatusLineNC = { fg = palette.muted, bg = groups.panel, blend = 60 }
highlights.StatusLineTerm = { fg = palette.base, bg = palette.twilight }
highlights.StatusLineTermNC = { fg = palette.base, bg = palette.twilight, blend = 60 }
highlights.Substitute = { link = "IncSearch" }
highlights.TabLine = { fg = palette.subtle, bg = groups.panel }
highlights.TabLineFill = { bg = groups.panel }
highlights.TabLineSel = { fg = palette.text, bg = palette.overlay, bold = styles.bold }
highlights.Title = { fg = palette.lantern, bold = styles.bold }
highlights.VertSplit = { fg = groups.border }
highlights.Visual = { bg = palette.hearth, blend = 15 }
highlights.WarningMsg = { fg = groups.warn, bold = styles.bold }
highlights.WildMenu = { link = "IncSearch" }
highlights.WinBar = { fg = palette.subtle, bg = groups.panel }
highlights.WinBarNC = { fg = palette.muted, bg = groups.panel, blend = 60 }
highlights.WinSeparator = { fg = groups.border }

-- ===== DIAGNOSTICS =====
highlights.DiagnosticError = { fg = groups.error }
highlights.DiagnosticHint = { fg = groups.hint }
highlights.DiagnosticInfo = { fg = groups.info }
highlights.DiagnosticOk = { fg = groups.ok }
highlights.DiagnosticWarn = { fg = groups.warn }
highlights.DiagnosticDefaultError = { link = "DiagnosticError" }
highlights.DiagnosticDefaultHint = { link = "DiagnosticHint" }
highlights.DiagnosticDefaultInfo = { link = "DiagnosticInfo" }
highlights.DiagnosticDefaultOk = { link = "DiagnosticOk" }
highlights.DiagnosticDefaultWarn = { link = "DiagnosticWarn" }
highlights.DiagnosticFloatingError = { link = "DiagnosticError" }
highlights.DiagnosticFloatingHint = { link = "DiagnosticHint" }
highlights.DiagnosticFloatingInfo = { link = "DiagnosticInfo" }
highlights.DiagnosticFloatingOk = { link = "DiagnosticOk" }
highlights.DiagnosticFloatingWarn = { link = "DiagnosticWarn" }
highlights.DiagnosticSignError = { link = "DiagnosticError" }
highlights.DiagnosticSignHint = { link = "DiagnosticHint" }
highlights.DiagnosticSignInfo = { link = "DiagnosticInfo" }
highlights.DiagnosticSignOk = { link = "DiagnosticOk" }
highlights.DiagnosticSignWarn = { link = "DiagnosticWarn" }
highlights.DiagnosticUnderlineError = { sp = groups.error, undercurl = true }
highlights.DiagnosticUnderlineHint = { sp = groups.hint, undercurl = true }
highlights.DiagnosticUnderlineInfo = { sp = groups.info, undercurl = true }
highlights.DiagnosticUnderlineOk = { sp = groups.ok, undercurl = true }
highlights.DiagnosticUnderlineWarn = { sp = groups.warn, undercurl = true }
highlights.DiagnosticVirtualTextError = { fg = groups.error, bg = groups.error, blend = 10 }
highlights.DiagnosticVirtualTextHint = { fg = groups.hint, bg = groups.hint, blend = 10 }
highlights.DiagnosticVirtualTextInfo = { fg = groups.info, bg = groups.info, blend = 10 }
highlights.DiagnosticVirtualTextOk = { fg = groups.ok, bg = groups.ok, blend = 10 }
highlights.DiagnosticVirtualTextWarn = { fg = groups.warn, bg = groups.warn, blend = 10 }

-- ===== SYNTAX HIGHLIGHTING =====
highlights.Boolean = { fg = palette.fairy }
highlights.Character = { fg = palette.amber }
highlights.Comment = { fg = palette.hearth, italic = styles.italic }
highlights.Conditional = { fg = palette.twilight }
highlights.Constant = { fg = palette.amber }
highlights.Debug = { fg = palette.fairy }
highlights.Define = { fg = palette.hearth }
highlights.Delimiter = { fg = palette.subtle }
highlights.Error = { fg = palette.ruby }
highlights.Exception = { fg = palette.twilight }
highlights.Float = { fg = palette.amber }
highlights.Function = { fg = palette.fairy }
highlights.Identifier = { fg = palette.text }
highlights.Include = { fg = palette.twilight }
highlights.Keyword = { fg = palette.twilight }
highlights.Label = { fg = palette.lantern }
highlights.LspCodeLens = { fg = palette.subtle }
highlights.LspCodeLensSeparator = { fg = palette.muted }
highlights.LspInlayHint = { fg = palette.muted, bg = palette.muted, blend = 10 }
highlights.LspReferenceRead = { bg = palette.highlight_med }
highlights.LspReferenceText = { bg = palette.highlight_med }
highlights.LspReferenceWrite = { bg = palette.highlight_med }
highlights.Macro = { fg = palette.hearth }
highlights.Number = { fg = palette.amber }
highlights.Operator = { fg = palette.subtle }
highlights.PreCondit = { fg = palette.hearth }
highlights.PreProc = { link = "PreCondit" }
highlights.Repeat = { fg = palette.twilight }
highlights.Special = { fg = palette.lantern }
highlights.SpecialChar = { link = "Special" }
highlights.SpecialComment = { fg = palette.hearth }
highlights.Statement = { fg = palette.twilight, bold = styles.bold }
highlights.StorageClass = { fg = palette.lantern }
highlights.String = { fg = palette.amber }
highlights.Structure = { fg = palette.lantern }
highlights.Tag = { fg = palette.lantern }
highlights.Todo = { fg = palette.fairy, bg = palette.fairy, blend = 20 }
highlights.Type = { fg = palette.lantern }
highlights.TypeDef = { link = "Type" }
highlights.Underlined = { fg = palette.hearth, underline = true }

-- ===== MARKDOWN & HTML =====
highlights.htmlArg = { fg = palette.hearth }
highlights.htmlBold = { bold = styles.bold }
highlights.htmlEndTag = { fg = palette.subtle }
highlights.htmlH1 = { link = "markdownH1" }
highlights.htmlH2 = { link = "markdownH2" }
highlights.htmlH3 = { link = "markdownH3" }
highlights.htmlH4 = { link = "markdownH4" }
highlights.htmlH5 = { link = "markdownH5" }
highlights.htmlItalic = { italic = styles.italic }
highlights.htmlLink = { link = "markdownUrl" }
highlights.htmlTag = { fg = palette.subtle }
highlights.htmlTagN = { fg = palette.text }
highlights.htmlTagName = { fg = palette.lantern }

highlights.markdownDelimiter = { fg = palette.subtle }
highlights.markdownH1 = { fg = groups.h1, bold = styles.bold }
highlights.markdownH1Delimiter = { link = "markdownH1" }
highlights.markdownH2 = { fg = groups.h2, bold = styles.bold }
highlights.markdownH2Delimiter = { link = "markdownH2" }
highlights.markdownH3 = { fg = groups.h3, bold = styles.bold }
highlights.markdownH3Delimiter = { link = "markdownH3" }
highlights.markdownH4 = { fg = groups.h4, bold = styles.bold }
highlights.markdownH4Delimiter = { link = "markdownH4" }
highlights.markdownH5 = { fg = groups.h5, bold = styles.bold }
highlights.markdownH5Delimiter = { link = "markdownH5" }
highlights.markdownH6 = { fg = groups.h6, bold = styles.bold }
highlights.markdownH6Delimiter = { link = "markdownH6" }
highlights.markdownLinkText = { link = "markdownUrl" }
highlights.markdownUrl = { fg = groups.link, sp = groups.link, underline = true }

-- ===== TREESITTER HIGHLIGHTS (New Style) =====
highlights["@variable"] = { fg = palette.text, italic = styles.italic }
highlights["@variable.builtin"] = { fg = palette.ruby, italic = styles.italic, bold = styles.bold }
highlights["@variable.parameter"] = { fg = palette.hearth, italic = styles.italic }
highlights["@variable.parameter.builtin"] = { fg = palette.hearth, italic = styles.italic, bold = styles.bold }
highlights["@variable.member"] = { fg = palette.lantern }

highlights["@constant"] = { fg = palette.amber }
highlights["@constant.builtin"] = { fg = palette.amber, bold = styles.bold }
highlights["@constant.macro"] = { fg = palette.amber }

highlights["@module"] = { fg = palette.text }
highlights["@module.builtin"] = { fg = palette.text, bold = styles.bold }
highlights["@label"] = { link = "Label" }

highlights["@string"] = { link = "String" }
highlights["@string.regexp"] = { fg = palette.hearth }
highlights["@string.escape"] = { fg = palette.twilight }
highlights["@string.special"] = { link = "String" }
highlights["@string.special.symbol"] = { link = "Identifier" }
highlights["@string.special.url"] = { fg = groups.link }

highlights["@character"] = { link = "Character" }
highlights["@character.special"] = { link = "Character" }

highlights["@boolean"] = { link = "Boolean" }
highlights["@number"] = { link = "Number" }
highlights["@number.float"] = { link = "Number" }
highlights["@float"] = { link = "Number" }

highlights["@type"] = { fg = palette.lantern }
highlights["@type.builtin"] = { fg = palette.lantern, bold = styles.bold }

highlights["@attribute"] = { fg = palette.hearth }
highlights["@attribute.builtin"] = { fg = palette.hearth, bold = styles.bold }
highlights["@property"] = { fg = palette.lantern, italic = styles.italic }

highlights["@function"] = { fg = palette.fairy }
highlights["@function.builtin"] = { fg = palette.fairy, bold = styles.bold }
highlights["@function.macro"] = { link = "Function" }
highlights["@function.method"] = { fg = palette.fairy }
highlights["@function.method.call"] = { fg = palette.hearth }

highlights["@constructor"] = { fg = palette.lantern }
highlights["@operator"] = { link = "Operator" }

highlights["@keyword"] = { link = "Keyword" }
highlights["@keyword.operator"] = { fg = palette.subtle }
highlights["@keyword.import"] = { fg = palette.twilight }
highlights["@keyword.storage"] = { fg = palette.lantern }
highlights["@keyword.repeat"] = { fg = palette.twilight }
highlights["@keyword.return"] = { fg = palette.twilight }
highlights["@keyword.debug"] = { fg = palette.fairy }
highlights["@keyword.exception"] = { fg = palette.twilight }
highlights["@keyword.conditional"] = { fg = palette.twilight }
highlights["@keyword.conditional.ternary"] = { fg = palette.twilight }
highlights["@keyword.directive"] = { fg = palette.hearth }
highlights["@keyword.directive.define"] = { fg = palette.hearth }

highlights["@punctuation.delimiter"] = { fg = palette.subtle }
highlights["@punctuation.bracket"] = { fg = palette.subtle }
highlights["@punctuation.special"] = { fg = palette.subtle }

highlights["@comment"] = { link = "Comment" }
highlights["@comment.error"] = { fg = groups.error }
highlights["@comment.warning"] = { fg = groups.warn }
highlights["@comment.todo"] = { fg = groups.todo, bg = groups.todo, blend = 15 }
highlights["@comment.hint"] = { fg = groups.hint, bg = groups.hint, blend = 15 }
highlights["@comment.info"] = { fg = groups.info, bg = groups.info, blend = 15 }
highlights["@comment.note"] = { fg = groups.note, bg = groups.note, blend = 15 }

highlights["@markup.strong"] = { bold = styles.bold }
highlights["@markup.italic"] = { italic = styles.italic }
highlights["@markup.strikethrough"] = { strikethrough = true }
highlights["@markup.underline"] = { underline = true }
highlights["@markup.heading"] = { fg = palette.lantern, bold = styles.bold }
highlights["@markup.quote"] = { fg = palette.text }
highlights["@markup.math"] = { link = "Special" }
highlights["@markup.environment"] = { link = "Macro" }
highlights["@markup.environment.name"] = { link = "@type" }
highlights["@markup.link.markdown_inline"] = { fg = palette.subtle }
highlights["@markup.link.label.markdown_inline"] = { fg = palette.lantern }
highlights["@markup.link.url"] = { fg = groups.link }
highlights["@markup.raw.delimiter.markdown"] = { fg = palette.subtle }
highlights["@markup.list"] = { fg = palette.twilight }
highlights["@markup.list.checked"] = { fg = palette.lantern, bg = palette.lantern, blend = 10 }
highlights["@markup.list.unchecked"] = { fg = palette.text }

highlights["@markup.heading.1.markdown"] = { link = "markdownH1" }
highlights["@markup.heading.2.markdown"] = { link = "markdownH2" }
highlights["@markup.heading.3.markdown"] = { link = "markdownH3" }
highlights["@markup.heading.4.markdown"] = { link = "markdownH4" }
highlights["@markup.heading.5.markdown"] = { link = "markdownH5" }
highlights["@markup.heading.6.markdown"] = { link = "markdownH6" }
highlights["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" }
highlights["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" }
highlights["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" }
highlights["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" }
highlights["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" }
highlights["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" }

highlights["@diff.plus"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 }
highlights["@diff.minus"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 }
highlights["@diff.delta"] = { bg = groups.git_change, blend = 20 }

highlights["@tag"] = { link = "Tag" }
highlights["@tag.attribute"] = { fg = palette.hearth }
highlights["@tag.delimiter"] = { fg = palette.subtle }

highlights["@conceal"] = { link = "Conceal" }
highlights["@conceal.markdown"] = { fg = palette.subtle }

-- ===== LSP SEMANTIC TOKENS =====
highlights["@lsp.type.comment"] = {}
highlights["@lsp.type.comment.c"] = { link = "@comment" }
highlights["@lsp.type.comment.cpp"] = { link = "@comment" }
highlights["@lsp.type.enum"] = { link = "@type" }
highlights["@lsp.type.interface"] = { link = "@type" }
highlights["@lsp.type.keyword"] = { link = "@keyword" }
highlights["@lsp.type.namespace"] = { link = "@type" }
highlights["@lsp.type.parameter"] = { link = "@variable.parameter" }
highlights["@lsp.type.property"] = { link = "@property" }
highlights["@lsp.type.variable"] = {}
highlights["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" }
highlights["@lsp.typemod.operator.injected"] = { link = "@operator" }
highlights["@lsp.typemod.string.injected"] = { link = "@string" }
highlights["@lsp.typemod.variable.constant"] = { link = "@constant" }
highlights["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" }

-- ===== PLUGIN: Gitsigns =====
highlights.GitSignsAdd = { fg = groups.git_add, bg = "NONE" }
highlights.GitSignsChange = { fg = groups.git_change, bg = "NONE" }
highlights.GitSignsDelete = { fg = groups.git_delete, bg = "NONE" }
highlights.SignAdd = { fg = groups.git_add, bg = "NONE" }
highlights.SignChange = { fg = groups.git_change, bg = "NONE" }
highlights.SignDelete = { fg = groups.git_delete, bg = "NONE" }

-- ===== PLUGIN: NvimTree =====
highlights.NvimTreeEmptyFolderName = { fg = palette.muted }
highlights.NvimTreeFileDeleted = { fg = groups.git_delete }
highlights.NvimTreeFileNew = { fg = palette.lantern }
highlights.NvimTreeFolderIcon = { fg = palette.subtle }
highlights.NvimTreeFolderName = { fg = palette.lantern }
highlights.NvimTreeGitDeleted = { fg = groups.git_delete }
highlights.NvimTreeGitIgnored = { fg = groups.git_ignore }
highlights.NvimTreeGitNew = { fg = groups.git_add }
highlights.NvimTreeImageFile = { fg = palette.text }
highlights.NvimTreeNormal = { link = "Normal" }
highlights.NvimTreeRootFolder = { fg = palette.lantern, bold = styles.bold }
highlights.NvimTreeSpecialFile = { link = "NvimTreeNormal" }

-- ===== PLUGIN: Treesitter Context =====
highlights.TreesitterContext = { bg = palette.overlay }
highlights.TreesitterContextLineNumber = { fg = palette.fairy, bg = palette.overlay }

-- ===== PLUGIN: Which-Key =====
highlights.WhichKeyBorder = make_border()
highlights.WhichKeyDesc = { fg = palette.hearth }
highlights.WhichKeyFloat = { bg = groups.panel }
highlights.WhichKeyGroup = { fg = palette.lantern }
highlights.WhichKeyNormal = { fg = palette.text, bg = groups.panel }
highlights.WhichKeySeparator = { fg = palette.subtle }
highlights.WhichKeyValue = { fg = palette.fairy }

-- ===== PLUGIN: Snacks.nvim =====
highlights.SnacksIndent = { fg = palette.overlay }
highlights.SnacksIndentChunk = { fg = palette.overlay }
highlights.SnacksIndentBlank = { fg = palette.overlay }
highlights.SnacksIndentScope = { fg = palette.lantern }
highlights.SnacksPickerMatch = { fg = palette.fairy, bold = styles.bold }

-- ===== PLUGIN: Mini.nvim =====
highlights.MiniClueBorder = { link = "FloatBorder" }
highlights.MiniClueDescGroup = { link = "DiagnosticFloatingWarn" }
highlights.MiniClueDescSingle = { link = "NormalFloat" }
highlights.MiniClueNextKey = { link = "DiagnosticFloatingHint" }
highlights.MiniClueTitle = { bg = groups.panel, bold = styles.bold }

highlights.MiniDiffOverAdd = { fg = groups.git_add, bg = groups.git_add, blend = 20 }
highlights.MiniDiffOverChange = { fg = groups.git_change, bg = groups.git_change, blend = 20 }
highlights.MiniDiffOverContext = { bg = palette.surface }
highlights.MiniDiffOverDelete = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 }
highlights.MiniDiffSignAdd = { fg = groups.git_add }
highlights.MiniDiffSignChange = { fg = groups.git_change }
highlights.MiniDiffSignDelete = { fg = groups.git_delete }

highlights.MiniFilesBorder = { link = "FloatBorder" }
highlights.MiniFilesCursorLine = { link = "CursorLine" }
highlights.MiniFilesDirectory = { link = "Directory" }
highlights.MiniFilesFile = { fg = palette.text }
highlights.MiniFilesNormal = { link = "NormalFloat" }
highlights.MiniFilesTitle = { link = "FloatTitle" }

highlights.MiniHipatternsFixme = { fg = palette.base, bg = groups.error, bold = styles.bold }
highlights.MiniHipatternsHack = { fg = palette.base, bg = groups.warn, bold = styles.bold }
highlights.MiniHipatternsTodo = { fg = palette.base, bg = groups.todo, bold = styles.bold }

highlights.MiniJump2dDim = { fg = palette.subtle }
highlights.MiniJump2dSpot = { fg = palette.amber, bold = styles.bold, nocombine = true }
highlights.MiniJump2dSpotAhead = { fg = palette.lantern, bg = palette.surface, nocombine = true }

highlights.MiniPickBorder = { link = "FloatBorder" }
highlights.MiniPickNormal = { link = "NormalFloat" }
highlights.MiniPickPrompt = { bg = groups.panel, bold = styles.bold }

highlights.MiniStarterFooter = { fg = palette.subtle }
highlights.MiniStarterHeader = { link = "Title" }
highlights.MiniStarterInactive = { link = "Comment" }
highlights.MiniStarterItem = { link = "Normal" }
highlights.MiniStarterItemBullet = { link = "Delimiter" }

highlights.MiniTablineCurrent = { fg = palette.text, bg = palette.overlay, bold = styles.bold }
highlights.MiniTablineFill = { link = "TabLineFill" }
highlights.MiniTablineHidden = { fg = palette.subtle, bg = groups.panel }
highlights.MiniTablineVisible = { fg = palette.text, bg = groups.panel }

highlights.MiniTestFail = { fg = palette.ruby, bold = styles.bold }
highlights.MiniTestPass = { fg = palette.lantern, bold = styles.bold }

-- ===== PLUGIN: Indent Blankline =====
highlights.IblIndent = { fg = palette.overlay }
highlights.IblScope = { fg = palette.lantern }
highlights.IblWhitespace = { fg = palette.overlay }

-- ===== PLUGIN: Render Markdown =====
highlights.RenderMarkdownBullet = { fg = palette.fairy }
highlights.RenderMarkdownChecked = { fg = palette.lantern }
highlights.RenderMarkdownCode = { bg = palette.surface }
highlights.RenderMarkdownCodeInline = { fg = palette.text, bg = palette.surface }
highlights.RenderMarkdownDash = { fg = palette.muted }
highlights.RenderMarkdownH1Bg = { bg = groups.h1, blend = 20 }
highlights.RenderMarkdownH2Bg = { bg = groups.h2, blend = 20 }
highlights.RenderMarkdownH3Bg = { bg = groups.h3, blend = 20 }
highlights.RenderMarkdownH4Bg = { bg = groups.h4, blend = 20 }
highlights.RenderMarkdownH5Bg = { bg = groups.h5, blend = 20 }
highlights.RenderMarkdownH6Bg = { bg = groups.h6, blend = 20 }
highlights.RenderMarkdownQuote = { fg = palette.subtle }
highlights.RenderMarkdownTableHead = { fg = palette.subtle }
highlights.RenderMarkdownTableRow = { fg = palette.subtle }
highlights.RenderMarkdownUnchecked = { fg = palette.subtle }

-- ===== TRANSPARENCY OVERRIDES =====
local transparency_highlights = {
	DiagnosticVirtualTextError = { fg = groups.error },
	DiagnosticVirtualTextHint = { fg = groups.hint },
	DiagnosticVirtualTextInfo = { fg = groups.info },
	DiagnosticVirtualTextOk = { fg = groups.ok },
	DiagnosticVirtualTextWarn = { fg = groups.warn },

	FloatBorder = { fg = palette.muted, bg = "NONE" },
	FloatTitle = { fg = palette.lantern, bg = "NONE", bold = styles.bold },
	Folded = { fg = palette.text, bg = "NONE" },
	NormalFloat = { bg = "NONE" },
	Normal = { fg = palette.text, bg = "NONE" },
	NormalNC = { fg = palette.text, bg = "NONE" },
	Pmenu = { fg = palette.subtle, bg = "NONE" },
	PmenuExtra = { fg = palette.text, bg = "NONE" },
	PmenuKind = { fg = palette.lantern, bg = "NONE" },
	SignColumn = { fg = palette.text, bg = "NONE" },
	StatusLine = { fg = palette.subtle, bg = "NONE" },
	StatusLineNC = { fg = palette.muted, bg = "NONE" },
	TabLine = { bg = "NONE", fg = palette.subtle },
	TabLineFill = { bg = "NONE" },
	TabLineSel = { fg = palette.text, bg = "NONE", bold = styles.bold },

	TreesitterContext = { bg = "NONE" },
	TreesitterContextLineNumber = { fg = palette.fairy, bg = "NONE" },

	WhichKeyFloat = { bg = "NONE" },
	WhichKeyNormal = { bg = "NONE" },

	MiniFilesTitleFocused = { fg = palette.fairy, bg = "NONE", bold = styles.bold },
	MiniPickPrompt = { bg = "NONE", bold = styles.bold },
}

-- WHAT: Apply transparency overrides if enabled
-- WHY: Users may prefer terminal background instead of theme background
-- HOW: Merge transparency highlights over defaults if styles.transparency is true
if styles.transparency then
	for group, highlight in pairs(transparency_highlights) do
		highlights[group] = vim.tbl_extend("force", highlights[group] or {}, highlight)
	end
end

-- WHAT: Merge user highlight_groups overrides
-- WHY: Allows customization without editing theme files
-- HOW: Deep extend with user-provided highlights
if config.options.highlight_groups ~= nil and next(config.options.highlight_groups) ~= nil then
	for group, highlight in pairs(config.options.highlight_groups) do
		local existing = highlights[group] or {}
		while existing.link ~= nil do
			existing = highlights[existing.link] or {}
		end
		local parsed = vim.tbl_extend("force", {}, highlight)

		if highlight.fg ~= nil then
			parsed.fg = utilities.parse_color(highlight.fg) or highlight.fg
		end
		if highlight.bg ~= nil then
			parsed.bg = utilities.parse_color(highlight.bg) or highlight.bg
		end
		if highlight.sp ~= nil then
			parsed.sp = utilities.parse_color(highlight.sp) or highlight.sp
		end

		if (highlight.inherit == nil or highlight.inherit) and existing ~= nil then
			parsed.inherit = nil
			highlights[group] = vim.tbl_extend("force", existing, parsed)
		else
			parsed.inherit = nil
			highlights[group] = parsed
		end
	end
end

return highlights
