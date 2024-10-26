opt = vim.opt_local

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.listchars:append({
	tab = "> ",
	leadmultispace = ". ",
})

vim.b.file_suffix = { ".ts", ".tsx", ".d.ts", ".js", ".jsx" }
