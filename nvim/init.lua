-- ---------------
-- Basic Config --
-- ---------------
vim.g.mapleader = ';';
vim.g.maplocalleader = '\\';
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Gotta love tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false -- Color Scheme

-- Keymaps
local mapit = function(mode, key, callee)
	vim.api.nvim_set_keymap(
	mode, key, callee, 
	{noremap = true, silent = true})
end
mapit("n", "<s-j>", "<c-w>j");
mapit("n", "<s-k>", "<c-w>k");
mapit("n", "<s-h>", "<c-w>h");
mapit("n", "<s-l>", "<c-w>l");


-- -----
-- Plugins and stuff
-- -----
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  print("Insalling lazy nvim")
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- actual plugin list
require("lazy").setup({
	spec = {
		{"ellisonleao/gruvbox.nvim"},
		{"sainnhe/gruvbox-material"},
		{"nvim-telescope/telescope.nvim"},
		{"akinsho/toggleterm.nvim", config = true},
		{"neoclide/coc.nvim", branch="release"},
		{"nvim-lualine/lualine.nvim",
			dependencies = {"nvim-tree/nvim-web-devicons"},
		},
	},
	install = { colorscheme = { "gruvbox" } },
	checker = { enabled = true },
})

-- plugin config
mapit('n', '<C-t>', ':ToggleTerm direction=float<cr>')
teles = require("telescope.builtin")
mapit('n', '<C-o>', ':lua teles.find_files()<cr>')
vim.cmd [[colo gruvbox-material]]
require("lualine").setup{
	options = { theme = 'gruvbox' }
}
