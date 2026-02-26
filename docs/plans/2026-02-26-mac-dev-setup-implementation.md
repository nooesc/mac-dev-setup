# Mac Dev Setup Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create a private GitHub repo with a guided setup script that gets a non-technical Mac user's terminal ready for Claude Code.

**Architecture:** A single interactive bash script (`setup.sh`) that installs tools sequentially with explanations and pauses. Config files are stored in `configs/` and copied into place by the script. A README explains the project and a cheatsheet provides quick reference.

**Tech Stack:** Bash, Homebrew, zsh, WezTerm (Lua config), Starship (TOML config)

---

### Task 1: Create config files

**Files:**
- Create: `configs/.zimrc`
- Create: `configs/.zshrc`
- Create: `configs/starship.toml`
- Create: `configs/wezterm.lua`

**Step 1: Create configs/.zimrc**

```bash
# Zim modules (plugins)
zmodule environment
zmodule git
zmodule input
zmodule utility
zmodule zsh-users/zsh-autosuggestions
zmodule zsh-users/zsh-completions
zmodule zsh-users/zsh-syntax-highlighting
```

This is identical to the source config — no changes needed.

**Step 2: Create configs/.zshrc**

Simplified version of the source `.zshrc`. Strip all personal paths, SSH aliases, editor config, yazi, tmux, and language-specific toolchains. Keep: Zim setup, Starship, Homebrew+Node PATH, shell behavior, modern CLI aliases, utility aliases, Claude Code alias.

```bash
# --- Zimfw Setup ---
export ZIM_HOME=${ZIM_HOME:-${ZDOTDIR:-$HOME}/.zim}

# Download zimfw if not present
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
  curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Auto-build init.zsh if .zimrc changed
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZDOTDIR:-$HOME}/.zimrc" ]]; then
  source "${ZIM_HOME}/zimfw.zsh" init -q
fi

# Load plugins
source "${ZIM_HOME}/init.zsh"

# --- Prompt ---
eval "$(starship init zsh)"

# --- Paths ---
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# --- Shell Behavior ---
setopt hist_ignore_all_dups
setopt share_history
HISTSIZE=10000
SAVEHIST=10000
autoload -Uz compinit && compinit
bindkey '^R' history-incremental-search-backward
eval "$(zoxide init zsh)"

# --- Modern CLI Aliases ---
alias ls='eza -al --icons --git --group-directories-first --header --time-style=relative --color=always --color-scale'
alias cat='bat'
alias find='fd'
alias grep='rg'

# --- Utility Aliases ---
alias cl='clear'
alias reload='source ~/.zshrc'
alias ip='curl -s ifconfig.me'
alias q='exit'

# --- Claude Code ---
alias cc='claude'
```

**Step 3: Create configs/starship.toml**

Use the source config as-is — it's already clean and minimal.

```toml
add_newline = false

format = """$directory$git_branch$git_status$cmd_duration
$character"""

[directory]
truncation_length = 3
truncate_to_repo = true
style = "bold white"
format = "[$path]($style)[$read_only]($read_only_style)"
read_only = " ro"

[git_branch]
symbol = ""
style = "dimmed white"
format = " [$branch]($style)"

[git_status]
style = "dimmed white"
format = "[$all_status$ahead_behind]($style)"
conflicted = " !"
ahead = " +${count}"
behind = " -${count}"
diverged = " +${ahead_count} -${behind_count}"
untracked = " ?"
stashed = " *"
modified = " ~"
staged = " +"
renamed = " >"
deleted = " x"

[character]
success_symbol = "[>](dimmed white)"
error_symbol = "[>](red)"

[cmd_duration]
min_time = 2000
format = " [$duration](dimmed white)"

[package]
disabled = true

[nodejs]
disabled = true
```

**Step 4: Create configs/wezterm.lua**

Use the source config as-is — the theme, keybindings, and settings are all good for a beginner.

```lua
local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Window settings
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.84
config.macos_window_background_blur = 30
config.max_fps = 120
config.animation_fps = 120
config.initial_cols = 200
config.initial_rows = 55
config.window_padding = {
  left = 12,
  right = 12,
  top = 10,
  bottom = 10,
}

-- Font settings
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 14.0

-- Color scheme
config.colors = {
  foreground = '#c8c2ba',
  background = '#3a3836',

  cursor_bg = '#9a96b8',
  cursor_fg = '#3a3836',
  cursor_border = '#9a96b8',

  selection_fg = '#c8c2ba',
  selection_bg = '#504c54',

  ansi = {
    '#a8a29c',
    '#c48b8b',
    '#8aab8d',
    '#c4a87a',
    '#8296b0',
    '#ab8ba5',
    '#80a8a0',
    '#a09a94',
  },

  brights = {
    '#b8b2ac',
    '#d4a0a0',
    '#9abb9c',
    '#d4b88a',
    '#96acc4',
    '#bb9bb5',
    '#90b8b0',
    '#c4bdb5',
  },

  split = '#9a96b8',

  tab_bar = {
    background = '#32302e',
    active_tab = {
      bg_color = '#3a3836',
      fg_color = '#c8c2ba',
    },
    inactive_tab = {
      bg_color = '#32302e',
      fg_color = '#7a7570',
    },
    inactive_tab_hover = {
      bg_color = '#454240',
      fg_color = '#c8c2ba',
    },
    new_tab = {
      bg_color = '#32302e',
      fg_color = '#7a7570',
    },
    new_tab_hover = {
      bg_color = '#454240',
      fg_color = '#c8c2ba',
    },
  },
}

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.6,
}

-- Cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_thickness = 1
config.cursor_blink_rate = 100

-- Scrollback
config.scrollback_lines = 10000

-- Selection
config.selection_word_boundary = " \t\n{}[]()\"'`,;:"

