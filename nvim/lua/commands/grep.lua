local cmd = require("command")

cmd.new("Grep", function(opts)
	require("grep").Grep(opts.args, {})
end, { nargs = "*" })
