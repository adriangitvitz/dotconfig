return {
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        default_file_explorer = true,

        -- Id is automatically added at the beginning, and name at the end
        -- Simplified columns to avoid cursor detection issues
        columns = {
          "icon",  -- File type icon
          "size", -- File size only
        },

        -- Buffer-local options to use for oil buffers
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },

        -- Window-local options to use for oil buffers
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 2,
          concealcursor = "nc",
        },

        -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
        delete_to_trash = true,

        -- Skip the confirmation popup for simple operations (:help oil.skip-confirm)
        skip_confirm_for_simple_edits = false,

        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        prompt_save_on_select_new_entry = true,

        -- Oil will automatically delete hidden buffers after this delay
        cleanup_delay_ms = 2000,

        -- Constrain the cursor to the editable parts of the oil buffer
        -- Use "editable" instead of "name" for better cursor detection
        constrain_cursor = "editable",

        -- Set to true to watch the filesystem for changes and reload oil
        experimental_watch_for_changes = false,

        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "..." })
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = {
            callback = function()
              local oil = require("oil")
              local entry = oil.get_entry_on_line(0, vim.api.nvim_win_get_cursor(0)[1])
              if entry then
                oil.select(nil, function(err)
                  if err then
                    print("Oil selection error: " .. err)
                  end
                end)
              else
                print("No entry found under cursor. Use <leader>d to debug.")
              end
            end,
            desc = "Select entry with error handling"
          },
          ["<leader>d"] = {
            callback = function()
              local oil = require("oil")
              local line = vim.api.nvim_get_current_line()
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local entry = oil.get_entry_on_line(0, vim.api.nvim_win_get_cursor(0)[1])

              print("Debug - Line: '" .. line .. "', Col: " .. col)
              print("Debug - Filetype: " .. vim.bo.filetype)
              if entry then
                print("Debug - Entry found: " .. entry.name .. " (type: " .. entry.type .. ")")
              else
                print("Debug - No entry found under cursor")
              end

              -- Try to get cursor position relative to entry
              local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
              local entries = oil.get_current_dir_entries()
              if entries and entries[cursor_line] then
                print("Debug - Entry by line: " .. entries[cursor_line].name)
              end
            end,
            desc = "Debug oil cursor position and entry detection"
          },
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
          ["<leader>o"] = {
            callback = function()
              -- Alternative entry selection method
              local oil = require("oil")
              local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
              local line_text = vim.api.nvim_buf_get_lines(0, cursor_line - 1, cursor_line, false)[1]

              if line_text then
                -- Extract filename from the line (assumes it's at the end)
                local filename = line_text:match("([^%s]+)%s*$")
                if filename and filename ~= "" then
                  local current_dir = oil.get_current_dir()
                  if current_dir then
                    local full_path = current_dir .. filename
                    vim.cmd("edit " .. vim.fn.fnameescape(full_path))
                  end
                else
                  print("Could not extract filename from line: " .. line_text)
                end
              end
            end,
            desc = "Alternative file open method"
          },
        },

        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,

        view_options = {
          -- Show files and directories that start with "."
          show_hidden = false,

          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,

          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr)
            return false
          end,

          -- Sort file names in a more intuitive order for humans. Is less performant,
          -- so you can set to false if you prefer raw alphabetical order
          natural_order = true,

          sort = {
            -- sort order can be "asc" or "desc"
            -- see :help oil-columns to see which columns are sortable
            { "type", "asc" },
            { "name", "asc" },
          },
        },

        -- Configuration for the floating window in oil.open_float
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },

        -- Configuration for the actions floating preview window
        preview = {
          -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_width and max_width can be a single value or a list of mixed integer/float types.
          max_width = 0.9,
          -- min_width = {40, 0.4} means "at least 40 columns, or at least 40% of total"
          min_width = {40, 0.4},
          -- optionally define an integer/float for the exact width of the preview window
          width = nil,
          -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a single value or a list of mixed integer/float types.
          max_height = 0.9,
          min_height = {5, 0.1},
          -- optionally define an integer/float for the exact height of the preview window
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },

        -- Configuration for the floating progress window
        progress = {
          max_width = 0.9,
          min_width = {40, 0.4},
          width = nil,
          max_height = {10, 0.9},
          min_height = {5, 0.1},
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },

        -- Configuration for the floating SSH window
        ssh = {
          border = "rounded",
        },
      })

      -- Set up keymaps for opening oil
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })
      vim.keymap.set("n", "<leader>E", function()
        require("oil").open_float()
      end, { desc = "Open floating file explorer" })
    end,
  }
}