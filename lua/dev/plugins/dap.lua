return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "nvim-telescope/telescope-dap.nvim"
        },
        config = function()
            local dap = require "dap"
            local ui = require "dapui"
            local vscode = require('dap.ext.vscode')

            require("dapui").setup()
            require("dap-go").setup({
                delve = {
                    port = "38697",
                },
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                        connect = {
                            host = "127.0.0.1",
                            port = "38697",
                        },
                    },
                },
            })
            require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })

            require("nvim-dap-virtual-text").setup {
                display_callback = function(variable)
                    local name = string.lower(variable.name)
                    local value = string.lower(variable.value)
                    if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
                        return "*****"
                    end

                    if #variable.value > 15 then
                        return " " .. string.sub(variable.value, 1, 15) .. "... "
                    end

                    return " " .. variable.value
                end,
            }

            dap.set_log_level("TRACE")

            vscode.load_launchjs(nil, { go = { "go" }, cppdbg = { "c", "cpp" } })

            vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>", { desc = "DAP Toggle Breakpoint" })
            vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>", { desc = "DAP Continue" })
            vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>", { desc = "DAP Terminate" })
            vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>", { desc = "DAP Step Over" })
            vim.keymap.set("n", "<Leader>dO", ":DapStepInto<CR>", { desc = "DAP Step Into" })
            vim.keymap.set("n", "<Leader>dT", ":DapStepOut<CR>", { desc = "DAP Step Out" })
            vim.keymap.set("n", "<Leader>ds", ":lua require('dap-go').debug_test()<CR>", { desc = "DAP GO" })
            vim.keymap.set("n", "<Leader>dr", ":lua require('dapui').open({reset = true})<CR>", { desc = "DAP UI Open" })

            vim.keymap.set("n", "<space>db", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
            vim.keymap.set("n", "<F3>", dap.step_over)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.step_back)
            vim.keymap.set("n", "<F13>", dap.restart)


            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
