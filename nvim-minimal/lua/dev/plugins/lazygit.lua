return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        { "<D-g>", "<cmd>LazyGit<cr>", desc = "LazyGit (Cmd-G)" },
        { "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Current File" },
    },
    config = function()
        -- Ghostty handles floating windows beautifully
        vim.g.lazygit_floating_window_scaling_factor = 0.95
        vim.g.lazygit_floating_window_use_plenary = 0
        
        -- Better integration with Ghostty's terminal
        vim.g.lazygit_use_neovim_remote = 1
        
        -- Configure the floating window
        vim.g.lazygit_floating_window_winblend = 0
        vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'}
        vim.g.lazygit_floating_window_use_plenary = 0
    end,
}