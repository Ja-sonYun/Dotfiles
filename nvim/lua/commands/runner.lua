local cmd = require("command")

cmd.shell_cf("RunNode", { "node" }, { runner = "Shell" })
cmd.shell_cf("RunGo", { "go run" }, { runner = "Shell" })
cmd.shell_cf("RunRust", { "cargo run" }, { runner = "Shell" })
cmd.shell_cf("RunLatex", { "xelatex" }, { runner = "Shell" })
cmd.shell_cf("RunShell", { "bash" }, { runner = "Shell" })
cmd.shell_cf("RunClang", { "clang" }, { runner = "Shell" })
cmd.new("RunPython", function()
	local current_file = vim.fn.expand("%:p")
	-- check that poetry has pysen
	local pysen = vim.fn.system("poetry run python -V")
	if string.find(pysen, "not find") then
		-- fallback. run global python
		vim.cmd("Shell python " .. current_file)
	else
		vim.cmd("Shell poetry run python " .. current_file)
	end
end, {})

local runners_map = {
	["RunPython"] = { "python" },
	["RunRust"] = { "rust" },
	["RunClang"] = { "c", "cpp" },
	["RunGo"] = { "go" },
	["RunShell"] = { "sh", "bash" },
	["RunNode"] = { "javascript", "typescript", "svelte", "typescriptreact" },
}

cmd.new("Run", function()
	local filetype = vim.bo.filetype
	-- find formatter
	local formatter = nil
	for k, v in pairs(runners_map) do
		for _, ft in pairs(v) do
			if ft == filetype then
				runner = k
				break
			end
		end
	end
	if runner == nil then
		print("No runner found for filetype: " .. filetype)
		return
	end
	vim.cmd(runner)
end, {})

local map = require("keymap")
map.n("qp", "<cmd>Run<cr>")
