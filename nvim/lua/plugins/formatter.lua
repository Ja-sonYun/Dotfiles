return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"ql",
			function()
				local cleaner = require("message").Msg(
					"Running Formatter...",
					"MatchParen",
					{ timestamp = true, ret_cleaner = true }
				)
				require("conform").format({ async = true, lsp_fallback = true }, function(err)
					cleaner()
					if err then
						vim.cmd("Err failed to format")
						vim.notify(err)
					else
						vim.cmd("Ok format successful")
					end
				end)
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- Everything in opts will be passed to setup()
	opts = {
		notify_on_error = false,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "pysen", "my_isort", "my_black" }, --, "ruff_fix" },
			terraform = { "terraform_fmt" },
			javascript = { { "prettierd", "prettier" } },
			javascriptreact = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			go = { "gofmt" },
			html = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			rust = { "rustfmt" },
			swift = { "swiftformat" },
			sh = { "shellscript", "shellcheck" },
			bash = { "shellscript", "shellcheck" },
			zsh = { "shellscript", "shellcheck" },
			markdown = { "markdownlint" },
			c = { "clang_format" },
			cpp = { "clang_format" },

			["_"] = { "trim_whitespace" },
		},
		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters = {
			rustfmt = {
				command = "rustfmt",
				args = { "--edition", "2021" },
			},
			shellscript = {
				command = "shfmt",
				args = { "-i", "4", "-ci" },
			},
			-- swift
			swiftformat = {
				command = "swift-format",
				args = { "$FILENAME", "-i" },
				stdin = false,
			},
			-- Python formatters
			pysen = {
				command = "poetry",
				args = { "run", "pysen", "run_files", "format", "$FILENAME" },
				stdin = false,
				condition = function(self, ctx)
					local pyproject = vim.fn.system("cat pyproject.toml")
					return string.find(pyproject, "pysen")
				end,
				exit_codes = { 0 },
				env = {
					PYSEN_IGNORE_GIT = 1,
				},
			},
			my_isort = {
				command = "isort",
				args = { "$FILENAME" },
				condition = function(self, ctx)
					local pysen = vim.fn.system("[ -f pyproject.toml ] && cat pyproject.toml")
					return not string.find(pysen, "pysen")
				end,
				stdin = false,
				exit_codes = { 0 },
			},
			my_black = {
				command = "black",
				args = { "$FILENAME" },
				condition = function(self, ctx)
					local pysen = vim.fn.system("[ -f pyproject.toml ] && cat pyproject.toml")
					return not string.find(pysen, "pysen")
				end,
				stdin = false,
				exit_codes = { 0 },
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,

	-- This function is optional, but if you want to customize formatters do it here
	config = function(_, opts)
		local util = require("conform.util")
		util.add_formatter_args(require("conform.formatters.shfmt"), { "-i", "2" })
		require("conform").setup(opts)
	end,
}
