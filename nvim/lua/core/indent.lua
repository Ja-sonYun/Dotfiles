local auto = require("autocmd")
local cmd = require("command")

local indent2 = function(opt)
	opt.shiftwidth = 2
	opt.tabstop = 2
	opt.expandtab = true
	opt.listchars:append({
		tab = "> ",
		trail = "~",
		leadmultispace = "| ",
	})
end

local indent2tab = function(opt)
	opt.shiftwidth = 2
	opt.tabstop = 2
	opt.expandtab = false
	opt.listchars:append({
		tab = "> ",
		trail = "~",
		leadmultispace = "| ",
	})
end

local indent4 = function(opt)
	opt.shiftwidth = 4
	opt.tabstop = 4
	opt.expandtab = true
	opt.listchars:append({
		tab = "> ",
		trail = "~",
		leadmultispace = "|   ",
	})
end

local indent4tab = function(opt)
	opt.shiftwidth = 4
	opt.tabstop = 4
	opt.expandtab = false
	opt.listchars:append({
		tab = "> ",
		trail = "~",
		leadmultispace = "|   ",
	})
end

cmd.new("I2", function()
	indent2(vim.opt_local)
end)
cmd.new("I4", function()
	indent4(vim.opt_local)
end)

-- Set indentation to 2 spaces
auto.cmd("Filetype", {
	pattern = {
		"xml",
		"html",
		"xhtml",
		"css",
		"scss",
		"javascript",
		"typescript",
		"svelte",
		"yaml",
		"elixir",
		"json",
		"heex",
		"terraform",
		"toml",
		"proto",
		"typescriptreact",
		"javascriptreact",
		"cpp",
		"c",
		"hcl",
		"graphql",
	},
	callback = function()
		indent2(vim.opt_local)
	end,
})

-- Set indentation to 4 spaces tab
auto.cmd("Filetype", {
	pattern = { "go" },
	callback = function()
		indent4tab(vim.opt_local)
	end,
})

-- Set indentation to 2 spaces tab
auto.cmd("Filetype", {
	pattern = { "lua" },
	callback = function()
		indent2tab(vim.opt_local)
	end,
})

-- Default indentation to 4 spaces
indent4(vim.opt)
