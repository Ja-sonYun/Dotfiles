-- Set nvim init path
local prefix = vim.env.MYVIMRC:match("(.+)/init.lua") .. "/lua"

-- Append for common and modules
package.path = prefix .. "/common/?.lua;" .. prefix .. "/modules/?.lua;" .. package.path

-- Import core
local auto_import_folder = "core,themes"
local glob = prefix .. "/{" .. auto_import_folder .. "}/*.lua"
local files = vim.fn.glob(glob, 0, 1)

-- load all files under core
for _, file in ipairs(files) do
	local filename = file:sub(#prefix + 2):gsub("%.lua", "")

	-- load if file not starts with _ or common
	if not filename:match("_") and filename ~= "" then
		require(filename)
	end
end

-- After laoded, import plugins
require("lazy_init")
