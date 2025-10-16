-- -------------------------
-- PART A: Plugins and stuff
-- -------------------------
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
		{"ellisonleao/gruvbox.nvim"},                   -- Looks
		{"sainnhe/gruvbox-material"},                   -- Looks
		{"nvim-lualine/lualine.nvim",                   -- Looks: Status Bar

		{"nvim-telescope/telescope.nvim"},              -- Fuzzy Find
		{"tpope/vim-fugitive"},                         -- Git Integration
		{"neoclide/coc.nvim", branch="release"},        -- Autocomplete LSP Protocol Impl
			dependencies = {"nvim-tree/nvim-web-devicons"},
		},
		{"nvim-tree/nvim-tree.lua",                     -- File Explorer
			dependencies = {"nvim-tree/nvim-web-devicons"},
		},
	},
	install = { colorscheme = { "gruvbox-material" } },
	checker = { enabled = true },
})

-- ---------------------
-- PART B: Configuration 
-- ---------------------
-- Core Settings
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
mapit("n", "<s-j>", "<c-w>j");                     -- Pane Navigation Shift + "hjkl"
mapit("n", "<s-k>", "<c-w>k");
mapit("n", "<s-h>", "<c-w>h");
mapit("n", "<s-l>", "<c-w>l");
teles = require("telescope.builtin")
mapit('n', '<C-o>', ':lua teles.find_files()<cr>') -- Open a file  "Ctr + O"
mapit('n', '<C-p>', ':NvimTreeToggle<cr>')
-- reserve c-m for drawing

--- ---------------------------------------------
--- PART C: Special Plugin Stuff & Initialization
--- ---------------------------------------------
-- colorscheme
vim.cmd [[colo gruvbox-material]]
-- status bar
require("lualine").setup{
	options = { theme = 'gruvbox' }
}
-- Coc Complete, special because of the lua evaluation
vim.api.nvim_set_keymap('i', '<cr>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<cr>"', {silent = true, expr = true})
-- file explorer
require("nvim-tree").setup()

-- Documentation Lookup
vim.keymap.set('n', '<C-I>', function() 
	vim.fn.CocActionAsync("doHover")
end, {silent = true})



