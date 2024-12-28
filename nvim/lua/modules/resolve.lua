local M = {}

M.get_python_path = function(path, workspace)
	if path == nil then
		path = vim.fn.getcwd()
	end
	if workspace == nil then
		workspace = vim.fn.getcwd()
	end

	local venv_env_path = os.getenv("VIRTUAL_ENV")
	-- Use activated virtualenv.
	if venv_env_path ~= nil then
		local venv_path = path.join(venv_env_path, "bin", "python3")
		vim.cmd("Msg " .. venv_path)
		vim.b.info = " (venv)"
		return venv_path
	end

	-- Find and use virtualenv in workspace directory.
	-- Search for parent dir, sometimes vim-rooter use src folder
	for _, pattern in ipairs({ ".venv*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			local venv_path = path.join(path.dirname(match), "bin", "python")
			vim.cmd("Msg " .. venv_path)
			vim.b.info = " (venv)"
			return venv_path
		end
	end

	-- Fallback to system Python.
	vim.cmd("Msg Fallback to system Python")
	return "~/.globalpip/.venv/bin/python"
end

return M
