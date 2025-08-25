return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            -- "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
            { "nvim-neotest/neotest-python",   version = "*" }
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-golang"), -- Registration
                    require("neotest-python")
                },
            })
            vim.api.nvim_create_autocmd('filetype', {
                pattern = 'neotest-output',
                callback = function()
                    -- Open file under cursor in the widest window available.
                    vim.keymap.set('n', 'gF', function()
                        local current_word = vim.fn.expand("<cWORD>")
                        local tokens = vim.split(current_word, ":", { trimempty = true })
                        local win_ids = vim.api.nvim_list_wins()
                        local widest_win_id = -1;
                        local widest_win_width = -1;
                        for _, win_id in ipairs(win_ids) do
                            if (vim.api.nvim_win_get_config(win_id).zindex) then
                                -- Skip floating windows.
                                goto continue
                            end
                            local win_width = vim.api.nvim_win_get_width(win_id)
                            if (win_width > widest_win_width) then
                                widest_win_width = win_width
                                widest_win_id = win_id
                            end
                            ::continue::
                        end
                        vim.api.nvim_set_current_win(widest_win_id)
                        if (#tokens == 1) then
                            vim.cmd("e " .. tokens[1])
                        else
                            vim.cmd("e +" .. tokens[2] .. " " .. tokens[1])
                        end
                    end, { remap = true, buffer = true })
                end
            })
            vim.keymap.set("n", "<leader>tn", function() require("neotest").run.run() end, { desc = "Run Nearest Test" })
            vim.keymap.set("n", "<leader>tF", function() require("neotest").run.run(vim.fn.expand("%")) end,
                { desc = "Run File" })
            vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end,
                { desc = "Toggle Summary" })
            vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end,
                { desc = "Show Output" })
            vim.keymap.set("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,
                { desc = "Toggle Watch" })
        end,
        opts = function(_, opts)
            opts.adapters = opts.adapters or {}
            opts.adapters["neotest-golang"] = {
                dap_go_enabled = true,
                testify_enabled = true, -- experimental
            }
            opts.adapters["neotest-python"] = {
                dap = { justMyCode = false },
                runner = "pytest",
                python = ".venv/bin/python",
                is_test_file = function(file_path)
                    -- Check if it's a Python file first
                    if not vim.endswith(file_path, ".py") then
                        return false
                    end

                    -- Get the file name without directory path
                    local file_name = vim.fn.fnamemodify(file_path, ":t")

                    -- Check common test file patterns
                    if vim.startswith(file_name, "test_") then return true end
                    if vim.endswith(file_name:gsub("%.py$", ""), "_test") then return true end

                    -- Check if file is in a test directory
                    local normalized_path = file_path:gsub("\\", "/")
                    if normalized_path:match("/tests?/") then return true end

                    -- Check if file contains pytest-style tests
                    local content = vim.fn.readfile(file_path)
                    for _, line in ipairs(content) do
                        -- Match pytest test functions (def test_*)
                        if line:match("^%s*def%s+test_%w*") then return true end
                        -- Match pytest test classes (class Test*)
                        if line:match("^%s*class%s+Test%w*") then return true end
                    end

                    return false
                end
                -- pytest_discover_instances = true,
            }
        end
    },
}