-- Mouse
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
}

-- Tab bar
config.enable_scroll_bar = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

-- Key bindings
config.keys = {
  { key = 'v', mods = 'CMD', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 't', mods = 'CMD', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'n', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = false } },
  { key = 'Backspace', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = false } },
  { key = 't', mods = 'CMD|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = '[', mods = 'CMD', action = wezterm.action.ActivateTabRelative(-1) },
  { key = ']', mods = 'CMD', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'DownArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'UpArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = '1', mods = 'CMD', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'CMD', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'CMD', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'CMD', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'CMD', action = wezterm.action.ActivateTab(8) },
  { key = 'p', mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette },
}

return config
```

**Step 5: Commit**

```bash
git add configs/
git commit -m "Add config files: wezterm, starship, zshrc, zimrc"
```

---

### Task 2: Create the guided setup script

**Files:**
- Create: `setup.sh`

**Step 1: Write setup.sh**

The script must:
- Define helper functions: `info()`, `success()`, `warn()`, `error()`, `step()`, `pause()`
- Use colored output via ANSI codes
- Check macOS (exit if not macOS)
- Install in order: Xcode CLI tools → Homebrew → WezTerm → Nerd Font → git config → CLI tools (eza, bat, fd, ripgrep, zoxide, fzf) → Starship → Zim + plugins → Node.js 22 → Claude Code
- Each step: print explanation → check if already installed → install if needed → confirm success
- `pause` between major steps (press Enter to continue)
- Back up existing configs before copying (~/.zshrc.backup, etc.)
- Copy configs from `configs/` directory (relative to script location)
- Print final summary with next steps

Full script content is provided in the code block below. Key implementation details:

- Use `SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"` to resolve config paths
- Use `command -v <tool>` for existence checks
- Use `xcode-select -p` to check Xcode CLI tools
- For Homebrew: run the official install script from `brew.sh`
- For casks: `brew install --cask wezterm font-jetbrains-mono-nerd-font`
- For formulae: `brew install eza bat fd ripgrep zoxide fzf starship node@22`
- For Claude Code: `npm install -g @anthropic-ai/claude-code`
- Config destinations: `~/.config/wezterm/wezterm.lua`, `~/.config/starship.toml`, `~/.zshrc`, `~/.zimrc`
- Backup: `cp ~/.zshrc ~/.zshrc.backup.$(date +%s)` (timestamped to avoid overwriting previous backups)
- Git config: `read -r` for name/email, then `git config --global user.name/user.email`
- Final message: tells them to quit Terminal, open WezTerm, and type `cc` to start Claude Code

**Step 2: Make executable and commit**

```bash
chmod +x setup.sh
git add setup.sh
git commit -m "Add guided setup script"
```

---

### Task 3: Create the cheatsheet

**Files:**
- Create: `docs/CHEATSHEET.md`

**Step 1: Write docs/CHEATSHEET.md**

Sections:

1. **WezTerm Shortcuts** — Table of Cmd+key shortcuts (split, close, navigate, tabs)
2. **Terminal Basics** — cd, ls (eza), pwd, cat (bat), find (fd), grep (rg), clear (cl)
3. **Git Basics** — git status, git add, git commit, git push, git pull
4. **Claude Code** — `cc` to start, how to give it instructions, `/help`, Escape to cancel
5. **Troubleshooting** — "command not found" → restart terminal or `reload`; Homebrew issues → `brew doctor`; font looks wrong → make sure WezTerm is the terminal being used

**Step 2: Commit**

```bash
git add docs/CHEATSHEET.md
git commit -m "Add terminal and Claude Code cheatsheet"
```

---

### Task 4: Create the README

**Files:**
- Create: `README.md`

**Step 1: Write README.md**

Sections:

1. **Title + one-liner** — "Mac Dev Setup — Get your Mac ready for coding with Claude Code"
2. **What This Does** — Brief list of what gets installed (WezTerm, modern CLI tools, Claude Code, etc.)
3. **Quick Start** — 3 steps: (1) Open Terminal, (2) clone repo, (3) run `./setup.sh`
4. **What You'll Get** — Screenshot placeholder + description of the terminal look/feel
5. **After Setup** — Open WezTerm, type `cc`, start coding
6. **Reference** — Link to `docs/CHEATSHEET.md`

Keep it short. The audience is a beginner — no jargon.

**Step 2: Commit**

```bash
git add README.md
git commit -m "Add README with quick start instructions"
```

---

### Task 5: Create GitHub repo and push

**Step 1: Create private repo on GitHub**

```bash
gh repo create mac-dev-setup --private --source=. --push
```

**Step 2: Verify**

```bash
gh repo view --web
```

---

### Task 6: Test the setup script

**Step 1: Dry-read the script for issues**

Read through `setup.sh` and verify:
- All `brew install` package names are correct
- Config file paths match what the script copies
- No hardcoded usernames or paths
- Script is idempotent (re-running won't break anything)

**Step 2: Verify config files are self-consistent**

- `.zshrc` references starship, zoxide, eza, bat, fd, rg — all installed by the script
- `.zshrc` references `.zimrc` via ZIM_HOME — `.zimrc` is copied by the script
- `wezterm.lua` references JetBrainsMono Nerd Font — installed by the script
- `starship.toml` is standalone, no external dependencies

No automated tests — this is a setup script, not application code. Verification is manual.

**Step 3: Commit any fixes found**

```bash
git add -A && git commit -m "Fix issues found during review" && git push
```
