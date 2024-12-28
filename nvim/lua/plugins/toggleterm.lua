return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			-- size can be a number or function which is passed the current terminal
			size = 20,
			open_mapping = [[<c-\>]],
			-- on_create = fun(t: Terminal), -- function to run when the terminal is first created
			on_open = function(term)
				vim.cmd("startinsert!")
				-- vim.cmd("set laststatus=0")
			end,
			on_close = function(term)
				-- vim.cmd("set laststatus=2")
			end,
			-- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
			-- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
			-- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
			hide_numbers = true, -- hide the number column in toggleterm buffers
			-- shade_filetypes = {},
			autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
			-- highlights = {
			--   -- highlights which map to a highlight group name and a table of it's values
			--   -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
			--   Normal = {
			--     guibg = "<VALUE-HERE>",
			--   },
			--   NormalFloat = {
			--     link = 'Normal'
			--   },
			--   FloatBorder = {
			--     guifg = "<VALUE-HERE>",
			--     guibg = "<VALUE-HERE>",
			--   },
			-- },
			-- shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
			-- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
			start_in_insert = true,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
			persist_size = true,
			persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
			-- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
			close_on_exit = true, -- close the terminal window when the process exits
			shell = vim.o.shell, -- change the default shell
			auto_scroll = true, -- automatically scroll to the bottom on terminal output
			-- This field is only relevant if direction is set to 'float'
			-- float_opts = {
			-- The border key is *almost* the same as 'nvim_open_win'
			-- see :h nvim_open_win for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
			-- like `size`, width and height can be a number or function which is passed the current terminal
			-- width = <value>,
			-- height = <value>,
			-- winblend = 3,
			-- },
			winbar = {
				enabled = false,
				name_formatter = function(term) --  term: Terminal
					return term.name
				end,
			},
		},
		config = function()
			local Terminal = require("toggleterm.terminal").Terminal

			vim.g.shell_opened = 0

			function terminal_shell(command)
				local term = Terminal:new({
					cmd = "trap : INT;"
						.. command
						.. " ; printf '\n[exit_code:%s] %s' $! 'Press enter to continue...' && read ans",
					dir = vim.fn.getcwd(),

					-- function to run on opening the terminal
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.cmd("set laststatus=0")
					end,
					-- function to run on closing the terminal
					on_close = function(term)
						vim.g.shell_opened = 0
						vim.cmd("startinsert!")
						vim.cmd("set laststatus=2")
					end,
					-- close_on_exit = false,
				})
				term:open()
			end

			function switch_to_filetype_buffer(filetype)
				-- 모든 버퍼의 ID를 가져옴
				local buffers = vim.api.nvim_list_bufs()

				for _, buf in ipairs(buffers) do
					-- 버퍼가 유효하고 로드된 상태인지 확인
					if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
						-- 버퍼의 파일 유형을 가져옴
						local buf_filetype = vim.api.nvim_buf_get_option(buf, "filetype")
						if buf_filetype == filetype then
							-- 파일 유형이 일치하면 해당 버퍼로 전환
							vim.api.nvim_set_current_buf(buf)
							return
						end
					end
				end

				print("No buffer with filetype: " .. filetype)
			end

			function focus_shell()
				local buffers = vim.api.nvim_list_bufs()
				for _, buf in ipairs(buffers) do
					if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
						local buf_filetype = vim.api.nvim_buf_get_option(buf, "filetype")
						if buf_filetype == "toggleterm" then
							vim.api.nvim_set_current_buf(buf)
							return
						end
					end
				end
			end

			local cmd = require("command")

			cmd.new("Shell", function(opts)
				local cmd = opts.args:gsub("%%", vim.fn.expand("%:p"))
				if vim.g.shell_opened == 1 then
					vim.cmd("Err Shell already opened!")
					return
				end
				vim.g.shell_opened = 1
				terminal_shell(cmd)
			end, { nargs = "*", complete = "file" })

			cmd.new("ShellClear", function(opts)
				vim.g.shell_opened = 0
				vim.cmd("set laststatus=2")
			end, {})

			cmd.new("FocusShell", function(opts)
				focus_shell()
			end, {})
		end,
	},
}
