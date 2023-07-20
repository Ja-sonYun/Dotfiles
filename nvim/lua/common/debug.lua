M = {}

-- print dict
M.print = function(any)
  if type(any) == 'table' then
    print(vim.inspect(any))
  else
    print(any)
  end
end
