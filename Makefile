.PHONY: install install-all install-vim-config install-zsh-config install-alacritty-config install-nerdfont-proto

install: install-vim-config install-zsh-config install-tmux-config

install-all: install install-alacritty-config 

install-vim-config:
	@echo "Installing new neovim configuration!"
	-mkdir ~/.config/nvim
	cp ./nvim/init.lua ~/.config/nvim/init.lua
	cp ./nvim/coc-settings.json ~/.config/nvim/coc-settings.json
	@echo "Successfully installed neovim configuration!"

install-zsh-config:
	@echo "Installing new zsh configuration!"
	cp ./zsh/.zshrc ~/.zshrc
	@echo "Successfully installed zsh configuration!"

install-tmux-config:
	@echo "Installing new tmux configuration!"
	cp ./tmux/.tmux.conf ~/.tmux.conf
	@echo "Successfully installed tmux configuration!"

install-alacritty-config: install-nerdfont-proto
	@echo "Installing alacritty configuration!"
	-mkdir ~/.config/alacritty
	cp alacritty/alacritty.toml ~/.config/alacritty/
	@echo "Successfully alacritty configuration!"

install-nerdfont-proto:
	@echo "Installing 0xProto Nerdfont!"
	-mkdir ~/.local/share/fonts
	unzip -n 0xProto.zip -d ~/.local/share/fonts
	@echo "Successfully Install 0xProto Nerdfont!"
	fc-cache -fv

