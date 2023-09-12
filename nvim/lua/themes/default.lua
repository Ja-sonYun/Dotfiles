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
