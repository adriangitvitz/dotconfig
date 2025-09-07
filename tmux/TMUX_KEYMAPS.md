# Tmux Keymaps Reference

## Prefix Key
- **Prefix**: `Ctrl-s` (changed from default `Ctrl-b`)

## Session Management
- `Ctrl-s r` - Reload tmux configuration
- `Ctrl-s d` - Detach from session

## Window Management
- `Ctrl-s c` - Create new window (in current path)
- `Ctrl-s ,` - Rename current window
- `Ctrl-s &` - Kill current window
- `Ctrl-s X` - Kill current window (custom binding)
- `Tab` - Switch to last window
- `Shift-Tab` - Previous window
- `Alt-1` to `Alt-5` - Switch to window 1-5 directly

## Pane Management
- `Ctrl-s |` - Split pane horizontally (in current path)
- `Ctrl-s -` - Split pane vertically (in current path)
- `Ctrl-s x` - Kill current pane
- `Ctrl-s q` - Show pane numbers
- `Space` - Cycle through pane layouts

## Pane Navigation (Vim-Tmux Navigator)
- `Ctrl-h` - Navigate left (works with Vim splits)
- `Ctrl-j` - Navigate down (works with Vim splits)
- `Ctrl-k` - Navigate up (works with Vim splits)
- `Ctrl-l` - Navigate right (works with Vim splits)
- `Ctrl-\` - Navigate to last pane (works with Vim splits)

## Pane Resizing
- `Ctrl-s H` - Resize pane left (repeatable)
- `Ctrl-s J` - Resize pane down (repeatable)
- `Ctrl-s K` - Resize pane up (repeatable)
- `Ctrl-s L` - Resize pane right (repeatable)

## Copy Mode (Vi-style)
- `Ctrl-s [` - Enter copy mode
- `v` - Begin selection
- `Ctrl-v` - Toggle rectangle selection
- `y` - Copy selection to clipboard (macOS)
- `Ctrl-s p` - Paste from buffer
- `Ctrl-h/j/k/l` - Navigate in copy mode

## Plugin Keymaps

### Tmux-FZF
- `Ctrl-s Ctrl-f` - Launch FZF menu for tmux operations

### Tmux-Copycat (Search in scrollback)
- `Ctrl-s /` - Search down
- `Ctrl-s ?` - Search up
- `n` - Next match
- `N` - Previous match

### Tmux-Resurrect
- `Ctrl-s Ctrl-s` - Save session
- `Ctrl-s Ctrl-r` - Restore session

## System Integration
- **Mouse support**: Enabled for scrolling, pane selection, and resizing
- **Clipboard**: Automatic integration with macOS clipboard via `pbcopy`
- **Auto-save**: Sessions auto-saved every 15 minutes (tmux-continuum)
- **Auto-restore**: Sessions automatically restored on tmux start

## Color Scheme
Using **Serendipity Midnight** theme with:
- Background: `#1C1E2D`
- Foreground: `#DEE0EF`
- Active pane border: `#5BA2D0` (blue)
- Inactive pane border: `#2C2E3D`
- Prefix highlight: `#A78BFA` (purple)