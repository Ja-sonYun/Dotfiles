return {
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { 'mm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', silent=true },
      { 'ma', ':lua require("harpoon.mark").add_file()<CR>:Msg File added<CR>', silent=true },
      { 'mp', ':lua require("harpoon.ui").nav_prev()<CR>:Msg Nav prev<CR>', silent=true },
      { 'mn', ':lua require("harpoon.ui").nav_next()<CR>:Msg Nav next<CR>', silent=true },
    }
  },
}
