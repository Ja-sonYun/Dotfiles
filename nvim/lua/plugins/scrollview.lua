return {
  {
    'dstein64/nvim-scrollview',
    config = function(plugin, opts)
      local hl = require('highlight')
      -- set ScrollView color to red
      hl.set('ScrollView', {ctermbg=233})
      hl.set('ScrollViewCursor', {ctermfg='Yellow'})

      require('scrollview').setup({
        excluded_filetypes = {'nerdtree'},
        current_only = true,
        winblend = 100,
        signs_on_startup = {'all'},
        diagnostics_severities = {vim.diagnostic.severity.ERROR}
      })
    end,
  },
}
