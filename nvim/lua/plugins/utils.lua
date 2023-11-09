return {
	--{
	--	"Wansmer/symbol-usage.nvim",
	--	event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
	--	config = function()
	--		require("symbol-usage").setup({
	--			hl = { ctermfg = 238, underline = true },
	--			vt_position = "end_of_line",
	--			request_pending_text = "...",
	--			---@type function(symbol: Symbol): string Symbol{ definition = integer|nil, implementation = integer|nil, references = integer|nil }
	--			text_format = function(symbol)
	--				local fragments = {}

	--				if symbol.references then
	--					local usage = symbol.references <= 1 and "ref" or "refs"
	--					if symbol.references == 0 then
	--						table.insert(fragments, "unused")
	--					else
	--						table.insert(fragments, symbol.references .. " " .. usage)
	--					end
	--				end

	--				if symbol.definition then
	--					table.insert(fragments, symbol.definition .. " defs")
	--				end

	--				if symbol.implementation then
	--					table.insert(fragments, symbol.implementation .. " impls")
	--				end

	--				return table.concat(fragments, ", ")
	--			end,
	--		})
	--	end,
	--},

	--{
	--	"roobert/tabtree.nvim",
	--	config = function()
	--		require("tabtree").setup({
	--			-- print the capture group name when executing next/previous
	--			--debug = true,

	--			-- disable key bindings
	--			--key_bindings_disabled = true,

	--			key_bindings = {
	--				next = "<Tab>",
	--				previous = "<S-Tab>",
	--			},

	--			-- use :InspectTree to discover the (capture group)
	--			-- @capture_name can be anything
	--			language_configs = {
	--				python = {
	--					target_query = [[
	--(string) @string_capture
	--(interpolation) @interpolation_capture
	--(parameters) @parameters_capture
	--(identifier) @identifier_capture
	--(argument_list) @argument_list_capture
	--						(none) @none_capture
	--						(dictionary) @dictionary_capture
	--						(tuple) @tuple_capture
	--						(integer) @integer_capture
	--						(float) @float_capture
	--						(list) @list_capture
	--						(set) @set_capture
	--]],
	--					-- experimental feature, to move the cursor in certain situations like when handling python f-strings
	--					offsets = {
	--						string_start_capture = 1,
	--					},
	--				},
	--			},

	--			default_config = {
	--				target_query = [[
	--(string) @string_capture
	--(interpolation) @interpolation_capture
	--(parameters) @parameters_capture
	--(identifier) @identifier_capture
	--(argument_list) @argument_list_capture
	--]],
	--				offsets = {},
	--			},
	--		})
	--	end,
	--},

	{
		"gbprod/substitute.nvim",
		config = function()
			require("substitute").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
			vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
			vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
			vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
			vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })

			-- vim.keymap.set("n", "<leader>s", require('substitute.range').operator, { noremap = true })
			-- vim.keymap.set("x", "<leader>s", require('substitute.range').visual, { noremap = true })
			-- vim.keymap.set("n", "<leader>ss", require('substitute.range').word, { noremap = true })

			vim.keymap.set("n", "sx", require("substitute.exchange").operator, { noremap = true })
			vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true })
			vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
			vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true })
		end,
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		init = function()
			-- This module contains a number of default definitions
			local rainbow_delimiters = require("rainbow-delimiters")
			local hl = require("highlight")

			hl.set("RainbowDelimiterBlue", { ctermfg = 69, force = true })
			hl.set("RainbowDelimiterGreen", { ctermfg = 106, force = true })
			hl.set("RainbowDelimiterOrange", { ctermfg = 166, force = true })
			hl.set("RainbowDelimiterCyan", { ctermfg = 147, force = true })

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					-- lua = "rainbow-blocks",
				},
				highlight = {
					-- "RainbowDelimiterRed",
					-- 'RainbowDelimiterYellow',
					-- 'RainbowDelimiterViolet',
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterBlue",
					-- 'RainbowDelimiterCyan',
				},
			}
		end,
	},

	{
		"tzachar/highlight-undo.nvim",
		opts = {
			duration = 1000,
			undo = {
				hlgroup = "DiffAdd",
				mode = "n",
				lhs = "u",
				map = "undo",
				opts = {},
			},
			redo = {
				hlgroup = "DiffDelete",
				mode = "n",
				lhs = "<C-r>",
				map = "redo",
				opts = {},
			},
			highlight_for_count = true,
		},
	},

	{
		"chrisgrieser/nvim-spider",
		config = function()
			-- default value
			require("spider").setup({
				skipInsignificantPunctuation = true,
			})

			vim.keymap.set({ "n", "o", "x" }, "W", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
			vim.keymap.set({ "n", "o", "x" }, "B", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
			vim.keymap.set({ "n", "o", "x" }, "E", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
		end,
	},
}
