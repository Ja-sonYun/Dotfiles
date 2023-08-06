local cmd = require("command")

cmd.shell_cf('Black', {'isort', 'black'})
cmd.shell_cf('Isort', {'isort'})
cmd.shell_cf('XeLatex', {'xelatex'})
cmd.shell_cf('LuaFormat', {'lua-format -i'})
cmd.shell_cf('RustFmt', {'rustfmt'})
cmd.shell_cf('Gofmt', {'gofmt -w'})
cmd.shell_cf('TerraformFmt', {'terraform fmt'})
cmd.shell_cf('Ruff', {'ruff'})
cmd.shell_cf('Clang', {'clang-format -i'})
cmd.shell_cf('Pysen', {'PYSEN_IGNORE_GIT=1 poetry run pysen run_files format'})
cmd.new(
  'PythonFormat',
  function()
    local current_file = vim.fn.expand('%:p')
    -- check that poetry has pysen
    local pysen = vim.fn.system('poetry run pysen --version')
    if string.find(pysen, 'not find') then
      -- fallback. run global formatter
      vim.cmd('!isort' .. ' ' .. current_file)
      vim.cmd('!black' .. ' ' .. current_file)
    else
      -- run pysen
      vim.cmd('!PYSEN_IGNORE_GIT=1 poetry run pysen run_files format' .. ' ' .. current_file)
    end
    vim.cmd('edit!')
    vim.cmd('write')
  end,
  {}
)
cmd.new(
  'Prettier',
  function()
    local current_file = vim.fn.expand('%:p')
    local has_prettier_in_npx = vim.fn.system('npm list')
    if string.find(has_prettier_in_npx, 'prettier') then
      vim.cmd('!npx prettier --plugin-search-dir=. --write' .. ' ' .. current_file)
    else
      vim.cmd('!prettier -w' .. ' ' .. current_file)
    end
    vim.cmd('edit!')
    vim.cmd('write')
  end,
  {}
)

local formatter_map = {
  ['PythonFormat'] = {'python'},
  ['LuaFormat'] = {'lua'},
  ['RustFmt'] = {'rust'},
  ['Prettier'] = {'javascript', 'typescript', 'css', 'scss', 'html', 'json', 'yaml', 'markdown', 'svelte', 'typescriptreact',},
  ['Clang'] = {'c', 'cpp'},
  ['Gofmt'] = {'go'},
  ['TerraformFmt'] = {'terraform'},
}

cmd.new(
  'Format',
  function()
    local filetype = vim.bo.filetype
    -- find formatter
    local formatter = nil
    for k, v in pairs(formatter_map) do
      for _, ft in pairs(v) do
        if ft == filetype then
          formatter = k
          break
        end
      end
    end
    if formatter == nil then
      print('No formatter found for filetype: ' .. filetype)
      return
    end
    vim.cmd(formatter)
  end,
  {}
)
