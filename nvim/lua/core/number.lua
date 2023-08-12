local is = require("condition")
local auto = require("autocmd")

auto.group("ModifyRelativeNumber", { clear = true })
for _, event in ipairs({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" }) do
	auto.cmd(event, {
		group = "ModifyRelativeNumber",
		callback = function()
			if not is.code() then
				return
			end

			vim.opt_local.relativenumber = false
		end,
	})
end

for _, event in ipairs({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" }) do
	auto.cmd(event, {
		group = "ModifyRelativeNumber",
		callback = function()
			if not is.code() then
				return
			end

			vim.opt_local.number = true
			vim.opt_local.relativenumber = true
		end,
	})
end
