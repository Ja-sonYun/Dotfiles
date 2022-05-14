-- vim.api.nvim_win_set_config(0, { border = 'rounded' })

-- local border_flat = {
--   ',',
--   '-',
--   '.',
--   '|',
--   "'",
--   '-',
--   '`',
--   '|',
-- }
local border_flat = {
  '┌',
  '─',
  '┐',
  '│',
  "┘",
  '─',
  '└',
  '│',
}

local border = {}

for k, v in ipairs(border_flat) do
    border[k] = {v, "FloatBorder"}
end

vim.g.coq_settings = {
  auto_start = "shut-up",
  keymap = {
    recommended = false,
    jump_to_mark = "",
    manual_complete = "",
  },

  display = {
    pum = {
      fast_close = true,  -- false to prevent flickering
      ellipsis = "...",
      source_context = {"&[", "]"},
    },
    ghost_text = {
      context = {" < ", " > "},
      -- enabled = false,
    },
    preview = {
      border = border,
    },
    icons = {
      mode = "none"
    }
  }
}

vim.cmd [[
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
]]
-- vim.g.VM_maps = {
--     ["i Enter"] = "",
--     ["i BS"] = ""
-- }

require"fidget".setup {}

local nvim_lsp = require('lspconfig')

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({border='..vim.inspect(border_flat)..', focusable=false})<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({float={border='..vim.inspect(border_flat)..', focusable=false}})<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({float={border='..vim.inspect(border_flat)..', focusable=false}})<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

vim.highlight.create('NormalFloat', {guibg='Normal', guibg='Grey10'}, false)
vim.highlight.create('TreesitterContext', {gui='bold', guibg='Grey20'}, false)

vim.highlight.create('NormalBorder', {gui='bold', guibg='Grey10', guifg='Grey'}, false)
vim.highlight.create('FloatBorder', {gui='bold', guibg='Grey10', guifg='Grey'}, false)
vim.highlight.create('Visual', {gui='bold,undercurl', guibg='Grey30'}, false)
vim.highlight.create('Pmenu', {guibg='Grey10'}, false)
vim.highlight.create('PmenuSel', {gui='bold,undercurl', guibg='Grey20', guifg='Yellow'}, false)

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver", "ccls" }
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(servers) do
  -- nvim_lsp[lsp].setup({capabilities = capabilities, on_attach=on_attach, handlers=handlers})
  nvim_lsp[lsp].setup({on_attach=on_attach, handlers=handlers})
end


-- local cmp = require'cmp'

-- cmp.setup({
--   -- snippet = { expand = function() end },
--   snippet = {
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--     -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
--     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--     end,
--   },
--   window = {
--     completion = {
--       border = {',', '-', '.', '|', '\'', '-', '`', '|'},
--       winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
--     },
--     documentation = {
--       border = {',', '-', '.', '|', '\'', '-', '`', '|'}
--     },
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' }, -- For vsnip users.
--     -- { name = 'luasnip' }, -- For luasnip users.
--     -- { name = 'ultisnips' }, -- For ultisnips users.
--     -- { name = 'snippy' }, -- For snippy users.
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- -- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

