-- General options
local opt = vim.opt

-- Clipboard - conditional based on environment
-- On gLinux: rely on tmux clipboard integration, avoid unnamedplus (prevents netrw lag)
-- On macOS: use system clipboard directly
if os.getenv("GOOGLE_INTERNAL") or vim.fn.hostname():match("glinux") then
    opt.clipboard = ""  -- Empty, let tmux handle clipboard via yank plugin
else
    opt.clipboard = "unnamedplus"  -- macOS/normal systems
end

-- Line numbers
opt.number = true
opt.relativenumber = true

-- UI improvements
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true

-- Split behavior
opt.splitbelow = true
opt.splitright = true

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Mouse support
opt.mouse = "a"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Other useful options
opt.timeoutlen = 500
opt.hidden = true
opt.cmdheight = 1
opt.showmode = false
