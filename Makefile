.PHONY: *
CONFIG=~/config

brew_dump:
	brew bundle dump -f

npm_global_dump:
	npm list --global --parseable --depth=0 | sed '1d' | awk '{gsub(/\/.*\//,"",$$1); print}' > Npmfile

cargo_dump:
	cargo install --list > Cargofile

pipx_dump:
	pipx list --short > Pipxfile

dump:
	$(MAKE) brew_dump
	$(MAKE) npm_global_dump
	$(MAKE) cargo_dump
	$(MAKE) pipx_dump

brew_install:
	brew bundle

npm_install_from_dumped:
	xargs npm install --global < Npmfile

set_zshrc:
	ln -sf ${CONFIG}/zsh/zshrc ~/.zshrc

set_radare2rc:
	ln -sf ${CONFIG}/radare2/radare2rc ~/.radare2rc

set_vimrc:
	ln -sf ${CONFIG}/nvim ~/.config/nvim

set_tmux:
	ln -sf ${CONFIG}/tmux/tmux.conf ~/.tmux.conf

set_alacritty:
	ln -sf ${CONFIG}/alacritty/alacritty.yml ~/.config/alacritty.yml

set_gitui_keybind:
	ln -sf ${CONFIG}/gitui/key_bindings.ron ~/.config/gitui/key_bindings.ron

set_weechat:
	ln -sf ${CONFIG}/weechat ~/.weechat

set_mutt:
	ln -sf ${CONFIG}/mutt ~/.mutt

set_globalpip:
	ln -sf ${CONFIG}/global-pip ~/.globalpip
	poetry config virtualenvs.create true
	poetry config virtualenvs.in-project true
	cd ~/.globalpip && poetry install

set_gh_dash:
	ln -sf ${CONFIG}/gh-dash ~/.config/gh-dash

set_gitignore:
	git config --global core.excludesfile ${CONFIG}/global_gitignore

set_pull_submodules:
	git submodule update --recursive --remote

set_mac_window_manager:
	ln -sf ${CONFIG}/window-management/mac/yabairc ~/.yabairc
	ln -sf ${CONFIG}/window-management/mac/skhdrc ~/.skhdrc
	ln -sf ${CONFIG}/window-management/mac/sketchybar ~/.config/sketchybar

set_taskwarrior:
	ln -sf ${CONFIG}/taskwarrior ~/.task
	ln -sf ${CONFIG}/taskwarrior/taskrc ~/.taskrc

set_all:
	$(MAKE) set_zshrc
	$(MAKE) set_radare2rc
	$(MAKE) set_vimrc
	$(MAKE) set_tmux
	$(MAKE) set_alacritty
	$(MAKE) set_gitui_keybind
	$(MAKE) set_weechat
	$(MAKE) set_mutt
	$(MAKE) set_globalpip
	$(MAKE) set_gitignore
	$(MAKE) set_mac_window_manager
