# Mac Dev Setup

Get your Mac ready for coding with Claude Code.

## What This Does

The setup script installs and configures everything you need:

- **WezTerm** -- a modern terminal app (replaces the built-in Terminal)
- **JetBrainsMono Nerd Font** -- makes icons show up nicely in your terminal
- **GitHub CLI** -- create pull requests, manage issues, and more from your terminal
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

## Git Basics

Git tracks every change you make to your code. Think of it as an unlimited undo history that also lets you sync your work to GitHub.

**The good news: you don't need to memorize Git commands.** You can just tell Claude Code what you want in plain English:

- *"commit my changes"*
- *"push to GitHub"*
- *"create a new branch called my-feature"*
- *"make a pull request"*

Claude will run the right Git commands for you and explain what it's doing.

### Key concepts

These are worth understanding even if Claude handles the commands:

- **Commit** — a save point. A snapshot of your changes with a short description of what changed.
- **Branch** — a separate line of work. You create branches to build features without affecting the main code. The default branch is called `main`.
- **Push / Pull** — push uploads your commits to GitHub; pull downloads the latest changes from GitHub.
- **Pull Request (PR)** — a proposal to merge your branch into `main`. It lets others review your changes before they go live.

### If you want to run commands yourself

| Command | What it does |
|---|---|
| `git status` | See what's changed |
| `git add .` | Stage all changes for commit |
| `git commit -m "message"` | Save a snapshot |
| `git push` | Upload to GitHub |
| `git pull` | Download latest from GitHub |
| `git checkout -b <name>` | Create and switch to a new branch |
| `gh pr create` | Open a Pull Request from the terminal |

> **Tip:** Your setup includes the GitHub CLI (`gh`). Log in with `gh auth login` to create PRs and manage issues from the terminal.

## Claude Code: Slash Commands and Skills

Claude Code has built-in commands you can type during a conversation. They all start with `/`.

### Built-in slash commands

These are available out of the box:

| Command | What it does |
|---|---|
| `/help` | See all available commands |
| `/clear` | Reset the conversation (start fresh) |
| `/compact` | Summarize the conversation to free up context space |
| `/model` | Switch to a different AI model |
| `/memory` | Edit your project's `CLAUDE.md` file (Claude's long-term memory) |
| `/init` | Create a `CLAUDE.md` file for your project |
| `/cost` | Show how many tokens you've used |
| `/exit` | Quit Claude Code |

> **Tip:** Type `/` and press **Tab** to see all available commands.

### Skills (custom slash commands)

Skills are custom commands you create as simple markdown files. They teach Claude reusable workflows — like how to review code, run deployments, or follow your team's conventions.

**Where skills live:**

| Location | Path | Applies to |
|---|---|---|
| Personal | `~/.claude/skills/<name>/SKILL.md` | All your projects |
| Project | `.claude/skills/<name>/SKILL.md` | That project only |

**Creating a skill:**

```
mkdir -p ~/.claude/skills/explain-code
```

Then create `SKILL.md` inside that folder:

```markdown
---
name: explain-code
description: Explains code with diagrams and analogies
---

When explaining code:
1. Start with an everyday analogy
2. Draw an ASCII diagram of the flow
3. Walk through the code step by step
4. Highlight a common mistake or gotcha
```

Now you can type `/explain-code` in any Claude Code session and it will follow those instructions.

**Key things to know:**
- The `name` in the frontmatter becomes the `/command` name
- The `description` helps Claude decide when to use the skill automatically
- Skills can accept arguments — e.g. `/deploy production`
- Skills are just text files in version control, so they're easy to share with your team

### What about MCP servers?

You may see references to **MCP (Model Context Protocol)** servers. These connect Claude to external tools and APIs — things like GitHub, databases, or monitoring services.

**Prefer skills + CLI tools over MCP when you can.** Here's why:

| | Skills + CLI tools | MCP Servers |
|---|---|---|
| **What they are** | Markdown instructions + tools already on your Mac | External services Claude connects to |
| **Good for** | Workflows, conventions, anything a CLI can do | Accessing APIs or data Claude can't reach otherwise |
| **Setup** | Drop a `.md` file in a folder | Install and configure a running server |
| **Complexity** | Simple — just text | More moving parts, can break |
| **Context usage** | Minimal — only loads what's needed | **Bloats context** — MCP tool definitions eat into Claude's memory every message |
| **Sharing** | Commit to your repo | Requires server setup per machine |

The context bloat problem is the big one. Every MCP server registers its tools into Claude's context window, taking up space that could be used for your actual conversation. The more MCP servers you connect, the less room Claude has to think about your code. A skill that tells Claude to run `gh pr list` uses almost no context, while a GitHub MCP server loads dozens of tool definitions into every single message.

**When to use MCP:** When you truly need Claude to access something it can't reach through a CLI tool — like a proprietary API with no command-line client, or a live database connection.

**When to use skills + CLI tools instead:** Almost everything else. Claude can already run shell commands, so a skill that says "use `gh` for GitHub operations" or "use `curl` to hit this API" is lighter, simpler, and leaves more context for your actual work.

## Reference

See the [cheatsheet](docs/CHEATSHEET.md) for keyboard shortcuts, common commands, and troubleshooting.
