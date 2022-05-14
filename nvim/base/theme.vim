" theme

highlight! Folded gui=bold,italic,undercurl guifg=LightBlue guibg=Normal
highlight! LspDiagnosticsVirtualTextError guifg=red gui=bold,italic,underline
highlight! LspDiagnosticsVirtualTextWarning guifg=orange gui=bold,italic,underline
highlight! LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,underline
highlight! LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,underline
highlight! clear SignColumn

" fzf theme
let g:fzf_layout = { 'down': '20%' }

" ----------------------------------------------------------------------------------
" ----------------------------------------------------------------------------------
" ----------------------------------------------------------------------------------
" ----------------------------------------------------------------------------------
" augroup ColorschemePreferences
"   autocmd!
"   " These preferences clear some gruvbox background colours, allowing transparency
"   " autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
"   autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
"   " autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
"   " autocmd ColorScheme * highlight LineNr     ctermfg=NONE guibg=NONE
"   " autocmd ColorScheme * highlight NonText    guifg=NONE guibg=NONE ctermbg=NONE
"   " Link ALE sign highlights to similar equivalents without background colours
" augroup END


" highlight link CompeDocumentation NormalFloat
" maybe remove
" hi LspDiagnosticsVirtualTextError guifg=red gui=bold,italic,underline
" hi LspDiagnosticsVirtualTextWarning guifg=orange gui=bold,italic,underline
" hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,underline
" hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,underline

" lua << EOF
" -- Eviline config for lualine
" -- Author: shadmansaleh
" -- Credit: glepnir
" local lualine = require 'lualine'

" -- Color table for highlights
" local colors = {
"   bg = '#202328',
"   inabg = '#191919',
"   fg = '#bbc2cf',
"   yellow = '#ECBE7B',
"   cyan = '#008080',
"   darkblue = '#081633',
"   green = '#98be65',
"   orange = '#FF8800',
"   violet = '#a9a1e1',
"   magenta = '#c678dd',
"   blue = '#51afef',
"   red = '#ec5f67',
"   separator = "#444444",
" }

" local conditions = {
"   buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
"   hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
" }
"   --check_git_workspace = function()
"   --  local filepath = vim.fn.expand('%:p:h')
"   --  local gitdir = vim.fn.finddir('.git', filepath .. ';')
"   --  return gitdir and #gitdir > 0 and #gitdir < #filepath
"   --end

" -- Config
" local config = {
"   options = {
"     -- Disable sections and component separators
"     component_separators = "",
"     section_separators = "",
"     theme = {
"       -- We are going to use lualine_c an lualine_x as left and
"       -- right section. Both are highlighted by c theme .  So we
"       -- are just setting default looks o statusline
"       normal = {c = {fg = colors.fg, bg = colors.bg}},
"       inactive = {c = {fg = colors.fg, bg = colors.inabg}}
"     },
"   },
"   sections = {
"     -- these are to remove the defaults
"     lualine_a = {},
"     lualine_b = {},
"     lualine_y = {},
"     lualine_z = {},
"     -- These will be filled later
"     lualine_c = {},
"     lualine_x = {}
"   },
"   inactive_sections = {
"     -- these are to remove the defaults
"     lualine_a = {},
"     lualine_v = {},
"     lualine_y = {},
"     lualine_z = {},
"     lualine_c = {},
"     lualine_x = {}
"   }
" }

" -- Inserts a component in lualine_c at left section
" local function ins_left(component)
"   table.insert(config.sections.lualine_c, component)
"   table.insert(config.inactive_sections.lualine_c, component)
" end

" local function ins_section_left(component)
"   table.insert(config.sections.lualine_c, component)
" end

" local function ins_inactive_section_left(component)
"   table.insert(config.inactive_sections.lualine_c, component)
" end

" -- Inserts a component in lualine_x ot right section
" local function ins_right(component)
"   table.insert(config.sections.lualine_x, component)
"   table.insert(config.inactive_sections.lualine_x, component)
" end

