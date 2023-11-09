-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

return {
	-- {
	-- 	"andersevenrud/nvim_context_vt",
	-- 	opts = {
	-- 		-- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
	-- 		-- Default: true
	-- 		enabled = true,

	-- 		-- Override default virtual text prefix
	-- 		-- Default: '-->'
	-- 		prefix = "~~>",

	-- 		-- Override the internal highlight group name
	-- 		-- Default: 'ContextVt'
	-- 		highlight = "CustomContextVt",

	-- 		-- Disable virtual text for given filetypes
	-- 		-- Default: { 'markdown' }
	-- 		disable_ft = { "markdown" },

	-- 		-- Disable display of virtual text below blocks for indentation based languages like Python
	-- 		-- Default: false
	-- 		disable_virtual_lines = false,

	-- 		-- Same as above but only for spesific filetypes
	-- 		-- Default: {}
	-- 		disable_virtual_lines_ft = { "yaml" },

	-- 		-- How many lines required after starting position to show virtual text
	-- 		-- Default: 1 (equals two lines total)
	-- 		min_rows = 1,

	-- 		-- Same as above but only for spesific filetypes
	-- 		-- Default: {}
	-- 		min_rows_ft = {},

	-- 		-- Custom virtual text node parser callback
	-- 		-- Default: nil
	-- 	},
	-- },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			-- { "nvim-treesitter/nvim-treesitter-context" },
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

					-- Repeat movement with ; and ,
					-- ensure ; goes forward and , goes backward regardless of the last direction
					vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
					vim.keymap.set({ "n", "x", "o" }, "'", ts_repeat_move.repeat_last_move_previous)

					-- vim way: ; goes to the direction you were moving.
					-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
					-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

					-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
					vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
					vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
					vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
					vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

					require("nvim-treesitter.configs").setup({
						textobjects = {
							lsp_interop = {
								enable = true,
								border = "none",
								floating_preview_opts = {},
								peek_definition_code = {
									["\\dF"] = "@function.outer",
									["\\dC"] = "@class.outer",
									["\\dm"] = "@call.outer",
									["L"] = "@statement.outer",
									["\\dS"] = "@scopename.inner",
									["\\df"] = "@frame.outer",
								},
							},
							swap = {
								enable = true,
								swap_next = {
									["\\s"] = "@parameter.inner",
								},
								swap_previous = {
									["\\S"] = "@parameter.inner",
								},
							},
							move = {
								enable = true,
								set_jumps = true, -- whether to set jumps in the jumplist
								goto_next_start = {
									["]f"] = "@function.outer",
									["]c"] = { query = "@class.outer", desc = "Next class start" },
									--
									-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
									["]o"] = "@loop.*",
									-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
									--
									-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
									-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
									["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
									["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
									["]]"] = { query = "@parameter.inner" },
								},
								goto_next_end = {
									["]F"] = "@function.outer",
									["]C"] = "@class.outer",
									["}}"] = { query = "@parameter.inner" },
								},
								goto_previous_start = {
									["[f"] = "@function.outer",
									["[c"] = "@class.outer",
									["[["] = { query = "@parameter.inner" },
									["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
								},
								goto_previous_end = {
									["[F"] = "@function.outer",
									["[C"] = "@class.outer",
									["{{"] = { query = "@parameter.inner" },
								},
								-- Below will go to either the start or the end, whichever is closer.
								-- Use if you want more granular movements
								-- Make it even more gradual by adding multiple queries and regex.
								-- goto_next = {
								-- 	["]d"] = "@conditional.outer",
								-- },
								-- goto_previous = {
								-- 	["[d"] = "@conditional.outer",
								-- },
							},
							select = {
								enable = true,

								-- Automatically jump forward to textobj, similar to targets.vim
								lookahead = true,

								keymaps = {
									-- You can use the capture groups defined in textobjects.scm
									["af"] = "@function.outer",
									["if"] = "@function.inner",
									["ac"] = "@class.outer",
									-- You can optionally set descriptions to the mappings (used in the desc parameter of
									-- nvim_buf_set_keymap) which plugins like which-key display
									["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
									-- You can also use captures from other query groups like `locals.scm`
									["as"] = {
										query = "@scope",
										query_group = "locals",
										desc = "Select language scope",
									},
								},
								-- You can choose the select mode (default is charwise 'v')
								--
								-- Can also be a function which gets passed a table with the keys
								-- * query_string: eg '@function.inner'
								-- * method: eg 'v' or 'o'
								-- and should return the mode ('v', 'V', or '<c-v>') or a table
								-- mapping query_strings to modes.
								selection_modes = {
									["@parameter.outer"] = "v", -- charwise
									["@function.outer"] = "V", -- linewise
									["@class.outer"] = "<c-v>", -- blockwise
								},
								-- If you set this to `true` (default is `false`) then any textobject is
								-- extended to include preceding or succeeding whitespace. Succeeding
								-- whitespace has priority in order to act similarly to eg the built-in
								-- `ap`.
								--
								-- Can also be a function which gets passed a table with the keys
								-- * query_string: eg '@function.inner'
								-- * selection_mode: eg 'v'
								-- and should return true of false
								include_surrounding_whitespace = true,
							},
						},
					})
				end,
			},
		},
		opts = {
			-- A list of parser names, or "all"
			ensure_installed = {
				"arduino",
				"bash",
				"bibtex",
				"c",
				"c_sharp",
				"clojure",
				"cmake",
				"commonlisp",
				"cpp",
				"css",
				"cuda",
				"dockerfile",
				"dot",
				"elixir",
				"erlang",
				"fennel",
				"fish",
				"fortran",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"graphql",
				"hcl",
				"heex",
				"html",
				"ini",
				"java",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"julia",
				"jq",
				"json5",
				"jsonnet",
				"kotlin",
				"latex",
				"ledger",
				"lua",
				"llvm",
				"make",
				"markdown",
				"markdown_inline",
				"matlab",
				"ninja",
				"nix",
				"ocaml",
				"ocaml_interface",
				"ocamllex",
				"pascal",
				"perl",
				"php",
				"phpdoc",
				"proto",
				"python",
				"ql",
				"r",
				"ruby",
				"rust",
				"scala",
				"scss",
				"sql",
				"svelte",
				"swift",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
				"zig",
			},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = true,
			highlight = {
				-- `false` will disable the whole extension
				enable = true,
				language_tree = true,
				is_supported = function()
					if
						vim.fn.strwidth(vim.fn.getline(".")) > 300
						or vim.fn.getfsize(vim.fn.expand("%")) > 1024 * 1024
					then
						return false
					else
						return true
					end
				end,
			},
		},
		config = function(plugin, opts)
			return require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
