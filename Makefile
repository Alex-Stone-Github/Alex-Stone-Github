.PHONY: install install-all install-neovim-config install-zsh-config install-nerdfont-proto install-emacs-config install-alacritty-config noop

noop:

install: install-neovim-config install-zsh-config install-tmux-config

install-all: install install-emacs-config install-alacritty-config

install-neovim-config:
	@echo "Installing neovim configuration!"
	@-mkdir ~/.config/nvim
	@cp nvim/* ~/.config/nvim
	@echo "Installed neovim configuration!"

install-zsh-config:
	@echo "Installing zsh configuration!"
	@cp zsh/.zshrc ~/.zshrc
	@echo "Installed zsh configuration!"

install-tmux-config:
	@echo "Installing tmux configuration!"
	@cp tmux/.tmux.conf ~/.tmux.conf
	@echo "Installed tmux configuration!"

install-alacritty-config: install-nerdfont-proto
	@echo "Installing alacritty configuration!"
	@-mkdir ~/.config/alacritty
	@cp alacritty/alacritty.toml ~/.config/alacritty
	@echo "Installed alacritty configuration!"

install-emacs-config:
	@echo "Installing emacs configuration!"
	@-mkdir ~/.config/emacs
	@cp emacs/init.el ~/.config/emacs
	@echo "Installed emacs configuration!"

install-nerdfont-proto:
	@echo "Installing 0xProto Nerdfont!"
	@-mkdir ~/.local/share/fonts
	@unzip -n 0xProto.zip -d ~/.local/share/fonts
	@fc-cache -fv
	@echo "Successfully Install 0xProto Nerdfont!"


