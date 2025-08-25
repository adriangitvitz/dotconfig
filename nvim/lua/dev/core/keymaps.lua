local keymap = vim.keymap

keymap.set("n", "<leader>s", function()
    vim.cmd("silent! write")
end, { desc = "Save" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })

vim.api.nvim_set_keymap('n', 'Q', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dio", ":diffoff<CR>", { noremap = true, desc = "Diff off" })

vim.keymap.set('n', '<leader>R', ':make<CR>:copen<CR>', { silent = true })

vim.keymap.set('n', '<leader>Y', '<cmd>Yazi<CR>', { desc = "Open yazi" })

-- function _G.set_terminal_keymaps()
--     local opts = { buffer = 0 }
--     vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
-- end

-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
