opt = vim.opt_local

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.listchars:append({
	tab = "> ",
	trail = "~",
	leadmultispace = ".   ",
})
