-------------------------------------
-- Default theme
-------------------------------------
hl = require("highlight")

hl.set("Comment", { ctermfg = 3 })
hl.set("SignColumn", { ctermbg = NONE })
hl.set("Search", { ctermfg = "black", ctermbg = "yellow" })

hl.link("CocLink", "Pmenu")
hl.link("CocSelectedText", "PmenuSel")
hl.link("CocFloating", "Pmenu")
hl.link("CocMenuFloat", "Pmenu")
hl.link("CocMenuSel", "PmenuSel")

hl.set("FloatBorder", { ctermfg = 3 })

-- gray
hl.set("Pmenu", { ctermbg = 238 })

hl.set("DiffAdd", { ctermbg = 17 })
hl.set("DiffChange", { ctermbg = 235 })
hl.set("DiffDelete", { ctermbg = 52 })
hl.set("DiffText", { ctermbg = 52 })

hl.set("Directory", { ctermfg = 6 })

hl.set("MatchParen", { ctermbg = 238, ctermfg = 3, underline = true })

--------------------------

-- Default colorscheme
hl.set("Structure", { ctermfg = 130 })
hl.set("Number", { ctermfg = 196 })

-- Treesitter
hl.set("@constant", { ctermfg = 160 })
hl.set("@attribute", { ctermfg = 99 })
hl.set("@variable.builtin", { ctermfg = 69 })
hl.set("@variable.parameter", { ctermfg = 44 })
hl.set("@type.builtin", { ctermfg = 34 })
hl.set("@function.call", { ctermfg = 111 })
hl.set("@function.method.call", { ctermfg = 111 })
hl.set("@lsp.type.interface", { ctermfg = 2 })
hl.set("@lsp.type.namespace", { ctermfg = 40 })
hl.set("@lsp.type.function", { ctermfg = 111 })
