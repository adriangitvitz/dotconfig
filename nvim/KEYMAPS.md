# 🚀 Neovim Keymaps Reference

*Optimized for Ghostty terminal + macOS + tmux integration*

## 📚 Table of Contents
- [Core Navigation](#-core-navigation)
- [File Operations](#-file-operations)
- [Search & Find](#-search--find)
- [Buffer Management](#-buffer-management)
- [Window Management](#-window-management)
- [Terminal Operations](#-terminal-operations)
- [Git Integration](#-git-integration)
- [Note-Taking & Documentation](#-note-taking--documentation)
- [JSON Handling](#-json-handling)
- [LSP & Code Actions](#-lsp--code-actions)
- [Debugging](#-debugging)
- [Utilities](#-utilities)
- [Snacks Plugin](#-snacks-plugin)
- [Plugin-Specific](#-plugin-specific)

---

## 🧭 Core Navigation

### Leader Key
- **Leader**: `<Space>`

### Flash Navigation (Lightning Fast)
| Key | Action | Description |
|-----|---------|-------------|
| `s` | Flash Jump | Jump to any visible location instantly |
| `S` | Flash Treesitter | Jump using treesitter nodes |
| `r` (operator mode) | Remote Flash | Remote operation target |
| `R` (operator/visual) | Treesitter Search | Search with treesitter |

### Movement
| Key | Action | Description |
|-----|---------|-------------|
| `<C-h/j/k/l>` | Tmux Navigate | Navigate tmux panes/vim splits |
| `<C-\>` | Tmux Previous | Last tmux pane |
| `<M-j/k>` | Resize Height | Decrease/increase window height |
| `<M-,/.>` | Resize Width | Decrease/increase window width |

---

## 📁 File Operations

### Basic File Operations
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>s` | Save File | Save current file |
| `<Cmd-s>` | Save File (macOS) | Save with Cmd key |
| `<Cmd-w>` | Close Buffer (macOS) | Close current buffer |
| `<Cmd-t>` | New Tab (macOS) | Create new tab |

### File Management
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>rN` | Rename File | Fast rename current file |
| `<leader>dB` | Delete Buffer | Delete/close buffer with confirm |
| `<leader>Y` | Yazi | Open Yazi file manager |

---

## 🔍 Search & Find

### Telescope (Primary Search)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>ff` | Find Files | Fuzzy find files in cwd |
| `<leader>fr` | Recent Files | Find recently opened files |
| `<leader>fb` | Find Buffers | Search open buffers |
| `<leader>fs` | Live Grep | Search text across project |
| `<leader>fc` | Find Cursor Word | Search word under cursor |
| `<leader>fd` | Diagnostics | Find LSP diagnostics |
| `<leader>fg` | Git Status | Git status files |
| `<leader>fj` | Jump List | Navigate jump list |
| `<leader>fm` | Marks | Find marks |
| `<leader>fh` | Help Tags | Search help documentation |
| `<leader>fk` | Keymaps | Search keymaps |
| `<leader>f:` | Command History | Search command history |
| `<leader>ft` | Telescope Builtin | All telescope pickers |
| `<leader>fo` | Vim Options | Search vim options |
| `<leader>fR` | Registers | Search registers |
| `<leader>fD` | Directory Search | Live grep in specific directory |

### macOS/Ghostty Shortcuts
| Key | Action | Description |
|-----|---------|-------------|
| `<Cmd-p>` | Find Files | Quick file finder (VSCode-like) |
| `<Cmd-f>` | Live Grep | Project-wide search |
| `<Cmd-b>` | Find Buffers | Buffer switcher |

### Advanced Search (Spectre)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>Sr` | Replace in Files | Project-wide find/replace |
| `<leader>Sw` | Search Word | Search current word globally |
| `<leader>Sf` | Search in File | Search/replace in current file |

### Search Navigation
| Key | Action | Description |
|-----|---------|-------------|
| `<C-g>` | Git Files | Show git-tracked files |
| `<leader>tf` | Buffer Fuzzy Find | Fuzzy find in current buffer |

---

## 📋 Buffer Management

### Buffer Navigation
| Key | Action | Description |
|-----|---------|-------------|
| `<M-h>` | Previous Buffer | Go to previous buffer (Alt-h) |
| `<M-l>` | Next Buffer | Go to next buffer (Alt-l) |
| `[b` | Previous Buffer | Alternative previous buffer |
| `]b` | Next Buffer | Alternative next buffer |

### Buffer Operations
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>fb` | List Buffers | Telescope buffer picker |
| `<Cmd-b>` | List Buffers | macOS buffer switcher |

---

## 🪟 Window Management

### Window Operations
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>wv` | Split Vertical | Create vertical split |
| `<leader>ws` | Split Horizontal | Create horizontal split |
| `<leader>we` | Equal Splits | Make all splits equal size |
| `<leader>wx` | Close Split | Close current split |
| `<leader>wq` | Close Window | Close current window |

### Window Resizing
| Key | Action | Description |
|-----|---------|-------------|
| `<M-j>` | Decrease Height | Make window shorter |
| `<M-k>` | Increase Height | Make window taller |
| `<M-,>` | Decrease Width | Make window narrower |
| `<M-.>` | Increase Width | Make window wider |

---

## 💻 Terminal Operations

### Terminal Management
| Key | Action | Description |
|-----|---------|-------------|
| `<C-\>` | Toggle Terminal | Quick terminal toggle |
| `<leader>tf` | Float Terminal | Floating terminal window |
| `<leader>th` | Horizontal Terminal | Terminal at bottom |
| `<leader>tv` | Vertical Terminal | Vertical terminal split |
| `<leader>tt` | Terminal Split | Open terminal in split |

### Terminal Mode
| Key | Action | Description |
|-----|---------|-------------|
| `<C-[>` | Exit Terminal | Exit terminal mode |
| `<M-[>` | Exit Terminal | Alternative exit (Alt-Esc) |

### Advanced Terminal
| Key | Action | Description |
|-----|---------|-------------|
| `<c-o>t` | Toggle Term (Bottom) | Bottom terminal |
| `<c-o>T` | Toggle Term (Tab) | Terminal in new tab |
| `<leader>zd` | Lazydocker | Docker management |
| `<leader>vG` | Git Dash | GitHub dashboard |

---

## 🔀 Git Integration

### Git Operations
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>gg` | LazyGit | Full LazyGit interface |
| `<Cmd-g>` | LazyGit (macOS) | LazyGit with Cmd key |
| `<leader>gf` | LazyGit File | LazyGit for current file |
| `<leader>fg` | Git Status | Telescope git status |

### Git Blame & History
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>gB` | Git Blame Toggle | Show/hide inline git blame |
| `<leader>gbc` | Open Commit URL | Open commit in browser |
| `<leader>gby` | Copy Commit SHA | Copy commit SHA to clipboard |
| `<leader>gbf` | Open File URL | Open file URL in browser |
| `<leader>gbt` | Toggle Blame Session | Toggle blame for current session |

### Snacks Git Integration
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>lg` | LazyGit | Snacks LazyGit |
| `<leader>gl` | LazyGit Logs | LazyGit log view |
| `<leader>gbr` | Git Branches | Pick/switch branches |
| `<leader>gL` | Git Log Line | Git log for current line |
| `<leader>gf` | Git Log File | Git log for current file |

### Git Signs
| Key | Action | Description |
|-----|---------|-------------|
| `]c` | Next Hunk | Next git change |
| `[c` | Prev Hunk | Previous git change |

---

## 📝 Note-Taking & Documentation

### Neorg (Primary Notes)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>nw` | Workspace | Switch Neorg workspace |
| `<leader>nr` | Return | Return to Neorg |
| `<leader>ni` | Index | Open index file |
| `<leader>nj` | Journal | Open journal |
| `<leader>nt` | Today | Today's journal entry |
| `<leader>ny` | Yesterday | Yesterday's journal |
| `<leader>nm` | Tomorrow | Tomorrow's journal |
| `<leader>nf` | Find Notes | Telescope Neorg files |
| `<leader>nh` | Search Headings | Search note headings |
| `<leader>nl` | Insert Link | Insert note link |
| `<leader>nF` | Insert File Link | Insert file link |

### Neorg Folding & Navigation
| Key | Action | Description |
|-----|---------|-------------|
| `za` | Toggle Fold | Toggle fold under cursor |
| `zc` | Close Fold | Close fold under cursor |
| `zo` | Open Fold | Open fold under cursor |
| `zM` | Close All Folds | Close all folds in buffer |
| `zR` | Open All Folds | Open all folds in buffer |
| `zj` | Next Fold | Jump to next fold |
| `zk` | Previous Fold | Jump to previous fold |
| `]h` | Next Heading | Jump to next heading |
| `[h` | Previous Heading | Jump to previous heading |
| `<Tab>` (in Neorg) | Promote Heading | Increase heading level |
| `<S-Tab>` (in Neorg) | Demote Heading | Decrease heading level |

### Neorg Structure Navigation
| Key | Action | Description |
|-----|---------|-------------|
| `<CR>` | Follow Link | Follow link under cursor |
| `<Backspace>` | Go Back | Return from followed link |
| `<C-Space>` | Toggle Task | Toggle task completion status |
| `<M-CR>` | Insert Heading | Insert heading below current |
| `>` (visual) | Indent | Increase indentation |
| `<` (visual) | Unindent | Decrease indentation |

### Markdown
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>mp` | Markdown Preview | Preview in browser |

---

## 📊 JSON Handling

### JSON Formatting
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>jp` | Pretty JSON | Format JSON with jq |
| `<leader>jc` | Compact JSON | Remove JSON whitespace |
| `<leader>js` | Sort JSON | Sort JSON keys alphabetically |
| `<leader>jv` | JSON Split | Open JSON in vertical split |

### JSON Querying
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>jq` | Jqx List | Interactive jq queries |
| `<leader>jf` | Jqx Query | Run jq query |

### Visual Mode JSON
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>jp` (visual) | Pretty Selection | Format selected JSON |

### JSON/Code Folding
| Key | Action | Description |
|-----|---------|-------------|
| `za` | Toggle Fold | Toggle fold at cursor (objects/arrays) |
| `zc` | Close Fold | Close fold (collapse object/array) |
| `zo` | Open Fold | Open fold (expand object/array) |
| `zM` | Close All | Close all folds in file |
| `zR` | Open All | Open all folds in file |
| `zm` | Fold More | Increase fold level |
| `zr` | Fold Less | Decrease fold level |
| `zj` | Next Fold | Jump to next fold |
| `zk` | Previous Fold | Jump to previous fold |

---

## 🔧 LSP & Code Actions

### LSP Navigation
| Key | Action | Description |
|-----|---------|-------------|
| `gd` | Go to Definition | Jump to definition |
| `gD` | Go to Type Definition | Jump to type definition |
| `gr` | References | Show references |
| `gi` | Implementations | Show implementations |
| `K` | Hover | Show hover information |

### Code Navigation & Outline
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>o` | Code Outline | Toggle Aerial outline sidebar |
| `]a` | Next Symbol | Jump to next function/class/method |
| `[a` | Previous Symbol | Jump to previous function/class/method |
| `<leader>ao` | Open Outline | Force open code outline |
| `<leader>ac` | Close Outline | Force close code outline |

### LSP Actions
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>ca` | Code Action Preview | Enhanced code actions with preview |
| `<leader>rn` | Rename | LSP rename symbol |
| `<leader>cL` | CodeLens | Run CodeLens |

### Python-Specific LSP
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>pi` | Organize Imports | Organize Python imports |
| `<leader>pr` | Restart Pyright | Restart Python LSP server |

### Diagnostics
| Key | Action | Description |
|-----|---------|-------------|
| `]d` | Next Diagnostic | Jump to next diagnostic |
| `[d` | Prev Diagnostic | Jump to previous diagnostic |
| `<leader>dd` | Buffer Diagnostics | Show buffer diagnostics |
| `<leader>fd` | All Diagnostics | Show all diagnostics |

### Symbols
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>ss` | LSP Symbols | Show document symbols |

---

## 🐛 Debugging

### DAP (Debug Adapter Protocol)
*Note: DAP configuration present but keymaps not shown in current config*

### Trouble (Error Management)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>xx` | Diagnostics | Toggle diagnostics |
| `<leader>xX` | Buffer Diagnostics | Buffer diagnostics only |
| `<leader>cs` | Symbols | Document symbols |
| `<leader>cl` | LSP References | LSP definitions/references |
| `<leader>Cf` | LSP Focus | Focus LSP window |
| `<leader>xL` | Location List | Toggle location list |
| `<leader>xQ` | Quickfix | Toggle quickfix list |

---

## 🛠 Utilities

### Text Manipulation
| Key | Action | Description |
|-----|---------|-------------|
| `J` (visual) | Move Lines Down | Move selected lines down |
| `K` (visual) | Move Lines Up | Move selected lines up |
| `<` (visual) | Indent Left | Maintain visual selection |
| `>` (visual) | Indent Right | Maintain visual selection |

### Quick Actions
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>R` | Make | Run make command |
| `<Esc>` | Clear Search | Clear search highlighting |

### File Bookmarks (Harpoon)
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>ha` | Add Bookmark | Bookmark current file |
| `<leader>hh` | Harpoon Menu | Toggle bookmark menu |
| `<Cmd-1/2/3/4>` | Quick Switch | Switch to bookmarked files |
| `<leader>1/2/3/4` | Quick Switch | Alternative bookmark access |

### Disabled Keys
| Key | Action | Description |
|-----|---------|-------------|
| `Q` | Disabled | Prevent accidental Ex mode |
| `q` | Disabled | Prevent accidental macro record |

---

## 🍿 Snacks Plugin

### File Operations
| Key | Action | Description |
|-----|---------|-------------|
| `<leader><space>` | Smart Find | Intelligent file finder |
| `<leader>.` | Scratch Buffer | Toggle scratch buffer |
| `<leader>S` | Select Scratch | Choose scratch buffer |

### Snacks Picker
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>pf` | Find Files | Snacks file picker |
| `<leader>pc` | Config Files | Find config files |
| `<leader>ps` | Grep | Search with Snacks |
| `<leader>pws` | Grep Word | Search word/selection |
| `<leader>pk` | Keymaps | Search keymaps (ivy layout) |

### Utilities
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>n` | Notifications | Show notification history |
| `<leader>es` | Explorer | Open Snacks file explorer |
| `<leader>sm` | Marks | Show marks |
| `<leader>sw` | Search Word | Search visual selection |
| `<leader>sM` | Man Pages | Search manual pages |
| `<leader>vh` | Help | Search help pages |

### Toggle Commands
| Key | Action | Description |
|-----|---------|-------------|
| `<leader>us` | Spelling | Toggle spell check |
| `<leader>uw` | Wrap | Toggle line wrap |
| `<leader>uL` | Relative Numbers | Toggle relative line numbers |
| `<leader>ud` | Diagnostics | Toggle LSP diagnostics |
| `<leader>ul` | Line Numbers | Toggle line numbers |
| `<leader>uc` | Conceal Level | Toggle concealment |
| `<leader>uT` | Treesitter | Toggle treesitter |
| `<leader>ub` | Background | Toggle dark/light theme |
| `<leader>uh` | Inlay Hints | Toggle LSP inlay hints |

---

## 🔌 Plugin-Specific

### Which-Key
- Timeout: 300ms
- Shows available keybindings after leader key

### Telescope Extensions
- UI Select integration
- FZF native sorting
- Git worktree support (commented)

### Treesitter Text Objects (Enhanced)
| Key | Action | Description |
|-----|---------|-------------|
| `af/if` | Function | Around/inside function |
| `ac/ic` | Class | Around/inside class |
| `ak/ik` | Block | Around/inside block |
| `aa/ia` | Argument | Around/inside parameter |
| `al/il` | Loop | Around/inside loop |
| `a?/i?` | Conditional | Around/inside conditional |
| `ao/io` | Code Block | Around/inside code block/conditional/loop |
| `au/iu` | Function Call | Around/inside function call usage |
| `aU/iU` | Function Call (Named) | Around/inside named function call |
| `ad/id` | Digits | Around/inside number/digits |
| `ae/ie` | Enhanced Word | Around/inside camelCase/snake_case word |
| `ag/ig` | Entire Buffer | Around/inside entire file |
| `aL/iL` | Line Content | Around/inside line without line ending |
| `aI/iI` | Indent Block | Around/inside Python-style indent block |

### Text Object Navigation
| Key | Action | Description |
|-----|---------|-------------|
| `an/in` | Next Objects | Around/inside next text object |
| `al/il` | Last Objects | Around/inside previous text object |
| `g[` | Go to Left | Move to left edge of text object |
| `g]` | Go to Right | Move to right edge of text object |

### Treesitter Movement
| Key | Action | Description |
|-----|---------|-------------|
| `]f/[f` | Function | Next/prev function start |
| `]F/[F` | Function End | Next/prev function end |
| `]k/[k` | Block | Next/prev block start |
| `]K/[K` | Block End | Next/prev block end |

---

## 🎯 Quick Reference

### Most Used Keymaps
1. `<leader>ff` - Find files
2. `<leader>fs` - Search in project  
3. `s` - Flash jump anywhere
4. `<leader>gg` - LazyGit
5. `<M-h/l>` - Switch buffers
6. `<leader>ca` - Enhanced code actions with preview
7. `<leader>o` - Code outline (new!)
8. `<leader>jp` - Format JSON
9. `<leader>nt` - Today's notes

### Essential Productivity Commands
1. `<leader>o` - Toggle code outline
2. `]a/[a` - Navigate between symbols
3. `<leader>gB` - Toggle git blame
4. `au/iu` - Select function call
5. `ae/ie` - Select camelCase/snake_case word

### Essential Folding Commands
1. `za` - Toggle current fold
2. `zM` - Close all folds (overview mode)
3. `zR` - Open all folds (detail mode)
4. `zc/zo` - Close/open specific fold
5. `zj/zk` - Navigate between folds

### Emergency Exits
- `<Esc>` - Clear search, exit modes
- `<C-[>` - Exit terminal mode
- `<leader>xx` - Show diagnostics if stuck

---

*Generated for Neovim config optimized for Ghostty terminal + macOS + tmux*
*Leader key: `<Space>` | Last updated: 2025*