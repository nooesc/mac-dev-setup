# Mac Dev Setup

Get your Mac ready for coding with Claude Code.

## What This Does

The setup script installs and configures everything you need:

- **WezTerm** -- a modern terminal app (replaces the built-in Terminal)
- **JetBrainsMono Nerd Font** -- makes icons show up nicely in your terminal
- **Modern CLI tools** -- eza, bat, fd, ripgrep, zoxide, fzf (faster, friendlier replacements for everyday commands)
- **Starship** -- a clean, informative prompt that tells you where you are at a glance
- **Node.js** -- the JavaScript runtime that Claude Code needs
- **Claude Code** -- your AI coding assistant
- **Shell configs** -- ties everything together so it all works out of the box

## Quick Start

**1. Open Terminal**

It's in Applications > Utilities, or press **Cmd+Space** and search "Terminal".

**2. Run these commands**

Copy and paste these lines one at a time, pressing Enter after each:

```
xcode-select --install
```

A pop-up will appear — click "Install" and wait for it to finish. Then run:

```
git clone https://github.com/nooesc/mac-dev-setup.git
cd mac-dev-setup
./setup.sh
```

**3. Follow the on-screen instructions**

The script will walk you through each step. It asks before installing anything.

## After Setup

1. Quit Terminal (**Cmd+Q**)
2. Open WezTerm (press **Cmd+Space** and search "WezTerm")
3. Type `cc` to start Claude Code

That's it -- you're ready to go!

## Navigating Folders in the Terminal

When you open a terminal, you're always "inside" a folder (also called a directory). Everything you do happens relative to where you are.

### The basics: `cd`, `ls`, and `pwd`

| Command | What it does | Example |
|---|---|---|
| `pwd` | **P**rint **w**orking **d**irectory — shows where you are right now | `/Users/yourname` |
| `ls` | **L**i**s**t what's in the current folder | `Desktop  Documents  Downloads` |
| `cd <folder>` | **C**hange **d**irectory — move into a folder | `cd Documents` |
| `cd ..` | Go up one level (the parent folder) | If you're in `Documents`, this takes you to `/Users/yourname` |
| `cd` | Go straight to your home folder from anywhere | Same as `cd ~` |

Think of it like Finder, but instead of clicking folders you type their names.

**Example session:**

```
~$ pwd
/Users/yourname

~$ ls
Desktop  Documents  Downloads  Projects

~$ cd Projects
~/Projects$ ls
my-website  hello-world

~/Projects$ cd my-website
~/Projects/my-website$ pwd
/Users/yourname/Projects/my-website

~/Projects/my-website$ cd ..
~/Projects$ cd
~$
```

> **Tip:** Press **Tab** after typing the first few letters of a folder name and the terminal will autocomplete it for you. This saves a lot of typing and avoids misspellings.

### Supercharged navigation with zoxide

Your setup includes **zoxide**, a smarter replacement for `cd`. It remembers folders you've visited so you can jump to them instantly — no need to type the full path.

| Command | What it does |
|---|---|
| `cd projects` | Works exactly like normal — moves into a subfolder called `projects` |
| `z my-website` | Jumps to the **most-visited folder** matching "my-website", no matter where you are |
| `zi` | Opens an **interactive picker** (powered by fzf) to search and select from your history |

**How it works:** Every time you `cd` into a folder, zoxide records it. Over time it learns which folders you use most. Then `z` plus a few letters is all you need:

```
# You've visited /Users/yourname/Projects/my-website a few times.
# Now from anywhere on your system:

~$ z my-web
~/Projects/my-website$

# Jumped straight there — no typing the full path!
```

zoxide works behind the scenes. You don't need to configure anything — just use `cd` normally and it learns your habits. When you want to jump somewhere fast, use `z`.

## Reference

See the [cheatsheet](docs/CHEATSHEET.md) for keyboard shortcuts, common commands, and troubleshooting.
