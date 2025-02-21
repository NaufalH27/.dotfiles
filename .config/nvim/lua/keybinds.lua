vim.g.mapleader = " "
-- unbind 
vim.keymap.set({ "n", "v", "i" }, "<S-Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<S-Up>", "<Nop>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<C-/>", ":noh<CR>", { noremap = true, silent = true })
vim.keymap.set({"n", "v", "i"}, "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set({"n", "v", "i"}, "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, buffer = bufnr })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, buffer = bufnr })

vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, buffer = bufnr })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, buffer = bufnr })

vim.api.nvim_create_autocmd("CmdwinEnter", {
    pattern = "*",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":q<CR>", { noremap = true, silent = true })
    end
})

vim.keymap.set("n", "<leader>wf", function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config and config.zindex then  -- Detect floating windows
            vim.api.nvim_set_current_win(win)
            break
        end
    end
end, { desc = "Focus Hover Window" })
vim.keymap.set("n", "<Esc>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
      return
    end
  end
end, { desc = "Close floating window on Esc" })



vim.keymap.set("n", "<leader>wc", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = "Close floating window" })

vim.keymap.set("n", "<leader>fh", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end, { desc = "Focus floating window" })


vim.keymap.set("n", "<<", "v<gv", { noremap = true, silent = true })
vim.keymap.set("n", ">>", "v>gv", { noremap = true, silent = true })

