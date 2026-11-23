-- Typescript / Javascript config
local npm_path = vim.fn.system("npm root -g")
local tsserver_path = npm_path .. "typescript/lib/"
vim.lsp.config("ts_ls", {
    cmd = {
        "typescript-language-server", 
	"--stdio",
    },
    filetypes = {
        "javascript", 
        "typescript",
    },
    root_markers = {
        "tsconfig.json",
        "jsconfig.json",
        "package.json"
    },
    init_options = {
        tsserver = {
            path = tsserver_path,
        },
    },
})
vim.lsp.enable("ts_ls")

-- Clangd config
vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders=1",
    },
    filetypes = {
	"c", 
	"cpp", 
	"objc", 
	"objcpp",
    },
    root_markers = {
        ".clangd",
        "compile_commands.json",
        ".git",
    },
})
vim.lsp.enable("clangd")


-- Overall popup triggering and config
vim.opt.completeopt = { "menuone", "noselect", "popup", "fuzzy" }
vim.opt.shortmess:append("c")
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("NativeLspCompletion",
        { clear = true }), callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or not client:supports_method("textDocument/completion") then
            return
        end

        -- Enable builtin completion for trigger chars like '.' and '->'
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

        -- Also enable completion when typing regular chars
        vim.api.nvim_create_autocmd("InsertCharPre", {
            buffer = args.buf,
            callback = function()
                if vim.fn.pumvisible() == 0 and vim.v.char:match("[%w_]") then
                    vim.schedule(function()
                        vim.lsp.completion.get()
                    end)
                end
            end,
        })
    end,
})
vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 1 then
        local info = vim.fn.complete_info({ "selected" })
        if info.selected == -1 then
            return "<C-n><C-y>"
        end
        return "<C-y>"
    end
    return "<CR>"
end, {
    expr = true,
    desc = "Configure <CR> to confirm completion when pum is visible",
})
vim.keymap.set("i", "<Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, {
    expr = true,
    desc = "Configure <Tab> to cycle forward completion selection when pum is visible",
})
vim.keymap.set("i", "<S-Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, {
    expr = true,
    desc = "Configure <S-Tab> to cycle backward completion selection when pum is visible",
})
