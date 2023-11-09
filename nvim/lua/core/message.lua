local cmd = require("command")

cmd.new("Err", function(opts)
	require("message").Msg(opts.args, "ErrorMsg", { timestamp = true })
end, { nargs = "*" })

cmd.new("Msg", function(opts)
	require("message").Msg(opts.args, "Search", { timestamp = true })
end, { nargs = "*" })

cmd.new("Ok", function(opts)
	require("message").Msg(opts.args, "MoreMsg", { timestamp = true })
end, { nargs = "*" })
