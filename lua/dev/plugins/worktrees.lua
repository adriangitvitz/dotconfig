return {
    "git-worktree.nvim",
    as = "git-worktree.nvim",
    dev = true,
    config = function()
        local update_on_worktree_change = function(op, metadata)
            vim.api.nvim_command("BufferLineGroupClose ungrouped")
            vim.api.nvim_command("SessionRestore")
        end
        require("git-worktree").setup({
            clear_jumps_on_change = false, -- this is handled by auto-session
            update_on_worktree_change = update_on_worktree_change,
        })
    end,
}
