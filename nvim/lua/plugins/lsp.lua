local get_python_path = function(path, workspace)
	local venv_env_path = os.getenv("VIRTUAL_ENV")
	-- Use activated virtualenv.
	if venv_env_path ~= nil then
		local venv_path = path.join(venv_env_path, "bin", "python3")
		require("message").Msg(venv_path, "MatchParen", { timestamp = true })
		return venv_path
	end

	-- Find and use virtualenv in workspace directory.
	-- Search for parent dir, sometimes vim-rooter use src folder
	for _, pattern in ipairs({ ".venv*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			local venv_path = path.join(path.dirname(match), "bin", "python")
			require("message").Msg(venv_path, "MatchParen", { timestamp = true })
			return venv_path
		end
	end

	-- Fallback to system Python.
	require("message").Msg("Fallback to system Python", "MatchParen", { timestamp = true })
	return "~/.globalpip/.venv/bin/python"
end

-- This strips out &nbsp; and some ending escaped backslashes out of hover
-- strings because the pyright LSP is... odd with how it creates hover strings.
local hover_pydoc = function(_, result, ctx, config)
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

local modify_diag = function()
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = false,
		virtual_text = {
			sign = false,
			prefix = "!",
			format = function(diag)
				local code = diag.code or ""
				if diag.severity == vim.diagnostic.severity.ERROR then
					return "[ERR(" .. diag.source .. ":" .. code .. ")]"
				end
				return "[WARN(" .. diag.source .. ")]"
			end,
		},
	})
end

vim.g.lsp_servers = {
	----------------------
	-- PYTHON
	----------------------
	pyright = function(lspconfig, util)
		local path = util.path
		return {
			settings = {
				python = {
					inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
			},
			before_init = function(_, config)
				-- Remove html tags from hover, pyright do this weird thing where it
				-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(hover_pydoc, {})
				config.settings.python.pythonPath = get_python_path(path, config.root_dir)
			end,
		}
	end,
	-- pylsp = function(lspconfig, util)
	-- 	return {
	-- 		before_init = function(client, config)
	-- 			-- disable hover signature
	-- 			config.settings.pylsp.plugins.pylsp_mypy.overrides = {
	-- 				"--python-executable",
	-- 				get_python_path(util.path, config.root_dir),
	-- 				true,
	-- 			}
	-- 		end,
	-- 		settings = {
	-- 			pylsp = {
	-- 				flags = {
	-- 					debounce_text_changes = 200,
	-- 				},
	-- 				plugins = {
	-- 					-- formatter options
	-- 					black = { enabled = true },
	-- 					autopep8 = { enabled = false },
	-- 					yapf = { enabled = false },
	-- 					-- linter options
	-- 					pylint = { enabled = false, executable = "pylint" },
	-- 					ruff = { enabled = false },
	-- 					pyflakes = { enabled = false },
	-- 					pycodestyle = { enabled = false },
	-- 					-- type checker
	-- 					pylsp_mypy = {
	-- 						enabled = true,
	-- 						report_progress = true,
	-- 						-- overrides = { "--python-executable", py_path, true },
	-- 						live_mode = false,
	-- 					},
	-- 					-- auto-completion options
	-- 					jedi_completion = { fuzzy = true },
	-- 					-- import sorting
	-- 					isort = { enabled = true },
	-- 				},
	-- 			},
	-- 		},
	-- 	}
	-- end,

	----------------------
	-- RUST
	----------------------
	rust_analyzer = {},

	----------------------
	-- TypeScript
	----------------------
	tsserver = {
		settings = {
			typescript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
		},
	},

	----------------------
	-- Go
	----------------------
	gopls = {},

	----------------------
	-- Vim
	----------------------
	vimls = {},

	----------------------
	-- Lua
	----------------------
	lua_ls = {},

	----------------------
	-- Bash
	----------------------
	bashls = {},

	----------------------
	-- Clangd
	----------------------
  clangd = {},
}
vim.g.lsp_servers["wgsl-analyzer"] = {}

return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- vim.lsp.set_log_level("off")

			-- Mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				local map = require("keymap")

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
				map.buf.n("<space>d", vim.lsp.buf.type_definition, bufnr)
				map.buf.n("grn", vim.lsp.buf.rename, bufnr)
				map.buf.n("gca", vim.lsp.buf.code_action, bufnr)
				map.buf.n("go", vim.lsp.buf.references, bufnr)
				if client.server_capabilities.documentFormattingProvider then
					map.buf.n("qf", vim.lsp.buf.format, bufnr)
				end
				map.buf.n("qh", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, bufnr)

				-- goto-preview
				local goto_p_status_ok, goto_preview = pcall(require, "goto-preview")
				if goto_p_status_ok then
					goto_preview.setup({
						width = 120, -- Width of the floating window
						height = 15, -- Height of the floating window
						border = { ",", "-", ".", "|", "'", "-", "`", "|" },
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
					map.buf.n("gp", goto_preview.goto_preview_definition, bufnr)
					-- map.buf.n("gpt", goto_preview.goto_preview_type_definition, bufnr)
					-- map.buf.n("gpi", goto_preview.goto_preview_implementation, bufnr)
					map.buf.n("gP", goto_preview.close_all_win, bufnr)
					-- map.buf.n("gpr", goto_preview.goto_preview_references, bufnr)
				end

				map.buf.n("\\D", vim.diagnostic.open_float, bufnr)
				map.buf.n("[d", vim.diagnostic.goto_prev, bufnr)
				map.buf.n("]d", vim.diagnostic.goto_next, bufnr)
				map.buf.n("<space>q", vim.diagnostic.setloclist, bufnr)
			end

			local lspconfig = require("lspconfig")
			local lsp_utils = require("lspconfig.util")

			local table = require("table_utils")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for lsp, opt in pairs(vim.g.lsp_servers) do
				if type(opt) == "function" then
					opt = opt(lspconfig, lsp_utils)
				end

				lspconfig[lsp].setup({
					before_init = function(client, config)
						if opt.before_init then
							opt.before_init(client, config)
						end
						modify_diag()
					end,
					on_attach = on_attach,
					capabilities = capabilities,
					settings = opt.settings,
				})
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
					ensure_installed = require("table_utils").keys(vim.g.lsp_servers),
				},
				init = function(plugin, opts)
					local mason_lspconfig = require("mason-lspconfig").setup(opts)

					local function mason_package_path(package)
						local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
						return path
					end

					-- depends on package manager / language
					local command = "venv/bin/pip"
					local args = {
						"install",
						"python-lsp-server[all]",
						"pylsp-mypy",
						"python-lsp-isort",
						"python-lsp-black",
					}

					require("plenary.job")
						:new({
							command = mason_package_path("python-lsp-server") .. "/" .. command,
							args = args,
						})
						:start()

					return mason_lspconfig
				end,
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		config = true,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			lua_snip = require("luasnip")
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-f>"] = function()
						lua_snip.jump(1)
					end,
					["<C-b>"] = function()
						lua_snip.jump(-1)
					end,
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
				}, {
					{ name = "buffer" },
				}),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- 	config = function(_, opts)
	-- 		require("lsp_signature").setup({
	-- 			hint_prefix = "~ ",
	-- 			handler_opts = {
	-- 				border = "none",
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
