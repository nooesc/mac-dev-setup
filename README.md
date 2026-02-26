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

Git tracks every change you make to your code. Think of it as an unlimited undo history that also lets you collaborate with others and sync your work to the cloud (GitHub).

### Key concepts

- **Repository (repo)** — a project folder that Git is tracking. It contains your files plus a hidden `.git` folder with the full history.
- **Commit** — a snapshot of your changes, like a save point. Each commit has a short message describing what changed.
- **Branch** — a separate line of work. The default branch is called `main`. You create new branches to work on features without affecting `main`.
- **Remote** — the copy of your repo on GitHub (or another server). Your local repo and the remote stay in sync via `push` and `pull`.

### Getting a repo

```
# Clone (download) an existing repo from GitHub
git clone https://github.com/username/project-name.git
cd project-name

# Or start tracking a new project
mkdir my-project
cd my-project
git init
```

### The everyday workflow: edit, commit, push

This is what you'll do 90% of the time:

```
# 1. Check what's changed
git status

# 2. Stage the files you want to commit
git add .                    # stage everything, or
git add index.html style.css # stage specific files

# 3. Commit with a short message
git commit -m "Add homepage layout"

# 4. Push your commits to GitHub
git push
```

**What each step does:**

| Step | Command | What's happening |
|---|---|---|
| Check | `git status` | See which files are new, modified, or staged |
| Stage | `git add <files>` | Tell Git which changes to include in the next commit |
| Commit | `git commit -m "message"` | Save a snapshot with a description |
| Push | `git push` | Upload your commits to GitHub |
| Pull | `git pull` | Download the latest changes from GitHub |

### Branches

Branches let you work on a feature without touching the main code. When you're done, you merge it back.

```
# Create a new branch and switch to it
git checkout -b my-feature

# ... make changes, commit as usual ...
git add .
git commit -m "Build contact form"

# Push the branch to GitHub
git push -u origin my-feature

# Switch back to main when you're done
git checkout main
```

### Pull Requests (PRs)

A Pull Request is how you propose merging your branch into `main` on GitHub. It lets others review your changes before they go live.

**On GitHub:**

1. Push your branch (`git push -u origin my-feature`)
2. Go to your repo on github.com
3. Click the **"Compare & pull request"** button that appears
4. Add a title and description, then click **"Create pull request"**

Once the PR is approved, click **"Merge pull request"** on GitHub to merge it into `main`.

> **Tip:** Your setup includes the GitHub CLI (`gh`). After logging in with `gh auth login`, you can create PRs from the terminal: `gh pr create --title "Add contact form"`

### Quick reference

| Command | What it does |
|---|---|
| `git clone <url>` | Download a repo from GitHub |
| `git status` | See what's changed |
| `git add .` | Stage all changes |
| `git commit -m "msg"` | Save a snapshot |
| `git push` | Upload to GitHub |
| `git pull` | Download latest from GitHub |
| `git checkout -b <name>` | Create and switch to a new branch |
| `git checkout main` | Switch back to main |
| `git log --oneline` | View recent commits |
| `gh pr create` | Open a Pull Request from the terminal |

## Reference

See the [cheatsheet](docs/CHEATSHEET.md) for keyboard shortcuts, common commands, and troubleshooting.
