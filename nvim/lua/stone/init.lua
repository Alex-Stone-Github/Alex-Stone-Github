-- My lsp configurations
require("stone.lsp")

-- Basic settings
vim.opt.number = true;
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.cmd.colorscheme("retrobox")

-- Plugin loading
vim.pack.add({
    -- Fuzzy file search
    "https://github.com/ibhagwan/fzf-lua",

    -- Oil file manager(dired)
    "https://github.com/stevearc/oil.nvim",

    -- Git integration
    "https://github.com/nvim-mini/mini-git",

    -- Greeter application for MRU files
    "https://github.com/goolord/alpha-nvim",
    "https://github.com/nvim-mini/mini.icons", -- icons
})
-- Plugin configuration
require("mini.git").setup()

local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")
alpha.setup(dashboard.config)

require("oil").setup()

local fzf = require("fzf-lua")
fzf.setup({
    "telescope",
    winopts = {
        height = 0.85,
        width = 0.85,
        row = 0.50,
        col = 0.50,
        preview = {
            layout = "horizontal",
            horizontal = "right:55%",
        }
    },
})

-- Alex Stone custom keymaps(excluding lsp navigation) 
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>ff", fzf.files, {
    desc = "Find local files",
})

-- Notify the user the config loaded successfully
vim.notify("Alex Stone Config Successfully Loaded!")
