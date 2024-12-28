return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, opts)
			require("todo-comments").setup(opts)

			local hl = require("highlight")

			hl.set("TodoBgTODO", { ctermbg = 3, ctermfg = 0 })
			hl.set("TodoBgHACK", { ctermbg = 2, ctermfg = 0 })
			hl.set("TodoBgNOTE", { ctermbg = 4, ctermfg = 15 })
			hl.set("TodoBgWARN", { ctermbg = 208, ctermfg = 0 })
			hl.set("TodoBgPERF", { ctermbg = 5, ctermfg = 0 })
			hl.set("TodoBgFIX", { ctermbg = 1, ctermfg = 0 })
			hl.set("TodoBgTEST", { ctermbg = 6, ctermfg = 0 })
		end,
		opts = {
			signs = false, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = "F ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = "I ", color = "info" },
				HACK = { icon = "H ", color = "warning" },
				WARN = { icon = "W ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = "P ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = "N ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "T ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = true, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},
	{
		"folke/trouble.nvim",
		config = function(_, opts)
			require("trouble").setup(opts)
			local map = require("keymap")
			local hl = require("highlight")

			map.n("<leader>dd", ":Trouble todo<cr>")

			hl.set("TroublePreview", { ctermbg = 0 })
			hl.set("TroubleNormal", { ctermbg = 0 })
			hl.set("TroubleNormalNC", { ctermbg = 0 })
		end,
		opts = {
			auto_close = false, -- auto close when there are no items
			auto_open = false, -- auto open when there are items
			auto_preview = true, -- automatically open preview when on an item
			auto_refresh = true, -- auto refresh when open
			auto_jump = false, -- auto jump to the item when there's only one
			focus = true, -- Focus the window when opened
			restore = true, -- restores the last location in the list when opening
			follow = true, -- Follow the current item
			indent_guides = true, -- show indent guides
			max_items = 200, -- limit number of items that can be displayed per section
			multiline = true, -- render multi-line messages
			pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
			warn_no_results = true, -- show a warning when there are no results
			open_no_results = false, -- open the trouble window when there are no results
			---@type trouble.Window.opts
			win = {}, -- window options for the results window. Can be a split or a floating window.
			-- Window options for the preview window. Can be a split, floating window,
			-- or `main` to show the preview in the main editor window.
			---@type trouble.Window.opts
			preview = {
				type = "main",
				-- when a buffer is not yet loaded, the preview window will be created
				-- in a scratch buffer with only syntax highlighting enabled.
				-- Set to false, if you want the preview to always be a real loaded buffer.
				scratch = true,
			},
			-- Throttle/Debounce settings. Should usually not be changed.
			---@type table<string, number|{ms:number, debounce?:boolean}>
			throttle = {
				refresh = 20, -- fetches new data when needed
				update = 10, -- updates the window
				render = 10, -- renders the window
				follow = 100, -- follows the current item
				preview = { ms = 100, debounce = true }, -- shows the preview for the current item
			},
			-- Key mappings can be set to the name of a builtin action,
			-- or you can define your own custom action.
			---@type table<string, trouble.Action.spec|false>
			keys = {
				["?"] = "help",
				r = "refresh",
				R = "toggle_refresh",
				q = "close",
				["<C-c>"] = "close",
				o = "jump_close",
				["<esc>"] = "cancel",
				["<cr>"] = "jump",
				["<2-leftmouse>"] = "jump",
				["<c-s>"] = "jump_split",
				["<c-v>"] = "jump_vsplit",
				-- go down to next item (accepts count)
				-- j = "next",
				["}"] = "next",
				["]]"] = "next",
				-- go up to prev item (accepts count)
				-- k = "prev",
				["{"] = "prev",
				["[["] = "prev",
				dd = "delete",
				d = { action = "delete", mode = "v" },
				i = "inspect",
				p = "preview",
				P = "toggle_preview",
				h = "fold_close",
				l = "fold_open",
				zo = "fold_open",
				zO = "fold_open_recursive",
				zc = "fold_close",
				zC = "fold_close_recursive",
				za = "fold_toggle",
				zA = "fold_toggle_recursive",
				zm = "fold_more",
				zM = "fold_close_all",
				zr = "fold_reduce",
				zR = "fold_open_all",
				zx = "fold_update",
				zX = "fold_update_all",
				zn = "fold_disable",
				zN = "fold_enable",
				zi = "fold_toggle_enable",
				gb = { -- example of a custom action that toggles the active view filter
					action = function(view)
						view:filter({ buf = 0 }, { toggle = true })
					end,
					desc = "Toggle Current Buffer Filter",
				},
				s = { -- example of a custom action that toggles the severity
					action = function(view)
						local f = view:get_filter("severity")
						local severity = ((f and f.filter.severity or 0) + 1) % 5
						view:filter({ severity = severity }, {
							id = "severity",
							template = "{hl:Title}Filter:{hl} {severity}",
							del = severity == 0,
						})
					end,
					desc = "Toggle Severity Filter",
				},
			},
			---@type table<string, trouble.Mode>
			modes = {
				-- sources define their own modes, which you can use directly,
				-- or override like in the example below
				lsp_references = {
					-- some modes are configurable, see the source code for more details
					params = {
						include_declaration = true,
					},
				},
				-- The LSP base mode for:
				-- * lsp_definitions, lsp_references, lsp_implementations
				-- * lsp_type_definitions, lsp_declarations, lsp_command
				lsp_base = {
					params = {
						-- don't include the current location in the results
						include_current = false,
					},
				},
				-- more advanced example that extends the lsp_document_symbols
				symbols = {
					desc = "document symbols",
					mode = "lsp_document_symbols",
					focus = false,
					win = { position = "right" },
					filter = {
						-- remove Package since luals uses it for control flow structures
						["not"] = { ft = "lua", kind = "Package" },
						any = {
							-- all symbol kinds for help / markdown files
							ft = { "help", "markdown" },
							-- default set of symbol kinds
							kind = {
								"Class",
								"Constructor",
								"Enum",
								"Field",
								"Function",
								"Interface",
								"Method",
								"Module",
								"Namespace",
								"Package",
								"Property",
								"Struct",
								"Trait",
							},
						},
					},
				},
			},
			icons = {
				---@type trouble.Indent.symbols
				indent = {
					top = "| ",
					middle = "+╴",
					last = "`-",
					-- last          = "-╴",
					-- last       = "╰╴", -- rounded
					fold_open = "v ",
					fold_closed = "> ",
					ws = "  ",
				},
				folder_closed = " ",
				folder_open = " ",
				kinds = {
					Array = "  ",
					Boolean = "  ",
					Class = "  ",
					Constant = "  ",
					Constructor = "  ",
					Enum = "  ",
					EnumMember = "  ",
					Event = "  ",
					Field = "  ",
					File = "  ",
					Function = "  ",
					Interface = "  ",
					Key = "  ",
					Method = "  ",
					Module = "  ",
					Namespace = "  ",
					Null = "  ",
					Number = "  ",
					Object = "  ",
					Operator = "  ",
					Package = "  ",
					Property = "  ",
					String = "  ",
					Struct = "  ",
					TypeParameter = "  ",
					Variable = "  ",
				},
			},
		},
	},
}
