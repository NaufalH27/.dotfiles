-- unbind 
vim.keymap.set({ "n", "v", "i" }, "<S-Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<S-Up>", "<Nop>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Esc>", ":qall!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "q", ":qall!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Space>", ":qall!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "i", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "a", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "o", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "I", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "A", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "O", "<Nop>", { noremap = true })

vim.api.nvim_set_keymap("n", "<BS>", "<Nop>", { noremap = true })

vim.api.nvim_set_keymap("n", "y", '"+y', { noremap = true })
vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true })

vim.api.nvim_set_keymap("n", "d", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "x", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("v", "d", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("v", "x", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "D", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "X", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.opt.paste = false
vim.opt.mouse = ""
vim.api.nvim_set_keymap("n", "p", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "P", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "P", "<Nop>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-r>+", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-r>+", "<Nop>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<S-Insert>", "<Nop>", { noremap = true, silent = true })


