local cmd = require("command")

cmd.shell_cf("Black", { "isort", "black" }, { edit = true, save = true })
cmd.shell_cf("Isort", { "isort" }, { edit = true, save = true })
cmd.shell_cf("XeLatex", { "xelatex" }, { edit = true, save = true })
cmd.shell_cf("LuaFormat", { "stylua" }, { edit = true, save = true })
cmd.shell_cf("RustFmt", { "rustfmt" }, { edit = true, save = true })
cmd.shell_cf("Gofmt", { "gofmt -w" }, { edit = true, save = true })
cmd.shell_cf("TerraformFmt", { "terraform fmt" }, { edit = true, save = true })
cmd.shell_cf("Ruff", { "ruff" }, { edit = true, save = true })
cmd.shell_cf("Clang", { "clang-format -i" }, { edit = true, save = true })
cmd.shell_cf("Pysen", { "PYSEN_IGNORE_GIT=1 poetry run pysen run_files format" }, { edit = true, save = true })
cmd.new("PythonFormat", function()
	vim.cmd("write")
	local current_file = vim.fn.expand("%:p")
	-- check that poetry has pysen
	local pysen = vim.fn.system("poetry run pysen --version")
	if string.find(pysen, "not find") then
		-- fallback. run global formatter
		vim.cmd("!isort" .. " " .. current_file)
		vim.cmd("!black" .. " " .. current_file)
	else
		-- run pysen
		vim.cmd("!PYSEN_IGNORE_GIT=1 poetry run pysen run_files format" .. " " .. current_file)
	end
	vim.cmd("edit!")
end, {})
cmd.new("Prettier", function()
	vim.cmd("write")
	local current_file = vim.fn.expand("%:p")
	local has_prettier_in_npx = vim.fn.system("npm list")
	if string.find(has_prettier_in_npx, "prettier") then
		vim.cmd("!npx prettier --plugin-search-dir=. --write" .. " " .. current_file)
	else
		vim.cmd("!prettier -w" .. " " .. current_file)
	end
	vim.cmd("edit!")
end, {})

local formatter_map = {
	["PythonFormat"] = { "python" },
	["LuaFormat"] = { "lua" },
	["RustFmt"] = { "rust" },
	["Prettier"] = {
		"javascript",
		"typescript",
		"css",
		"scss",
		"html",
		"json",
		"yaml",
		"markdown",
		"svelte",
		"typescriptreact",
	},
	["Clang"] = { "c", "cpp" },
	["Gofmt"] = { "go" },
	["TerraformFmt"] = { "terraform" },
}

cmd.new("Format", function()
	local filetype = vim.bo.filetype
	-- find formatter
	local formatter = nil
	for k, v in pairs(formatter_map) do
		for _, ft in pairs(v) do
			if ft == filetype then
				formatter = k
				break
			end
		end
	end
	if formatter == nil then
		print("No formatter found for filetype: " .. filetype)
		return
	end
	vim.cmd(formatter)
end, {})

local map = require("keymap")
map.n("ql", "<cmd>Format<cr>")
