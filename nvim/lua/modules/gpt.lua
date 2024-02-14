local M = {}

M.call_api = function(texts, instruction, callback)
	local api_key = vim.env.OPENAI_API_KEY
	local api_base = "https://api.openai.com/v1/chat/completions"

	-- Create the payload
	local payload = {
		model = "gpt-4-turbo-preview",
		messages = {
			{ role = "system", content = instruction },
			{ role = "user", content = texts },
		},
	}
	if not instruction then
		-- Remove the system message if no instruction is provided
		table.remove(payload.messages, 1)
	end

	local json_payload = vim.fn.json_encode(payload)

	-- Command arguments
	local args = {
		"-s",
		"-H",
		"Content-Type: application/json",
		"-d",
		json_payload,
		"-H",
		"Authorization: Bearer " .. api_key,
		api_base,
	}

	-- Async process output handling
	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)
	local result = {}

	local handle = vim.loop.spawn("curl", {
		args = args,
		stdio = { nil, stdout, stderr },
	}, function(code)
		stdout:close()
		stderr:close()
		if code ~= 0 then
			print("Error: GPT API call failed with code " .. code)
			return
		end

		vim.schedule(function()
			local response = vim.fn.json_decode(table.concat(result))
			local text = response.choices[1].message.content
			-- remove byte strings from the text lkie <80> and <82>
			text = string.gsub(text, "<%d+>", "")
			callback(text)
		end)
	end)

	-- Read data from stdout
	vim.loop.read_start(stdout, function(err, data)
		assert(not err, err)
		if data then
			table.insert(result, data)
		end
	end)

	-- Read data from stderr (for error messages)
	vim.loop.read_start(stderr, function(err, data)
		if data then
			print("stderr: ", data)
		end
	end)
end

return M
