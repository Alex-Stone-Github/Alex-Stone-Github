-- What plugins are needed?
vim.pack.add({
	{src = "https://github.com/ellisonleao/gruvbox.nvim"},               -- Theme
	{src = "https://github.com/sainnhe/gruvbox-material"},               -- Theme
	{src = "https://github.com/nvim-lualine/lualine.nvim"},              -- Status Bar
	{src = "https://github.com/nvim-telescope/telescope.nvim"},          -- Fuzzy File Finder
	{src = "https://github.com/nvim-lua/plenary.nvim"},                  -- Telescope Dependency
	{src = "https://github.com/tpope/vim-fugitive"},                     -- Git
	{src = "https://github.com/neoclide/coc.nvim", version = "release"}, -- Completion
	{src = "https://github.com/nvim-tree/nvim-tree.lua"},                -- File Explorer
	{src = "https://github.com/nvim-tree/nvim-web-devicons"},            -- File Explorer Icons
})
-- What are my basic settings?
vim.g.mapleader = ';';
vim.g.maplocalleader = '\\';
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

require("lualine").setup{
	options = { theme = 'gruvbox' }
}
require("nvim-tree").setup()

vim.cmd[[colo gruvbox]]

-- What are my prefered keymaps?
local mapit = function(mode, key, callee)
	vim.api.nvim_set_keymap(
	mode, key, callee, 
	{noremap = true, silent = true})
end
mapit("n", "<s-j>", "<c-w>j");                     -- Pane Navigation "Shift + hjkl"
mapit("n", "<s-k>", "<c-w>k");
mapit("n", "<s-h>", "<c-w>h");
mapit("n", "<s-l>", "<c-w>l");

mapit('n', '<C-j>', ':new<cr>')                              -- Daily Scratchpad 
mapit('n', '<C-p>', ':new ~/.config/nvim/init.lua<cr>')      -- Daily Scratchpad 
mapit('n', '<C-m>', ':tab terminal<cr>')                     -- Daily Scratchpad 
mapit("n", "<C-o>",                                          -- File Finder "Ctr + O"
	":lua require('telescope.builtin').find_files()<cr>")
vim.api.nvim_set_keymap('i', '<cr>',                         -- Completion
	'coc#pum#visible() ? coc#pum#confirm() : "\\<cr>"', {silent = true, expr = true})
