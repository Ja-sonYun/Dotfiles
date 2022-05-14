" tree sitter based folding
" set foldexpr=nvim_treesitter#foldexpr()

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",
  sync_install = false,

  ignore_install = { "phpdoc" },

  highlight = {
    enable = true,
    -- disable = { "vim", "lua" },
  },

  -- indent = {
  --   enable = true,
  -- },
}
EOF
