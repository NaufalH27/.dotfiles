return {
    {
      'saghen/blink.cmp',
      dependencies = 'rafamadriz/friendly-snippets',
      version = '*',
      ---@module 'blink.cmp'
      opts = {
        keymap = { preset = 'default' },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = 'mono'
        },
        signature = { enabled = true },
        completion = {
            list = {

            }
        },
      },
    },

-- nvim-cmp

---     {
--     "hrsh7th/nvim-cmp",
--     config = function()
--         local cmp = require("cmp")
--         local lspkind = require("cmp.types").lsp.CompletionItemKind
--         local capabilities = require("cmp_nvim_lsp").default_capabilities()
--         capabilities.textDocument.completion.completionItem.snippetSupport = false
--
--         -- Function to prioritize specific kinds
--         local function priority_comparator(entry1, entry2)
--             local kind_priority = {
--                 [lspkind.Keyword] = 1,
--                 [lspkind.Struct] = 2,
--                 [lspkind.Enum] = 3,
--                 [lspkind.Text] = 4,
--                 [lspkind.EnumMember] = 5,
--                 [lspkind.Interface] = 6,
--             }
--
--         end
--
--         cmp.setup({
--             mapping = cmp.mapping.preset.insert({
--                 ["<Tab>"] = cmp.mapping.select_next_item(),
--                 ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--                 ["<CR>"] = cmp.mapping.confirm({ select = true }),
--                 ["<C-Space>"] = cmp.mapping.complete(), 
--             }),
--             sources = cmp.config.sources({
--                 { 
--                     name = "nvim_lsp", 
--                     entry_filter = function(entry, ctx)
--                         local label = entry:get_insert_text()
--
--
--                         -- Ignore unwanted completions
--                         if label:match("~$") then
--                             return false
--                         end
--
--                         if kind == cmp.lsp.CompletionItemKind.Function then
--                             return false
--                         end
--
--                         if kind == cmp.lsp.CompletionItemKind.Constant then
--                             return false
--                         end
--
--                         return true
--                     end
--                 },
--                 { name = "buffer" }, 
--                 { name = "path" }, 
--             }),
--             sorting = {
--                 comparators = {
--                     cmp.config.compare.exact, 
--                     cmp.config.compare.kind,  
--                     cmp.config.compare.length, 
--                 }
--             }
--         })
--     end 
-- },
--     { "hrsh7th/cmp-nvim-lsp" },
--     { "hrsh7th/cmp-buffer" },
--     { "hrsh7th/cmp-path" },
}
