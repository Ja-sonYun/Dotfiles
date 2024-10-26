local map = require("keymap")

local dap = require("dap")
local dap_python = require("dap-python")

opt = vim.opt_local

-- indent
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.listchars:append({
	tab = "> ",
	leadmultispace = ".   ",
})

-- dap configuration
dap.adapters.python = {
	type = "executable",
	command = vim.g.global_python_path,
	args = { "-m", "debugpy.adapter" },
}

dap_python.setup(vim.g.global_python_path)
dap_python.test_runner = "pytest"
dap_python.resolve_python = resolve_python_path

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",
		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = resolve_python_path,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch pytest",
		module = "pytest",
		args = { "-s", "-v" },
		pythonPath = resolve_python_path,
		console = "integratedTerminal",
	},
	{
		type = "python",
		request = "launch",
		name = "Launch current pytest file",
		module = "pytest",
		args = { "-s", "-v", "${relativeFile}" },
		pythonPath = resolve_python_path,
		console = "integratedTerminal",
	},
}
map.n("<space>dt", dap_python.test_method)
map.n("<space>df", dap_python.test_class)

map.n("qqf", 'ebiprint(f"{<esc>ea=}")<esc>')

vim.b.file_suffix = { ".py" }
