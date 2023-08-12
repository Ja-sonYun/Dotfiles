local table = require("table_utils")

vim.g.lsp_servers = {
	"pyright",
	"rust_analyzer",
	"tsserver",
	"svelte",
	"elixirls",
	"clangd",
	"cmake",
	"dockerls",
	"bashls",
	"clangd",
	"gopls",
}

return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local map = require("keymap")
			local table = require("table_utils")

			local lspconfig = require("lspconfig")

			-- vim.lsp.set_log_level("off")

			-- Pyright
			local util = require("lspconfig/util")
			local path = util.path
			local function get_python_path(workspace)
				-- Use activated virtualenv.
				if vim.env.VIRTUAL_ENV then
					return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
				end

				-- Find and use virtualenv in workspace directory.
				-- Search for parent dir, sometimes vim-rooter use src folder
				for _, pattern in ipairs({ "*", ".*" }) do
					local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
					if match ~= "" then
						return path.join(path.dirname(match), "bin", "python")
					end
				end

				-- Fallback to system Python.
				return "~/.globalpip/.venv/bin/python"
			end

			-- This strips out &nbsp; and some ending escaped backslashes out of hover
			-- strings because the pyright LSP is... odd with how it creates hover strings.
			local hover = function(_, result, ctx, config)
				if not (result and result.contents) then
					return vim.lsp.handlers.hover(_, result, ctx, config)
				end
				if type(result.contents) == "string" then
					local s = string.gsub(result.contents or "", "&nbsp;", " ")
					s = string.gsub(s, [[\\\n]], [[\n]])
					result.contents = s
					return vim.lsp.handlers.hover(_, result, ctx, config)
				else
					local s = string.gsub((result.contents or {}).value or "", "&nbsp;", " ")
					s = string.gsub(s, "\\\n", "\n")
					result.contents.value = s
					return vim.lsp.handlers.hover(_, result, ctx, config)
				end
			end

			-----------------------------------------------------------

			-----------------------------------------------------------
			-- Lsp
			local pyright_opts = {
				before_init = function(_, config)
					-- Remove html tags from hover, pyright do this weird thing where it
					vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(hover, {})
					config.settings.python.pythonPath = get_python_path(config.root_dir)
				end,
			}
			-----------------------------------------------------------

			-- Mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			map.n("L", vim.diagnostic.open_float)
			map.n("[d", vim.diagnostic.goto_prev)
			map.n("]d", vim.diagnostic.goto_next)
			map.n("<space>q", vim.diagnostic.setloclist)

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				vim.diagnostic.config({
					-- virtual_lines = {
					--   only_current_line = true
					-- },
					signs = false,
					virtual_text = {
						prefix = "<<",
						format = function(diag)
							if diag.severity == vim.diagnostic.severity.ERROR then
								return "[ERROR]"
							end
							return "[WARNING]"
						end,
					},
				})

				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				map.buf.n("gD", vim.lsp.buf.declaration, bufnr)
				map.buf.n("gd", vim.lsp.buf.definition, bufnr)
				map.buf.n("K", vim.lsp.buf.hover, bufnr)
				map.buf.n("gi", vim.lsp.buf.implementation, bufnr)
				map.buf.n("<space>k", vim.lsp.buf.signature_help, bufnr)
				map.buf.n("<space>wa", vim.lsp.buf.add_workspace_folder, bufnr)
				map.buf.n("<space>wr", vim.lsp.buf.remove_workspace_folder, bufnr)
				map.buf.n("<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufnr)
				map.buf.n("<leader>d", vim.lsp.buf.type_definition, bufnr)
				map.buf.n("grn", vim.lsp.buf.rename, bufnr)
				map.buf.n("gca", vim.lsp.buf.code_action, bufnr)
				map.buf.n("grf", vim.lsp.buf.references, bufnr)
				map.buf.n("gf", function()
					vim.lsp.buf.format({ async = true })
				end, bufnr)

				-- goto-preview
				local goto_p_status_ok, goto_preview = pcall(require, "goto-preview")
				if goto_p_status_ok then
					goto_preview.setup({
						width = 120, -- Width of the floating window
						height = 15, -- Height of the floating window
						border = { ",", "-", ".", "|", "'", "-", "`", "|" }, -- Border characters of the floating window
						default_mappings = false, -- Bind default mappings
						debug = false, -- Print debug information
						opacity = 0, -- 0-100 opacity level of the floating window where 100 is fully transparent.
						resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
						post_open_hook = function(buf, win)
							map.buf.n("q", ":q<cr>", { nowait = true })
							map.buf.n("<C-c>", ":q<cr>", { nowait = true })
							vim.api.nvim_win_set_option(win, "winhighlight", "Normal:")
							-- remove relnumber group
							vim.opt_local.number = true
							vim.opt_local.relativenumber = true
						end, -- A function taking two arguments, a buffer and a window to be ran as a hook.
						-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
						focus_on_open = true, -- Focus the floating window when opening it.
						dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
						force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
						bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
					})
					map.buf.n("gpd", goto_preview.goto_preview_definition, bufnr)
					map.buf.n("gpt", goto_preview.goto_preview_type_definition, bufnr)
					map.buf.n("gpi", goto_preview.goto_preview_implementation, bufnr)
					map.buf.n("gP", goto_preview.close_all_win, bufnr)
					map.buf.n("gpr", goto_preview.goto_preview_references, bufnr)
				end
			end

			local lsp_flags = {
				-- This is the default in Nvim 0.7+
				-- debounce_text_changes = 0,
			}

			local handlers = {
				-- ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
				-- ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, lsp in pairs(vim.g.lsp_servers) do
				local opts = {}
				if lsp == "pyright" then
					opts = pyright_opts
				end

				lspconfig[lsp].setup(table.concat({
					on_attach = on_attach,
					-- flags = lsp_flags,
					capabilities = capabilities,
					-- handlers = handlers,
				}, opts))
			end
		end,
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = true,
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = vim.g.lsp_servers,
				},
				init = function(plugin, opts)
					return require("mason-lspconfig").setup(opts)
				end,
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		config = true,
		tag = "legacy",
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	-- {
	--   "ms-jpq/coq_nvim",
	--   branch = "coq",
	--   build = ":COQdeps",
	--   dependencies = {
	--     {
	--       "ms-jpq/coq.thirdparty",
	--       branch = "3p",
	--     },
	--   },
	--   init = function()
	--     vim.g.coq_settings = {
	--       auto_start = true,
	--       keymap = {
	--         recommended = false,
	--         bigger_preview = "<C-_>",
	--         jump_to_mark = "<C-_>",
	--         manual_complete = "<C-n>",
	--         pre_select = true,
	--       },
	--       display = {
	--         ghost_text = {
	--           enabled = false,
	--         },
	--         pum = {
	--           kind_context = {" [", "] "},
	--           source_context = {" (", ")"},
	--           ellipsis = "...",
	--         },
	--         preview = {
	--           border = {
	--             {"", "NormalFloat"},
	--             {"", "NormalFloat"},
	--             {"", "NormalFloat"},
	--             {" ", "NormalFloat"},
	--             {"", "NormalFloat"},
	--             {"", "NormalFloat"},
	--             {"", "NormalFloat"},
	--             {" ", "NormalFloat"}
	--           },
	--           positions = { north = 2, south = 4, west = 3, east = 1 },
	--         },
	--         icons = {
	--           mode = "none",
	--         },
	--       },
	--     }
	--     vim.cmd [[
	--       ino <silent><expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
	--       ino <silent><expr> <ESC>    pumvisible() ? "\<C-e><Esc>" : "\<ESC>"
	--       ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><Esc>" : "\<C-c>"
	--     ]]
	--   end,
	-- },
}
