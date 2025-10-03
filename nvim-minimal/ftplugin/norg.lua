vim.keymap.set("n", "<leader>N", "<Plug>(neorg.dirman.new-note)", { desc = "Neorg new note" })
vim.keymap.set("n", "<leader>tD", "<Plug>(neorg.qol.todo-items.todo.task-done)", { desc = "Neorg task done" })
vim.keymap.set("n", "<leader>tu", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)",
    { desc = "Neorg task cancel" })
vim.keymap.set("n", "<leader>tH", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)",
    { desc = "Neorg task on-hold" })
vim.keymap.set("n", "<leader>ti", "<Plug>(neorg.qol.todo-items.todo.task-important)",
    { desc = "Neorg task important" })
vim.keymap.set("n", "<leader>tp", "<Plug>(neorg.qol.todo-items.todo.task-pending)",
    { desc = "Neorg task pending" })
vim.keymap.set("n", "<leader>gT", "<Plug>(neorg.esupports.hop.hop-link)",
    { desc = "Neorg hop to link" })
