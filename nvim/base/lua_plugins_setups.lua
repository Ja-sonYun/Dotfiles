vim.g.winresizer_start_key = "<C-a>"

require("trouble").setup {
  position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = false, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "<", -- icon used for open folds
    fold_closed = "-", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      close = "q", -- close the list
      cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r", -- manually refresh
      jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" }, -- open buffer in new split
      open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
      open_tab = { "<c-t>" }, -- open buffer in new tab
      jump_close = {"o"}, -- jump to the diagnostic and close the list
      toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
      toggle_preview = "P", -- toggle auto_preview
      hover = "K", -- opens a small popup with the full multiline message
      preview = "p", -- preview the diagnostic location
      close_folds = {"zM", "zm"}, -- close all folds
      open_folds = {"zR", "zr"}, -- open all folds
      toggle_fold = {"zA", "za"}, -- toggle fold of current file
      previous = "k", -- preview item
      next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
      -- icons / text used for a diagnostic
      error = "E",
      warning = "W",
      hint = "H",
      information = "I",
      other = "O"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}


-- Question       xxx ctermfg=121 gui=bold guifg=Green

vim.api.nvim_set_hl(0, 'GitSignsAdd', {ctermbg=121, fg='Green'})
vim.api.nvim_set_hl(0, 'GitSignsChange', {ctermbg=121, fg='Orange'})
vim.api.nvim_set_hl(0, 'GitSignsDelete', {ctermbg=121, fg='Red'})
vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {ctermbg=121, fg='Grey'})

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = ' |'},
    change       = {hl = 'GitSignsChange', text = ' |'},
    delete       = {hl = 'GitSignsDelete', text = ' |'},
    topdelete    = {hl = 'GitSignsDelete', text = ' |'},
    changedelete = {hl = 'GitSignsChange', text = ' |'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, 'qhs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, 'qhr', ':Gitsigns reset_hunk<CR>')
    map('n', 'qhS', gs.stage_buffer)
    map('n', 'qhu', gs.undo_stage_hunk)
    map('n', 'qhR', gs.reset_buffer)
    map('n', 'H', gs.preview_hunk)
    map('n', 'qhb', function() gs.blame_line{full=true} end)
    -- map('n', 'qtb', gs.toggle_current_line_blame)
    map('n', 'qhd', gs.diffthis)
    map('n', 'qhD', function() gs.diffthis('~') end)
    map('n', 'qtd', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

require('colorizer').setup()

require('octo').setup()

require('telescope').setup {
  defaults = require('telescope.themes').get_ivy {
  },
}

require('nvim-surround').setup()
