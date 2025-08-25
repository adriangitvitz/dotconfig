return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- opts = function()
    --     return {
    --         max_file_length = vim.g.big_file.lines,
    --         -- signs = {
    --         --     add = { text = get_icon("GitSign") },
    --         --     change = { text = get_icon("GitSign") },
    --         --     delete = { text = get_icon("GitSign") },
    --         --     topdelete = { text = get_icon("GitSign") },
    --         --     changedelete = { text = get_icon("GitSign") },
    --         --     untracked = { text = get_icon("GitSign") },
    --         -- },
    --     }
    -- end,
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            current_line_blame = false,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                -- Navigation
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end)

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end)

                -- Actions
                map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Gitsigns Stage Hunk" })
                map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Gitsigns Reset Hunk" })
                map({ "n", "v" }, "<leader>gs", ":Gitsigns show master<CR>", { desc = "Gitsigns Show Master" })
                map({ "n", "v" }, "<leader>gq", ":Gitsigns setqflist<CR>", { desc = "Gitsigns Set loc list" })
                map({ "n", "v" }, "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>",
                    { desc = "Gitsigns Toggle Line Blame" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "Gitsign Stage buffer" })
                map("n", "<leader>ha", gs.stage_hunk, { desc = "Gitsign Stage hunk" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Gitsigns Undo stage hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Gitsigns Reset buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns Preview hunk" })
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = true })
                end, { desc = "Gitsigns Blame Full line" })
                -- map('n', '<leader>tb', gs.toggle_current_line_blame)
                map("n", "<leader>tb", gs.blame_line, { desc = "Gitsigns Blame line" })
                map("n", "<leader>hd", gs.diffthis, { desc = "Gitsigns Diff this" })
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end, { desc = "Gitsigns diffthis" })
                map("n", "<leader>td", gs.toggle_deleted, { desc = "Gitsigns Toggle deleted" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns Select Hunk" })
            end,
        })
    end,
}
