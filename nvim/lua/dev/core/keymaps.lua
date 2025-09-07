local keymap = vim.keymap

-- File operations
keymap.set("n", "<leader>s", function()
    vim.cmd("silent! write")
end, { desc = "Save" })
keymap.set("n", "<D-s>", "<cmd>write<cr>", { desc = "Save file (Cmd-S)" })
keymap.set("n", "<D-w>", "<cmd>bd<cr>", { desc = "Close buffer (Cmd-W)" })
keymap.set("n", "<D-t>", "<cmd>tabnew<cr>", { desc = "New tab (Cmd-T)" })

-- Line movement
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })

-- Buffer navigation (Ghostty-optimized)
keymap.set("n", "<M-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "<M-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close current split" })
keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Close window" })

-- Window resizing (Ghostty handles Alt combinations well)
keymap.set("n", "<M-j>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
keymap.set("n", "<M-k>", "<cmd>resize +2<cr>", { desc = "Increase height" })
keymap.set("n", "<M-,>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
keymap.set("n", "<M-.>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- Better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Terminal mode improvements for Ghostty
keymap.set("t", "<C-[>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("t", "<M-[>", "<C-\\><C-n>", { desc = "Exit terminal mode" })


-- Disable problematic keys
vim.api.nvim_set_keymap('n', 'Q', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dio", ":diffoff<CR>", { noremap = true, desc = "Diff off" })

vim.keymap.set('n', '<leader>R', ':make<CR>:copen<CR>', { silent = true })
vim.keymap.set('n', '<leader>Y', '<cmd>Yazi<CR>', { desc = "Open yazi" })

-- JSON formatting and manipulation
keymap.set("n", "<leader>jp", ":%!jq .<CR>", { desc = "Pretty format JSON" })
keymap.set("v", "<leader>jp", ":!jq .<CR>", { desc = "Pretty format JSON selection" })
keymap.set("n", "<leader>jc", ":%!jq -c .<CR>", { desc = "Compact JSON" })
keymap.set("n", "<leader>js", ":%!jq -S .<CR>", { desc = "Sort JSON keys" })
keymap.set("n", "<leader>jv", ":vsplit | enew | setfiletype json<CR>", { desc = "JSON in vertical split" })

