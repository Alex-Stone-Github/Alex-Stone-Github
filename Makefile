.PHONY: install install-vim install-zsh install-alacritty install-nerdfont-proto

install: install-vim install-zsh install-alacritty install-tmux

install-vim:
	@echo "Installing new neovim configuration!"
	-mkdir ~/.config/nvim
	cp ./nvim/init.lua ~/.config/nvim/init.lua
	@echo "Successfully installed neovim configuration!"

install-zsh:
	@echo "Installing new zsh configuration!"
	cp ./zsh/.zshrc ~/.zshrc
	@echo "Successfully installed zsh configuration!"

install-tmux:
	@echo "Installing new tmux configuration!"
	cp ./tmux/.tmux.conf ~/.tmux.conf
	@echo "Successfully installed tmux configuration!"

install-alacritty: install-nerdfont-proto
	@echo "Installing alacritty configuration!"
	-mkdir ~/.config/alacritty
	cp alacritty/alacritty.toml ~/.config/alacritty/
	@echo "Successfully alacritty configuration!"

install-nerdfont-proto:
	@echo "Installing 0xProto Nerdfont!"
	- mkdir ~/.local/share/fonts
	unzip 0xProto.zip -d ~/.local/share/fonts
	@echo "Successfully Install 0xProto Nerdfont!"
	fc-cache -fv

