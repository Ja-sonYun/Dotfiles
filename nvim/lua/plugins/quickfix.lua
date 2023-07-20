return {
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      local hl = require('highlight')

      hl.set('BqfPreviewFloat', { ctermbg = 0 })
      hl.set('BqfPreviewBorder', { ctermbg = 0 })
    end,
    opts = {
      auto_enable = true,
      auto_resize_height = true, -- highly recommended enable
      preview = {
        win_height = 12,
        win_vheight = 12,
        winblend = 0,
        delay_syntax = 80,
        border = {',', '-', '.', '|', '\'', '-', '`', '|'},
        show_title = false,
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            -- skip file size greater than 100k
            ret = false
          elseif bufname:match('^fugitive://') then
            -- skip fugitive buffer
            ret = false
          end
          return ret
        end
      },
    },
    config = function(plugin, opts)
      return require('bqf').setup(opts)
    end,
  },
}
