local cmd = require("command")

cmd.new("Err", function(opts)
	require("message").Msg(opts.args, "ErrorMsg", { timestamp = true })
end, { nargs = "*" })

cmd.new("Msg", function(opts)
	require("message").Msg(opts.args, "TodoBgTODO", { timestamp = true })
end, { nargs = "*" })

cmd.new("Ok", function(opts)
	require("message").Msg(opts.args, "TodoBgHACK", { timestamp = true })
end, { nargs = "*" })

cmd.new("MsgClear", function()
	require("message").ClearMsg()
end, {})
