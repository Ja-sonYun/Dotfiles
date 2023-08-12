local cmd = require("command")

cmd.new("BufOnly", function()
	vim.cmd("%bd|e#")
end, {})
