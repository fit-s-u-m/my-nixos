local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Load VSCode-style snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Helper function to check if there are words before the cursor
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Icons for completion kinds
local cmp_kinds = {
    Text = "󰉿",            -- Generic text
    Method = "󰆧",          -- Method
    Function = "󰊕",        -- Function
    Constructor = "",      -- Constructor
    Field = "",           -- Object field
    Variable = "󰀫",        -- Variable
    Class = "󰌗",          -- Class
    Interface = "",       -- Interface
    Module = "󰏗",         -- Module or namespace
    Property = "",        -- Object property
    Unit = "",           -- Unit
    Value = "󰎠",          -- Value or literal
    Enum = "",           -- Enum
    Keyword = "󰌋",        -- Language keyword
    Snippet = "",        -- Snippet
    Color = "󰏘",          -- Color picker or swatch
    File = "󰈙",           -- File
    Reference = "󰈇",      -- Reference or pointer
    Folder = "󰉋",         -- Folder
    EnumMember = "",     -- Enum member
    Constant = "󰏿",       -- Constant or literal
    Struct = "󰙅",         -- Struct or record
    Event = "",          -- Event
    Operator = "󰆕",       -- Operator
    TypeParameter = "󰉺"   -- Type parameter
}


-- Main configuration
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        },
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", option = {
            get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
            end
        }},
        { name = "path" },
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = cmp_kinds[vim_item.kind] or ""
            vim_item.menu = ({
                buffer = "🅱",
                nvim_lsp = "🅻",
                luasnip = "㊊",
                path = "🛠",
            })[entry.source.name] or ""
            return vim_item
        end,
    },
})

