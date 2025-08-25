return {
    "mbbill/undotree",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open undo tree" })
        vim.keymap.set("n", "<leader>uf", vim.cmd.UndotreeFocus, { desc = "Undo tree focus" })
    end
}
