-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Performance optimizations
vim.opt.synmaxcol = 200
vim.opt.redrawtime = 10000
vim.opt.lazyredraw = true
vim.opt.cursorline = false
vim.opt.updatetime = 100
vim.opt.regexpengine = 1
vim.opt.termguicolors = true

-- Native syntax highlighting
vim.opt.syntax = "on"
vim.cmd("filetype plugin indent on")

-- Floating window borders
vim.o.winborder = "rounded"

-- Leader key
vim.g.mapleader = " "

-- Load options
require("options")

-- Netrw (native file explorer) configuration
vim.g.netrw_banner = 0           -- Disable banner
vim.g.netrw_liststyle = 1        -- Long list (shows permissions, size, date)
vim.g.netrw_browse_split = 0     -- Open in same window
vim.g.netrw_winsize = 25         -- Window size when split
vim.g.netrw_keepdir = 0          -- Keep current directory synced
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_sizestyle = "H"      -- Human-readable file sizes (K, M, G)

-- Netrw keybindings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    local opts = { buffer = true, silent = true }
    -- Navigation
    vim.keymap.set('n', 'h', '-', opts)          -- Go up directory
    vim.keymap.set('n', 'l', '<CR>', opts)       -- Open file/directory
    vim.keymap.set('n', '.', 'gh', opts)         -- Toggle hidden files
    vim.keymap.set('n', 'q', ':bd<CR>', opts)    -- Close netrw
    -- File operations
    vim.keymap.set('n', 'a', '%', opts)          -- Create new file
    vim.keymap.set('n', 'r', 'R', opts)          -- Rename file
    vim.keymap.set('n', 'd', 'D', opts)          -- Delete file
    vim.keymap.set('n', 'c', 'mc', opts)         -- Copy file
    vim.keymap.set('n', 'x', 'mx', opts)         -- Move file
  end,
})

-- Global keymaps for opening netrw
vim.keymap.set('n', '-', ':Explore<CR>', { desc = 'Open parent directory', silent = true })
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { desc = 'Open file explorer', silent = true })
vim.keymap.set('n', '<leader>E', ':Lexplore<CR>', { desc = 'Open file explorer (side panel)', silent = true })

-- Note: Keratoconus accessibility highlights now handled in colorscheme.lua
-- This ensures warm colors are used instead of harsh black/white

-- Large file handling
vim.g.LargeFile = 1024 * 1024 * 10  -- 10MB threshold
vim.api.nvim_create_augroup("LargeFile", { clear = true })
vim.api.nvim_create_autocmd("BufReadPre", {
  group = "LargeFile",
  callback = function()
    local size = vim.fn.getfsize(vim.fn.expand("<afile>"))
    if size > vim.g.LargeFile or size == -2 then
      vim.bo.swapfile = false
      vim.bo.undolevels = -1
      vim.opt_local.synmaxcol = 100
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.cursorline = false
      print("Large file mode enabled")
    end
  end,
})

-- Language-specific syntax sync optimizations
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.synmaxcol = 120
    vim.cmd("syntax sync minlines=30 maxlines=100")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"c", "cpp"},
  callback = function()
    vim.cmd("syntax sync ccomment maxlines=100")
    vim.opt_local.synmaxcol = 200
  end,
})

-- LSP floating window borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "rounded" }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = "rounded" }
)

-- Diagnostic floating windows
vim.diagnostic.config({
  float = { border = "rounded" },
})

-- Load plugins
require("lazy").setup("plugins", {
 dev = {
     path = "/Users/adriannajera/nvim-plugins",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
