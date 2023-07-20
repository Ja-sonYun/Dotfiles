vim.g.global_python_path = vim.env.HOME .. '/.globalpip/.venv/bin/python'

local map = require('keymap')

local resolve_python_path = function()
  -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
  -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
  -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
  local cwd = vim.fn.getcwd()
  if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
    return cwd .. '/venv/bin/python'
  elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
    return cwd .. '/.venv/bin/python'
  else
    return '/opt/homebrew/bin/python'
  end
end;

return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "<DIS>",
          pause = "<PAUSE>",
          play = "<PLAY>",
          run_last = "<RL>",
          step_back = "<ST_B>",
          step_into = "<ST_I>",
          step_out = "<ST_OU>",
          step_over = "<ST_OV>",
          terminate = "<TERM>"
        }
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = "-",
        current_frame = "<",
        expanded = "="
      },
      layouts = {
        {
          elements = { {
              id = "scopes",
              size = 0.25
            }, {
              id = "breakpoints",
              size = 0.25
            }, {
              id = "stacks",
              size = 0.25
            }, {
              id = "watches",
              size = 0.25
            } },
          position = "left",
          size = 40
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5
            }, {
              id = "console",
              size = 0.5
            } },
          position = "bottom",
          size = 10
        } },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100
      }
    },
  },
  -- {
  --   'mfussenegger/nvim-dap-python',
  --   opts = vim.g.global_python_path,
  --   init = function(dap_python)
  --     dap_python.test_runner = 'pytest'
  --     dap_python.resolve_python = resolve_python_path

  --     -- map.n('<space>dn', dap_python.test_method)
  --     -- map.n('<space>df', dap_python.test_class)
  --   end,
  -- },
  {
    'mfussenegger/nvim-dap',
    -- dapui need to be loaded before dap, so use init
    init = function()
      local dap = require('dap')

      -- dap configuration
      dap.adapters.python = {
        type = 'executable',
        command = vim.g.global_python_path,
        args = { '-m', 'debugpy.adapter' },
      }

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = 'launch';
          name = "Launch file";

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}"; -- This configuration will launch the current file if used.
          pythonPath = resolve_python_path;
        },
      }

      map.n('<space>dc', dap.continue)
      map.n('<space>db', dap.toggle_breakpoint)
      map.n('<space>dq', dap.terminate)

      vim.fn.sign_define('DapBreakpoint', {text='==', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='->', texthl='', linehl='', numhl=''})

      -- dapui configuration
      local dapui = require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        vim.fn.execute("Msg Dap terminated")
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        vim.fn.execute("Msg Dap exited")
        dapui.close()
      end

      map.n('<space>do', dapui.toggle)
      map.n('J', dapui.eval)
      map.n('<space>dl', function()
        dapui.float_element("breakpoints")
      end)
      map.n('<space>du', function()
        dapui.float_element("scopes")
      end)
      map.n('<space>ds', function()
        dapui.float_element("stacks")
      end)
      map.n('<space>dw', function()
        dapui.float_element("watches")
      end)
    end,
    dependencies = {
      'mfussenegger/nvim-dap-python',
      "rcarriga/nvim-dap-ui",
    },
  },
}
