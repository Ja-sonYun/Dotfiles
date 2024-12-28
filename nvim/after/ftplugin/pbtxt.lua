opt = vim.opt_local

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.listchars:append({
	tab = "> ",
	leadmultispace = ". ",
})
