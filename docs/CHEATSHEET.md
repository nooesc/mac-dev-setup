# Mac Terminal Cheatsheet

A quick reference for your new terminal setup. Print this or keep it handy!

---

## WezTerm Shortcuts

| Shortcut | What it does |
|---|---|
| **Cmd + T** | Split pane vertically (top/bottom) |
| **Cmd + N** | Split pane horizontally (side by side) |
| **Cmd + W** | Close current pane |
| **Cmd + Arrow keys** | Move between panes |
| **Cmd + Shift + T** | New tab |
| **Cmd + [** / **Cmd + ]** | Switch between tabs |
| **Cmd + 1** through **Cmd + 9** | Jump to a specific tab |
| **Cmd + Shift + P** | Command palette (search for any action) |

---

## Terminal Basics

These commands work by typing them and pressing **Enter**. Your setup includes modern replacements that are faster and look better — they work automatically with the same names you'd find in any tutorial.

| Command | What it does |
|---|---|
| `ls` | List files in the current folder (shows icons and colors via **eza**) |
| `cat <file>` | View a file's contents (syntax highlighting via **bat**) |
| `find <name>` | Search for files by name (faster search via **fd**) |
| `grep <text>` | Search inside files for specific text (faster search via **ripgrep**) |
| `cd <folder>` | Change into a folder |
| `cd ..` | Go up one folder |
| `pwd` | Print the current folder path |
| `cl` | Clear the screen |
| `reload` | Reload your shell configuration after changes |
| `ip` | Show your public IP address |
| `q` | Exit the terminal |

> **Tip:** Press **Tab** to autocomplete file and folder names — you don't have to type the whole thing.

---

## Git Basics

Git tracks changes to your files and lets you sync them with GitHub.

| Command | What it does |
|---|---|
| `git status` | See what's changed since your last commit |
| `git add <file>` | Stage a specific file for your next commit |
| `git add .` | Stage all changes |
| `git commit -m "message"` | Save your staged changes with a short description |
| `git push` | Upload your commits to GitHub |
| `git pull` | Download the latest changes from GitHub |
| `git log --oneline` | View recent commits in a compact list |

> **Typical workflow:** make changes, then `git add .` → `git commit -m "description"` → `git push`.

---

## Claude Code

Claude Code is an AI assistant that lives in your terminal. It can read, write, and edit files on your computer.

| Command / Action | What it does |
|---|---|
| `cc` | Start Claude Code (alias for `claude`) |
| Type your request | Just describe what you want in plain English |
| **Escape** | Cancel a running command |
| `/help` | See available commands |
| `/clear` | Reset the conversation |

**Examples of things you can ask Claude Code:**

- "Create a new Python script that converts CSV to JSON"
- "Explain what this file does"
- "Find all the TODO comments in this project"
- "Fix the bug in app.js on line 42"

---

## Troubleshooting

| Problem | Fix |
|---|---|
| **"command not found"** | Close and reopen WezTerm, or type `reload` |
| **Font looks wrong or shows boxes** | Make sure you're using WezTerm, not the built-in Terminal.app |
| **Homebrew issues** | Run `brew doctor` and follow its suggestions |
| **Need to update tools** | Run `brew update && brew upgrade` |
| **Claude Code not working** | Make sure you have an API key set up — check with `claude --help` |

> **Still stuck?** Most problems can be solved by closing WezTerm completely and opening it again.