" local function ins_section_right(component)
"   table.insert(config.sections.lualine_x, component)
" end

" local function ins_inactive_section_right(component)
"   table.insert(config.inactive_sections.lualine_x, component)
" end

" ins_section_left {
"   function() return '█' end,
"   color = {fg = colors.blue}, -- Sets highlighting of component
"   left_padding = 0 -- We don't need space before this
" }
" ins_inactive_section_left {
"   function() return '-' end,
"   left_padding = 0 -- We don't need space before this
" }

" local mode_color = {
"   n = colors.red,
"   i = colors.green,
"   v = colors.blue,
"   [''] = colors.blue,
"   V = colors.blue,
"   c = colors.magenta,
"   no = colors.red,
"   s = colors.orange,
"   S = colors.orange,
"   [''] = colors.orange,
"   ic = colors.yellow,
"   R = colors.violet,
"   Rv = colors.violet,
"   cv = colors.red,
"   ce = colors.red,
"   r = colors.cyan,
"   rm = colors.cyan,
"   ['r?'] = colors.cyan,
"   ['!'] = colors.red,
"   t = colors.red
" }

" ins_section_left {
"   -- mode component
"   function()
"     -- auto change color according to neovims mode
"     vim.api.nvim_command(
"         'hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. " guibg=" ..
"             colors.bg)
"     return '@'
"   end,
"   color = "LualineMode",
"   left_padding = 0
" }

" ins_inactive_section_left {
"   function()
"     -- auto change color according to neovims mode
"     vim.api.nvim_command(
"         'hi! LualineMode guifg=' .. colors.yellow .. " guibg=" ..
"             colors.inabg)
"     return '@'
"   end,
"   color = "LualineMode",
"   left_padding = 0
" }

" ins_left {
"   -- filesize component
"   function()
"     local function format_file_size(file)
"       local size = vim.fn.getfsize(file)
"       if size <= 0 then return '' end
"       local sufixes = {'b', 'k', 'm', 'g'}
"       local i = 1
"       while size > 1024 do
"         size = size / 1024
"         i = i + 1
"       end
"       return string.format('%.1f%s', size, sufixes[i])
"     end
"     local file = vim.fn.expand('%:p')
"     if string.len(file) == 0 then return '' end
"     return format_file_size(file)
"   end,
"   condition = conditions.buffer_not_empty
" }

" ins_left {
"   'filename',
"   condition = conditions.buffer_not_empty,
"   color = {fg = colors.magenta, gui = 'bold'}
" }

" ins_left {'location'}

" ins_left {'progress'}

" ins_left {
"   'diagnostics',
"   sources = {'nvim_lsp'},
"   symbols = {error = 'E ', warn = 'W ', info = 'I '},
" }

" -- Insert mid section. You can make any number of sections in neovim :)
" -- for lualine it's any number greater then 2
" ins_left {function() return '%=' end}

" ins_inactive_section_left {
"   function() return vim.fn.expand('%:p:h') end,
"   right_padding = 0
" }

" -- Add components to right sections
" ins_right {
"   'filetype', -- option component same as &encoding in viml
"   upper = true, -- I'm not sure why it's upper case either ;)
"   condition = conditions.hide_in_width,
" }

" ins_right {
"   'o:encoding', -- option component same as &encoding in viml
"   upper = true, -- I'm not sure why it's upper case either ;)
"   condition = conditions.hide_in_width,
" }

" ins_section_right {
"   'diff',
"   -- Is it me or the symbol for modified us really weird
"   symbols = {added = '+', modified = '!', removed = '-'},
"   condition = conditions.hide_in_width
" }

" ins_section_right {
"   function() return '█' end,
"   right_padding = 0
" }
" ins_inactive_section_right {
"   function() return '-' end,
"   right_padding = 0
" }

" -- Now don't forget to initialize lualine
" lualine.setup(config)

