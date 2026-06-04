-- -----
-- Plugins 
-- -----
vim.pack.add({
	{src = "https://github.com/ellisonleao/gruvbox.nvim"},
	{src = "https://github.com/sainnhe/gruvbox-material"},
	{src = "https://github.com/nvim-telescope/telescope.nvim"},
	{src = "https://github.com/nvim-lua/plenary.nvim"},
	{src = "https://github.com/neoclide/coc.nvim", branch="release"},
	{src = "https://github.com/nvim-lualine/lualine.nvim"},
	{src = "https://github.com/nvim-tree/nvim-web-devicons"}
})


-- ---------------
-- Basic Config --
-- ---------------
vim.g.mapleader = ";";
vim.g.maplocalleader = '\\';
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.colorcolumn = "80"

vim.o.termguicolors = true
vim.o.background = "dark"

-- plugin config
teles = require("telescope.builtin")
vim.cmd([[colo gruvbox]])
require("lualine").setup{
	options = { theme = "gruvbox" }
}

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
mapit("n", "<C-o>", ":lua teles.find_files()<cr>")
vim.api.nvim_set_keymap("i", "<cr>", "coc#pum#visible() ? coc#pum#confirm() : '<cr>'", {
	expr = true,
	noremap = true
});

