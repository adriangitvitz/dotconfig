return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 500, -- Delay before showing which-key (ms)
      plugins = {
        marks = true,       -- Show marks
        registers = true,   -- Show registers
        spelling = {
          enabled = true,   -- Show spelling suggestions
          suggestions = 20, -- Number of suggestions
        },
        presets = {
          operators = true,    -- Show operator-pending mappings
          motions = true,      -- Show motion mappings
          text_objects = true, -- Show text object mappings
          windows = true,      -- Show window mappings
          nav = true,          -- Show navigation mappings
          z = true,            -- Show z mappings
          g = true,            -- Show g mappings
        },
      },
      win = {
        border = "rounded",   -- Rounded borders to match theme
        padding = { 1, 2 },   -- Window padding
      },
      layout = {
        height = { min = 4, max = 25 }, -- Height range
        width = { min = 20, max = 50 }, -- Width range
        spacing = 3,          -- Spacing between columns
        align = "left",       -- Align keys to the left
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Define key groups and mappings
      wk.add({
        -- File operations
        { "<leader>f", group = "Find" },
        { "<leader>ff", desc = "Find Files" },
        { "<leader>fg", desc = "Live Grep" },
        { "<leader>fb", desc = "Find Buffers" },
        { "<leader>fr", desc = "Recent Files" },
        { "<leader>ft", desc = "Find Todo Comments" },
        { "<leader>fT", desc = "Find Todo/Fix/Fixme" },

        -- File explorer (Netrw)
        { "<leader>e", desc = "Open File Explorer" },
        { "<leader>E", desc = "Open File Explorer (Side Panel)" },
        { "-", desc = "Open Parent Directory" },

        -- LSP operations
        { "<leader>c", group = "Code" },
        { "<leader>ca", desc = "Code Action" },
        { "<leader>cr", desc = "Rename Symbol" },
        { "<leader>cf", desc = "Format Code" },

        -- Diagnostics
        { "<leader>d", group = "Diagnostics" },
        { "[d", desc = "Previous Diagnostic" },
        { "]d", desc = "Next Diagnostic" },
        { "[t", desc = "Previous Todo Comment" },
        { "]t", desc = "Next Todo Comment" },

        -- LSP navigation
        { "g", group = "Go to" },
        { "gd", desc = "Go to Definition" },
        { "gr", desc = "Go to References" },
        { "K", desc = "Hover Documentation" },

        -- Window operations
        { "<leader>w", group = "Windows" },
        { "<leader>wh", "<C-w>h", desc = "Go to Left Window" },
        { "<leader>wj", "<C-w>j", desc = "Go to Lower Window" },
        { "<leader>wk", "<C-w>k", desc = "Go to Upper Window" },
        { "<leader>wl", "<C-w>l", desc = "Go to Right Window" },
        { "<leader>ws", "<C-w>s", desc = "Split Window Horizontally" },
        { "<leader>wv", "<C-w>v", desc = "Split Window Vertically" },
        { "<leader>wc", "<C-w>c", desc = "Close Window" },
        { "<leader>wo", "<C-w>o", desc = "Close Other Windows" },

        -- Buffer operations
        { "<leader>b", group = "Buffers" },
        { "<leader>bd", ":bdelete<CR>", desc = "Delete Buffer" },
        { "<leader>bp", ":bprev<CR>", desc = "Previous Buffer" },

        -- Quit/Save operations
        { "<leader>q", group = "Quit/Save" },
        { "<leader>qq", ":qa<CR>", desc = "Quit All" },
        { "<leader>qw", ":wqa<CR>", desc = "Save and Quit All" },
        { "<leader>qf", ":q!<CR>", desc = "Force Quit" },

        -- Git operations
        { "<leader>g", group = "Git" },
        { "<leader>gp", desc = "Preview Git Hunk" },
        { "<leader>gb", desc = "Git Blame Line" },
        { "<leader>gr", desc = "Reset Git Hunk" },
        { "<leader>gR", desc = "Reset Git Buffer" },
        { "<leader>gs", desc = "Stage Git Hunk" },
        { "<leader>gu", desc = "Undo Stage Hunk" },
        { "]h", desc = "Next Git Hunk" },
        { "[h", desc = "Previous Git Hunk" },

        -- Toggle operations
        { "<leader>t", group = "Toggle" },
        { "<leader>tn", ":set relativenumber!<CR>", desc = "Toggle Relative Numbers" },
        { "<leader>tw", ":set wrap!<CR>", desc = "Toggle Word Wrap" },
        { "<leader>th", ":set hlsearch!<CR>", desc = "Toggle Highlight Search" },

        -- Search and replace
        { "<leader>s", group = "Search/Replace" },
        { "<leader>ss", ":%s/", desc = "Search and Replace" },
        { "<leader>sw", ":%s/<C-r><C-w>/", desc = "Replace Word Under Cursor" },

        -- Completion keymaps (for reference)
        { "<C-space>", desc = "Trigger Completion", mode = "i" },
        { "<C-y>", desc = "Accept Completion", mode = "i" },
        { "<C-e>", desc = "Close Completion", mode = "i" },
        { "<Tab>", desc = "Next Completion", mode = "i" },
        { "<S-Tab>", desc = "Previous Completion", mode = "i" },
      })
    end,
  }
}