" ---------------------------------------------------------------------------bufferline
" require('bufferline').setup {
"   highlights = {
"     fill = {
"       guibg = colors.inabg,
"     },
"     indicator_selected = {
"       guifg = colors.red,
"       guibg = colors.bg,
"     },
"     buffer_selected = {
"       guibg = colors.bg,
"     },
"     diagnostic_selected = {
"       guibg = colors.bg,
"     },
"     info_selected = {
"       guibg = colors.bg,
"     },
"     warning_selected = {
"       guibg = colors.bg,
"     },
"     error_selected = {
"       guibg = colors.bg,
"     },
"     modified_selected = {
"       guibg = colors.bg,
"     },
"     pick_selected = {
"       guibg = colors.bg,
"     },
"   },
"   options = {
"     numbers = "none",
"     numbers = "superscript", -- buffer_id at index 1, ordinal at index 2
"     -- mappings = false,
"     close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
"     right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
"     left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
"     middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
"     -- NOTE: this plugin is designed with this icon in mind,
"     -- and so changing this is NOT recommended, this is intended
"     -- as an escape hatch for people who cannot bear it for whatever reason
"     indicator_icon = ' >>',
"     buffer_close_icon = 'X',
"     modified_icon = '●',
"     close_icon = 'x',
"     left_trunc_marker = '<',
"     right_trunc_marker = '>',
"     --- name_formatter can be used to change the buffer's label in the bufferline.
"     --- Please note some names can/will break the
"     --- bufferline so use this at your discretion knowing that it has
"     --- some limitations that will *NOT* be fixed.
"     name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
"       -- remove extension from markdown files for example
"       if buf.name:match('%.md') then
"         return vim.fn.fnamemodify(buf.name, ':t:r')
"       end
"     end,
"     max_name_length = 18,
"     max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
"     tab_size = 18,
"     diagnostics = "nvim_lsp",
"     diagnostics_indicator = function(count, level, diagnostics_dict, context)
"       return "("..count..")"
"     end,
"     -- NOTE: this will be called a lot so don't do any heavy processing here
"     custom_filter = function(buf_number)
"       -- filter out filetypes you don't want to see
"       if vim.bo[buf_number].filetype ~= "NvimTree" then
"         return true
"       end
"       -- filter out by buffer name
"       -- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
"       --  return true
"       -- end
"       -- filter out based on arbitrary rules
"       -- e.g. filter out vim wiki buffer from tabline in your work repo
"       -- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
"       --  return true
"       -- end
"     end,
"     offsets = {
"       {
"         filetype = "NvimTree",
"         text = "File Explorer",
"         text_align = "center",
"         highlight = "search"
"       }
"     },
"     show_buffer_icons = false, -- disable filetype icons for buffers
"     show_buffer_close_icons = false,
"     show_close_icon = false,
"     show_tab_indicators = true,
"     persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
"     -- can also be a table containing 2 custom separators
"     -- [focused and unfocused]. eg: { '|', '|' }
"     -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
"     separator_style = { '█', '█' },
"     enforce_regular_tabs = false,
"     always_show_bufferline = true,
"     sort_by = "id",
"     custom_areas = {
"       left = function ()
"         return {{text = " █", guibg = colors.separator, guifg = colors.blue}}
"       end,
"       right = function()
"         local result = {}
"         table.insert(result, {text = " ", guibg = colors.bg})

"         local git_workspace = vim.call('fugitive#head')
"         if git_workspace ~= "" then
"           local git_stat = vim.fn.system('gitstat'):sub(1, -2)
"           table.insert(result, {text = git_stat .. " ", guifg = colors.violet, guibg = colors.bg})

"           table.insert(result, {text = "#" .. git_workspace, guifg = colors.violet, guibg = colors.bg})
"         end

"         table.insert(result, {text = " █", guibg = colors.bg, guifg = colors.blue})
"         return result
"       end,
"     },
"   }
" }
" EOF

