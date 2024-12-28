-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------
local auto = require("autocmd")
local is = require("condition")

-----------------------------------------------------------
-- Highlight on yank
-----------------------------------------------------------
auto.group("YankHighlight", { clear = true })
auto.cmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = "1000" })
	end,
})

-----------------------------------------------------------
-- Remove whitespace on save
-----------------------------------------------------------
auto.cmd("BufWritePre", {
	pattern = "",
	callback = function()
		if not is.code() then
			return
		end
		vim.cmd(":%s/\\s\\+$//e")
	end,
})

-----------------------------------------------------------
-- Don't auto commenting new lines
-----------------------------------------------------------
auto.cmd("BufEnter", {
	pattern = "",
	command = "set fo-=c fo-=r fo-=o",
})

-----------------------------------------------------------
-- Switch Rel - Abs number
-----------------------------------------------------------
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

-----------------------------------------------------------
-- Dynamic on save callback
-----------------------------------------------------------
function is_file_in_glob(pattern, filename)
	local patterns = vim.split(pattern, ",")
	for _, pat in ipairs(patterns) do
		local files = vim.fn.glob(pat, false, true)
		for _, file in ipairs(files) do
			if file == filename then
				return true
			end
		end
	end
	return false
end

auto.cmd("BufWritePost", {
	pattern = "",
	callback = function()
		vim.cmd("Ok File saved!")

		-- if VIM_ON_SAVE_HOOK_TRIGGER_RULES, assume that is like *.py
		if vim.env.VIM_ON_SAVE_HOOK then
			if vim.env.VIM_ON_SAVE_HOOK_TRIGGER_RULES == nil then
				vim.cmd("!" .. vim.env.VIM_ON_SAVE_HOOK)
			else
				local file_hit = is_file_in_glob(vim.env.VIM_ON_SAVE_HOOK_TRIGGER_RULES, vim.fn.expand("%:t"))
				if file_hit then
					vim.cmd("!" .. vim.env.VIM_ON_SAVE_HOOK)
				else
					vim.cmd("Ok File not matched with VIM_ON_SAVE_HOOK_TRIGGER_RULES")
				end
			end
		end
	end,
})
