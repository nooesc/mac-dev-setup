# Mac Dev Setup — Design Doc

**Date:** 2026-02-26
**Purpose:** Private repo with a guided setup script to get a non-technical Mac user's terminal ready for Claude Code.

## Audience

Complete terminal beginner on macOS. Needs to be able to follow the script without external help.

## Repo Structure

```
mac-dev-setup/
├── README.md              # Overview + quick start
├── setup.sh               # Main guided installer script
├── configs/
│   ├── wezterm.lua        # WezTerm terminal config (theme, keybindings, opacity)
│   ├── starship.toml      # Starship prompt config
│   ├── .zshrc             # Simplified shell config
│   └── .zimrc             # Zim plugin manager modules
└── docs/
    └── CHEATSHEET.md      # Quick reference for shortcuts and commands
```

## What Gets Installed

| Order | Tool | Purpose |
|-------|------|---------|
| 1 | Xcode CLI Tools | macOS prerequisite for git, compilers |
| 2 | Homebrew | Package manager |
| 3 | WezTerm | Terminal emulator |
| 4 | JetBrainsMono Nerd Font | Monospace font with icons |
| 5 | Git config | Name/email for commits |
| 6 | eza, bat, fd, ripgrep | Modern ls, cat, find, grep replacements |
| 7 | zoxide, fzf | Smart directory jumping + fuzzy finder |
| 8 | Starship | Shell prompt |
| 9 | Zim + plugins | Zsh plugin manager (autosuggestions, completions, syntax highlighting) |
| 10 | Node.js 22 | JavaScript runtime |
| 11 | Claude Code | AI coding assistant |

## Config Details

### WezTerm (wezterm.lua)
- Custom dark color scheme (epaper pastel)
- 84% opacity with macOS blur
- JetBrainsMono Nerd Font at 14pt
- Keybindings: Cmd+T vertical split, Cmd+N horizontal split, Cmd+W close pane, Cmd+arrows navigate panes, Cmd+Shift+T new tab, Cmd+[/] switch tabs, Cmd+1-9 tab by number
- Borderless window, hidden tab bar when single tab

### Starship (starship.toml)
- Minimal prompt: directory, git branch, git status, command duration
- `>` character prompt (dimmed white, red on error)
- No language version indicators (clean look)

### Zsh (.zshrc)
Included:
- Zim plugin setup
- Starship init
- PATH for Homebrew + Node
- History dedup, shared history, compinit
- Zoxide init
- Modern CLI aliases (eza→ls, bat→cat, fd→find, rg→grep)
- Utility aliases: `cl` (clear), `reload` (source zshrc), `ip` (public IP)
- `cc` alias for Claude Code

Excluded (personal/advanced):
- helix/editor config, SSH aliases, tmux, yazi wrapper
- Flutter, Go, Bun, LM Studio, Spicetify paths
- Aerospace, personal server aliases

### Zim (.zimrc)
- environment, git, input, utility modules
- zsh-autosuggestions, zsh-completions, zsh-syntax-highlighting

## Script Behavior

- Colored output (green success, yellow info, red errors)
- Brief explanation before each step
- "Press Enter to continue" between major steps
- Idempotent — skips already-installed tools
- Interactive git name/email prompt
- Backs up existing configs before overwriting (.backup suffix)
- Summary with next steps at the end

## Cheatsheet (CHEATSHEET.md)

Sections:
1. WezTerm shortcuts (splits, panes, tabs)
2. Terminal basics (cd, ls, pwd with modern aliases)
3. Git basics (status, add, commit, push)
4. Claude Code basics (starting, common usage)
5. Troubleshooting ("something went wrong?")

## Not In Scope

- tmux, helix, yazi, aerospace
- Any language-specific toolchains beyond Node
- dotfile symlinking/stow management
- System preferences or macOS settings
