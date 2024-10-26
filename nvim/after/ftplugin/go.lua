opt = vim.opt_local

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = false
opt.listchars:append({
	tab = "> ",
	trail = "~",
	leadmultispace = ".   ",
})

vim.b.file_suffix = { ".go" }
