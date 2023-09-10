local M = {}

M.new = function(name, func, opts)
	local opts = opts or {}
	vim.api.nvim_create_user_command(name, func, opts)
end

-- Run current file
M.shell_cf = function(name, cmds, opts)
	M.new(name, function()
		if opts and opts.save then
			vim.cmd("write")
		end
		local runner = "!"
		if opts and opts.runner then
			runner = opts.runner
		end
		for _, cmd in ipairs(cmds) do
			local string = runner .. cmd .. " " .. vim.fn.expand("%")
			vim.cmd(string)
		end
		if opts and opts.edit then
			vim.cmd("edit!")
		end
	end, { nargs = 0 })
end

M.shell = function(name, cmd)
	M.new(name, function()
		vim.cmd(cmd)
	end, { nargs = 0 })
end

return M
