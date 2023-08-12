-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- PERF: no need to load the plugin, if we only need its queries for mini.ai
					-- local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					-- local opts = require("lazy.core.plugin").values(plugin, "opts", false)
					-- local enabled = false
					-- if opts.textobjects then
					--   for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
					--     if opts.textobjects[mod] and opts.textobjects[mod].enable then
					--       enabled = true
					--       break
					--     end
					--   end
					-- end
					-- if not enabled then
					--   require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					-- end
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
