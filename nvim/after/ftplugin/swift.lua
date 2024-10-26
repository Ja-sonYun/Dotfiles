opt = vim.opt_local

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.listchars:append({
	tab = "> ",
	leadmultispace = ".   ",
})

require("lspconfig").sourcekit.setup({
	cmd = { "sourcekit-lsp" },
	filetypes = { "swift", "objective-c", "objective-cpp" },
	root_dir = require("lspconfig").util.root_pattern("Package.swift", ".git"),
})

vim.cmd("LspStart")

vim.b.file_suffix = { ".swift" }
