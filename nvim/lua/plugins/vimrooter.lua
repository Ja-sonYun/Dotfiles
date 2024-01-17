return {
	{
		"airblade/vim-rooter",
		config = function()
			vim.g.rooter_patterns = {
				".git",
				"*.sln",
				"build/env.sh",
				"pyproject.toml",
				"env",
				"Pipenv",
				"setup.cfg",
				"setup.py",
				".venv",
				-- '.env',
				-- 'requirements.txt',
				"package.json",
				"package-lock.json",
				"node_modules",
				"yarn.lock",
				"yarn-error.log",
				"composer.json",
				"composer.lock",
				"vendor",
				"Gemfile",
				"Gemfile.lock",
				"Podfile",
				"Podfile.lock",
				"Pods",
				"Cartfile",
				"Cartfile.resolved",
				"Carthage",
				"Carthage.resolved",
				"vimrc",
				"init.lua",
				".terraform",
			}
		end,
	},
}
