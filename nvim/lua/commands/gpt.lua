local cmd = require("command")

cmd.new("Fix", function(opts)
	local utils = require("utils")
	local gpt = require("gpt")

	local cleaner = require("message").Msg("Fixing...", "MatchParen", { timestamp = true, ret_cleaner = true })

	local text_selection = utils.get_selected_lines()
	local bufnr = vim.api.nvim_get_current_buf()
	local start_row, start_col, end_row, end_col = utils.get_visual_selection()
	local new_callback = function(lines)
		lines = utils.trim_to_code_block(lines)
		utils.fix_indentation(bufnr, start_row, end_row, lines)
		if vim.api.nvim_buf_is_valid(bufnr) == true then
			utils.replace_lines(lines, bufnr, start_row, start_col, end_row, end_col)
		else
			-- if the buffer is not valid, open a popup. This can happen when the user closes the previous popup window before the request is finished.
			Ui.popup(lines, utils.get_filetype(), bufnr, start_row, start_col, end_row, end_col)
		end
		cleaner()
		vim.cmd("Ok Fixed!")
	end

	local prompt = [[
		User is writing a code.
		User will give a sentence. sentence is usually a comment or a docstring, but it can be a code or variable name.
		Please fix the grammar to make it more natural.
		You must keep the style of the sentence, like comments, or docstrings or indentations.
	]]

	gpt.call_api(text_selection, prompt, function(text)
		lines = vim.fn.split(text, "\n")
		new_callback(lines)
	end)
end, { range = true, nargs = "*" })

cmd.new("Doc", function(opts)
	local utils = require("utils")
	local gpt = require("gpt")

	local cleaner = require("message").Msg("Adding Doc...", "Search", { timestamp = true, ret_cleaner = true })

	-- local CodeGptModule = require("codegpt")
	local text_selection = utils.get_selected_lines()
	local bufnr = vim.api.nvim_get_current_buf()
	local start_row, start_col, end_row, end_col = utils.get_visual_selection()
	local new_callback = function(lines)
		lines = utils.trim_to_code_block(lines)
		utils.fix_indentation(bufnr, start_row, end_row, lines)
		if vim.api.nvim_buf_is_valid(bufnr) == true then
			utils.replace_lines(lines, bufnr, start_row, start_col, end_row, end_col)
		else
			-- if the buffer is not valid, open a popup. This can happen when the user closes the previous popup window before the request is finished.
			Ui.popup(lines, utils.get_filetype(), bufnr, start_row, start_col, end_row, end_col)
		end
		cleaner()
		vim.cmd("Ok Doc Added!")
	end

	local filename = vim.fn.expand("%")
	local prompt = [[
		User is writing a code. file name is ]] .. filename .. [[.
		User will give a sentence. sentence is usually a part of a code, but it can be a single word or a variable name.
		Please add a docstring to the sentence.
	]]

	gpt.call_api(text_selection, prompt, function(text)
		lines = vim.fn.split(text, "\n")
		new_callback(lines)
	end)
end, { range = true, nargs = "*" })

cmd.new("Improve", function(opts)
	local utils = require("utils")
	local gpt = require("gpt")

	local cleaner = require("message").Msg("Improving...", "Search", { timestamp = true, ret_cleaner = true })

	-- local CodeGptModule = require("codegpt")
	local text_selection = utils.get_selected_lines()
	local bufnr = vim.api.nvim_get_current_buf()
	local start_row, start_col, end_row, end_col = utils.get_visual_selection()
	local new_callback = function(lines)
		lines = utils.trim_to_code_block(lines)
		utils.fix_indentation(bufnr, start_row, end_row, lines)
		if vim.api.nvim_buf_is_valid(bufnr) == true then
			utils.replace_lines(lines, bufnr, start_row, start_col, end_row, end_col)
		else
			-- if the buffer is not valid, open a popup. This can happen when the user closes the previous popup window before the request is finished.
			Ui.popup(lines, utils.get_filetype(), bufnr, start_row, start_col, end_row, end_col)
		end
		cleaner()
		vim.cmd("Ok Improved!")
	end

	local filename = vim.fn.expand("%")
	local prompt = [[
		User is writing a code. file name is ]] .. filename .. [[.
		User will give a part of a code.
		Improve given code.
	]]

	gpt.call_api(text_selection, prompt, function(text)
		lines = vim.fn.split(text, "\n")
		new_callback(lines)
	end)
end, { range = true, nargs = "*" })
