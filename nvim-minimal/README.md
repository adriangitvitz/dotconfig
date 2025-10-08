# Neovim Configuration Keybindings

## File Explorer (Netrw)

### Opening Explorer
- `-` - Open parent directory explorer
- `<leader>e` - Open file explorer in current window
- `<leader>E` - Open file explorer in side panel (toggle)

### Navigation (inside netrw)
- `h` - Go up to parent directory
- `l` - Open file or enter directory
- `.` - Toggle hidden files visibility
- `q` - Close explorer window

### File Operations (inside netrw)
- `a` - Create new file
- `r` - Rename file/directory
- `d` - Delete file/directory
- `c` - Copy marked file(s)
- `x` - Move/cut marked file(s)

### Marking Files (inside netrw)
- `mf` - Mark file
- `mu` - Unmark file
- `mt` - Toggle marked files

## LSP Keybindings

- `gd` - Go to definition
- `gr` - Show references
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>f` - Format buffer
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

## Telescope

- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - Find buffers
- `<leader>fr` - Recent files
- `<leader>ft` - Find todo comments
- `<leader>fT` - Find TODO/FIX/FIXME only

### Telescope Navigation (inside picker)
- `<C-k>` - Move to previous result
- `<C-j>` - Move to next result
- `<Esc>` or `q` - Close telescope
- `<CR>` - Open selected file

## Completion (blink.cmp)

- `<C-space>` - Trigger completion menu
- `<C-y>` - Accept completion
- `<C-e>` - Hide completion menu
- `<Tab>` - Select next completion
- `<S-Tab>` - Select previous completion

## Todo Comments

- `]t` - Jump to next todo comment
- `[t` - Jump to previous todo comment
- `<leader>ft` - Find all todo comments
- `<leader>fT` - Find TODO/FIX/FIXME only

### Supported Keywords
- `TODO:` - General tasks
- `FIX:` / `FIXME:` / `BUG:` - Things to fix
- `HACK:` / `WARN:` / `WARNING:` - Warnings
- `NOTE:` / `INFO:` - Notes
- `PERF:` / `OPTIMIZE:` - Performance improvements
- `TEST:` - Test-related comments

## Git (Gitsigns)

- `]h` - Next git hunk
- `[h` - Previous git hunk
- `<leader>gp` - Preview git hunk
- `<leader>gb` - Git blame line
- `<leader>gr` - Reset git hunk
- `<leader>gR` - Reset entire buffer
- `<leader>gs` - Stage git hunk
- `<leader>gu` - Undo stage hunk

## General

- `<Space>` - Leader key
