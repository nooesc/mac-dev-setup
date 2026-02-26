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

## Reference

See the [cheatsheet](docs/CHEATSHEET.md) for keyboard shortcuts, common commands, and troubleshooting.
