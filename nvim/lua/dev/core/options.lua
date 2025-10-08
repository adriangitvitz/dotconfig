local opt = vim.opt
vim.g.mapleader = " "

-- Core editor settings
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.cursorline = true
opt.backspace = "indent,eol,start"
opt.nu = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.hlsearch = true  -- Enable search highlighting to prevent flickering
opt.incsearch = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.undodir = os.getenv("HOME") .. "/.config/undodir"
opt.laststatus = 3
opt.fillchars = { eob = " " }
opt.guicursor = 'n-v-c:block'
opt.fileencoding = "utf-8"
opt.cmdheight = 1
opt.showmode = false

-- Ghostty-specific optimizations
opt.title = true
opt.titlestring = "nvim: %t"
opt.mouse = "a"
opt.mousemodel = "extend"
opt.ttimeoutlen = 0  -- Faster key sequence timeout
opt.updatetime = 250 -- Reasonable CursorHold events (was too fast at 100)
opt.lazyredraw = false    -- Ghostty is fast enough
opt.ttyfast = true        -- We have a fast terminal
opt.regexpengine = 0      -- Automatic engine selection
opt.redrawtime = 10000    -- Increase redraw timeout for complex patterns

-- Better scrolling in Ghostty
opt.scroll = 10
opt.sidescrolloff = 8

-- Better note-taking support
opt.conceallevel = 2  -- Better for markdown/org
opt.concealcursor = "nc" -- Hide conceals in normal/command mode
opt.pumheight = 10 -- Popup menu height
opt.splitkeep = "screen" -- Keep screen steady when splitting
opt.virtualedit = "block" -- Better visual block mode
opt.winminwidth = 5 -- Minimum window width
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- Clipboard configuration - environment aware
-- gLinux: empty (rely on tmux-yank plugin to avoid netrw lag)
-- macOS: use system clipboard
if os.getenv("GOOGLE_INTERNAL") or vim.fn.hostname():match("glinux") then
    opt.clipboard = ""  -- Let tmux handle clipboard
elseif vim.fn.has("macunix") == 1 then
    opt.clipboard = "unnamed,unnamedplus"
else
    opt.clipboard:append("unnamedplus")
end

-- Search settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shell = "/bin/zsh"
vim.o.background = "dark"

-- Session settings
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Disable problematic keys
vim.api.nvim_set_keymap('n', 'Q', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'q', '<Nop>', { noremap = true, silent = true })

local sign = vim.fn.sign_define
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
sign('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
