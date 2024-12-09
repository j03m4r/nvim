local lsp_zero = require("lsp-zero")

vim.opt.signcolumn = "yes"

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  "force",
  lspconfig_defaults.capabilities,
  require("cmp_nvim_lsp").default_capabilities()
)

lsp_zero.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "ts_ls", "lua_ls", "ember", "cssls", "tailwindcss", "html", "glint" },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
        ts_ls = function()
            require("lspconfig").ts_ls.setup({
                capabilities = lsp_capabilities,
                filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
            })
        end,
        html = function()
            require("lspconfig").html.setup({
                capabilities = lsp_capabilities,
                filetypes = { "handlebars", "typescriptreact", "html" },
            })
        end,
        tailwindcss = function()
            require("lspconfig").tailwindcss.setup({
                capabilities = lsp_capabilities,
                filetypes = { "handlebars", "typescriptreact", "html" },
            })
        end,
        cssls = function()
            require("lspconfig").cssls.setup({
                capabilities = lsp_capabilities,
                filetypes = { "css" },
            })
        end,
        ember = function()
            require("lspconfig").ember.setup({
                capabilities = lsp_capabilities,
                filetypes = { "handlebars" }, -- Restrict to Handlebars
            })
        end,
        glint = function()
            require("lspconfig").glint.setup({
                capabilities = lsp_capabilities,
                filetypes = { "handlebars" }, -- Restrict to Handlebars
            })
        end,
        lua_ls = function()
            require("lspconfig").lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT"
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end,
    }
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "handlebars",
--     callback = function()
--         -- Attach html LSP
--         require("lspconfig")["html"].setup({
--             filetypes = {"handlebars"}
--         })
--
--         -- Attach css LSP
--         require("lspconfig")["tailwindcss"].setup({
--             filetypes = {"handlebars"}
--         })
--
--         -- Attach ember LSP
--         require("lspconfig")["ember"].setup({
--             filetypes = {"handlebars"}
--         })
--
--         require("lspconfig")["glint"].setup({
--             filetypes = {"handlebars"}
--         })
--     end,
-- })

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer",  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format({ details = false }),
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    preselect = "item",
    completion = {
        completeopt = "menu,menuone,noinsert"
    },
})

vim.keymap.set("n", "<leader>lf", "<Cmd>:LspZeroFormat<CR>")
