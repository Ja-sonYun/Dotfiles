function _G.inspect(item)
	vim.print(item)
end

vim.g.logging_level = "info"

vim.g.loaded_perl_provider = 0 -- Disable perl provider
vim.g.loaded_ruby_provider = 0 -- Disable ruby provider
vim.g.loaded_node_provider = 0 -- Disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

vim.g.python3_host_prog = "~/.globalpip/.venv/bin/python"

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1
