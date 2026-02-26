#!/bin/bash
set -e

# Friendly error message on unexpected failures
trap 'echo ""; printf "\033[0;31m✗ Something went wrong. Please re-run the script — it will pick up where it left off.\033[0m\n"; exit 1' ERR

# ============================================================================
# Mac Dev Setup — Guided Installer
# A friendly, step-by-step setup for new Mac users who want to use Claude Code.
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STEP_NUM=0

# --- Helper Functions -------------------------------------------------------

info() {
  printf '\033[0;33m%s\033[0m\n' "$1"
}

success() {
  printf '\033[0;32m✓ %s\033[0m\n' "$1"
}

warn() {
  printf '\033[1;33m⚠ %s\033[0m\n' "$1"
}

error() {
  printf '\033[0;31m✗ %s\033[0m\n' "$1"
}

step() {
  STEP_NUM=$((STEP_NUM + 1))
  printf '\n\033[1m━━━ Step %d: %s ━━━\033[0m\n' "$STEP_NUM" "$1"
  info "$2"
  echo ""
}

pause() {
  printf '\033[0;36m→ Press Enter to continue...\033[0m'
  read -r
}

# --- Pre-flight Checks ------------------------------------------------------

if [[ "$(uname)" != "Darwin" ]]; then
  error "This script only works on macOS. You appear to be running $(uname)."
  exit 1
fi

echo ""
echo "┌──────────────────────────────────────────────────────┐"
echo "│                                                      │"
echo "│   Welcome to the Mac Dev Setup installer!            │"
echo "│                                                      │"
echo "│   This will set up your Mac for software             │"
echo "│   development and install Claude Code.               │"
echo "│                                                      │"
echo "│   The whole process takes about 10–20 minutes.       │"
echo "│   You'll be guided through every step.               │"
echo "│                                                      │"
echo "└──────────────────────────────────────────────────────┘"
echo ""

pause

# ============================================================================
# 1. Xcode Command Line Tools
# ============================================================================

step "Xcode Command Line Tools" \
  "These are basic building blocks that other developer tools need to work."

if xcode-select -p &>/dev/null; then
  success "Xcode Command Line Tools are already installed."
else
  info "Installing Xcode Command Line Tools..."
  info "A pop-up window will appear — click 'Install' and wait for it to finish."
  info "This can take a few minutes. Come back here when it's done."
  echo ""
  xcode-select --install 2>/dev/null || true

  echo ""
  info "Waiting for Xcode Command Line Tools to finish installing..."
  info "(If the pop-up didn't appear, they may already be installing.)"
  echo ""

  # Wait until xcode-select -p succeeds (timeout after 10 minutes)
  WAIT_COUNT=0
  until xcode-select -p &>/dev/null; do
    sleep 5
    WAIT_COUNT=$((WAIT_COUNT + 1))
    if [[ $WAIT_COUNT -ge 120 ]]; then
      error "Xcode CLI Tools installation timed out. Please install manually and re-run this script."
      exit 1
    fi
  done

  success "Xcode Command Line Tools installed!"
fi

pause

# ============================================================================
# 2. Homebrew
# ============================================================================

step "Homebrew" \
  "Homebrew is a package manager — it's how you install software on your Mac."

if command -v brew &>/dev/null; then
  success "Homebrew is already installed."
else
  info "Installing Homebrew... This may ask for your password."
  echo ""

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Set up brew in the current shell so we can use it immediately
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  if command -v brew &>/dev/null; then
    success "Homebrew installed!"
  else
    error "Homebrew installation may have failed. Please try running this script again."
    exit 1
  fi
fi

pause

# ============================================================================
# 3. WezTerm
# ============================================================================

step "WezTerm" \
  "WezTerm is a modern terminal app — much nicer than the default Terminal.app."

if brew list --cask wezterm &>/dev/null; then
  success "WezTerm is already installed."
else
  info "Installing WezTerm..."
  brew install --cask wezterm
  success "WezTerm installed!"
fi

# ============================================================================
# 4. JetBrainsMono Nerd Font
# ============================================================================

step "JetBrainsMono Nerd Font" \
  "This font includes special icons that make the terminal look great."

if brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
  success "JetBrainsMono Nerd Font is already installed."
else
  info "Installing JetBrainsMono Nerd Font..."
  brew install --cask font-jetbrains-mono-nerd-font
  success "JetBrainsMono Nerd Font installed!"
fi

pause

# ============================================================================
# 5. Git Config
# ============================================================================

step "Git Configuration" \
  "Git tracks changes to your code. It needs your name and email so it knows who made each change."

CURRENT_NAME="$(git config --global user.name 2>/dev/null || true)"
CURRENT_EMAIL="$(git config --global user.email 2>/dev/null || true)"

if [[ -n "$CURRENT_NAME" && -n "$CURRENT_EMAIL" ]]; then
  info "Git is already configured:"
  info "  Name:  $CURRENT_NAME"
  info "  Email: $CURRENT_EMAIL"
  echo ""
  printf "Would you like to change these? (y/N): "
  read -r CHANGE_GIT
  if [[ "$CHANGE_GIT" =~ ^[Yy]$ ]]; then
    CURRENT_NAME=""
    CURRENT_EMAIL=""
  fi
fi

if [[ -z "$CURRENT_NAME" ]]; then
  printf "Enter your full name (e.g., Jane Smith): "
  read -r GIT_NAME
  if [[ -n "$GIT_NAME" ]]; then
    git config --global user.name "$GIT_NAME"
    success "Git name set to: $GIT_NAME"
  else
    warn "No name entered — skipping. You can set it later with: git config --global user.name \"Your Name\""
  fi
fi

if [[ -z "$CURRENT_EMAIL" ]]; then
  printf "Enter your email address: "
  read -r GIT_EMAIL
  if [[ -n "$GIT_EMAIL" ]]; then
    git config --global user.email "$GIT_EMAIL"
    success "Git email set to: $GIT_EMAIL"
  else
    warn "No email entered — skipping. You can set it later with: git config --global user.email \"you@example.com\""
  fi
fi

# ============================================================================
# 6. GitHub CLI
# ============================================================================

step "GitHub CLI" \
  "The GitHub CLI lets you create pull requests, manage issues, and more — right from your terminal."

if command -v gh &>/dev/null; then
  success "GitHub CLI is already installed."
else
  info "Installing GitHub CLI..."
  brew install gh
  success "GitHub CLI installed!"
fi

info "You can log in later by running: gh auth login"

pause

# ============================================================================
# 7. Modern CLI Tools
# ============================================================================

step "Modern CLI Tools" \
  "These replace everyday commands with faster, friendlier versions with color and icons."

CLI_TOOLS=(eza bat fd ripgrep zoxide fzf)
NEED_INSTALL=()

for tool in "${CLI_TOOLS[@]}"; do
  # Map brew package names to command names for checking
  case "$tool" in
    ripgrep) CMD_NAME="rg" ;;
    *) CMD_NAME="$tool" ;;
  esac

  if command -v "$CMD_NAME" &>/dev/null; then
    success "$tool is already installed."
  else
    NEED_INSTALL+=("$tool")
  fi
done

if [[ ${#NEED_INSTALL[@]} -gt 0 ]]; then
  info "Installing: ${NEED_INSTALL[*]}..."
  brew install "${NEED_INSTALL[@]}"
  success "Modern CLI tools installed!"
else
  success "All modern CLI tools are already installed."
fi

# ============================================================================
# 8. Starship Prompt
# ============================================================================

step "Starship Prompt" \
  "Starship makes your terminal prompt informative and good-looking."

if command -v starship &>/dev/null; then
  success "Starship is already installed."
else
  info "Installing Starship..."
  brew install starship
  success "Starship installed!"
fi

pause

# ============================================================================
# 9. Node.js 22
# ============================================================================

step "Node.js 22" \
  "Node.js runs JavaScript outside the browser. Claude Code needs it to work."

if command -v node &>/dev/null; then
  NODE_VERSION="$(node --version 2>/dev/null || true)"
  success "Node.js is already installed (${NODE_VERSION})."
else
  info "Installing Node.js 22..."
  brew install node@22

  # node@22 is keg-only, so add it to PATH for this session
  if [[ -d "/opt/homebrew/opt/node@22/bin" ]]; then
    export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
  elif [[ -d "/usr/local/opt/node@22/bin" ]]; then
    export PATH="/usr/local/opt/node@22/bin:$PATH"
  fi

  if command -v node &>/dev/null; then
    success "Node.js 22 installed!"
  else
    warn "Node.js was installed but may not be on PATH yet. It will work after you open WezTerm."
  fi
fi

# ============================================================================
# 10. Claude Code
# ============================================================================

step "Claude Code" \
  "This is the AI coding assistant you'll be using. It runs right in your terminal."

if command -v claude &>/dev/null; then
  success "Claude Code is already installed."
elif ! command -v npm &>/dev/null; then
  warn "npm is not available yet. Claude Code will be installed when you open WezTerm and run: npm install -g @anthropic-ai/claude-code"
else
  info "Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
  success "Claude Code installed!"
fi

pause

# ============================================================================
# 11. Config Files
# ============================================================================

step "Configuration Files" \
  "Now we'll install config files that make everything look and work nicely together."

install_config() {
  local src="$1"
  local dest="$2"
  local label="$3"

  # Create parent directory if needed
  mkdir -p "$(dirname "$dest")"

  # Back up existing file if it exists
  if [[ -f "$dest" ]]; then
    local backup="${dest}.backup.$(date +%s)"
    cp "$dest" "$backup"
    info "Backed up existing $label to $(basename "$backup")"
  fi

  cp "$src" "$dest"
  success "Installed $label"
}

install_config "$SCRIPT_DIR/configs/.zshrc"        "$HOME/.zshrc"                  ".zshrc (shell config)"
install_config "$SCRIPT_DIR/configs/.zimrc"         "$HOME/.zimrc"                  ".zimrc (plugin list)"
install_config "$SCRIPT_DIR/configs/starship.toml"  "$HOME/.config/starship.toml"   "starship.toml (prompt theme)"
install_config "$SCRIPT_DIR/configs/wezterm.lua"    "$HOME/.config/wezterm/wezterm.lua" "wezterm.lua (terminal config)"

# ============================================================================
# 12. Initialize Zim (Plugin Manager)
# ============================================================================

step "Zim Plugin Manager" \
  "Zim manages shell plugins that add features like auto-suggestions and syntax highlighting."

ZIM_HOME="${HOME}/.zim"

if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
  info "Downloading Zim framework..."
  mkdir -p "${ZIM_HOME}"
  curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  success "Zim framework downloaded."
fi

info "Installing Zim plugins (this may take a moment)..."
if zsh -c "source ${ZIM_HOME}/zimfw.zsh install" 2>&1; then
  success "Zim plugins installed!"
else
  warn "Zim plugin installation had issues. They will be installed automatically when you open WezTerm."
fi

pause

# ============================================================================
# Final Summary
# ============================================================================

echo ""
echo "┌──────────────────────────────────────────────────────┐"
echo "│                                                      │"
echo "│   Setup Complete!                                    │"
echo "│                                                      │"
echo "│   Installed:                                         │"
echo "│     • Xcode Command Line Tools                       │"
echo "│     • Homebrew (package manager)                     │"
echo "│     • WezTerm (terminal app)                         │"
echo "│     • JetBrainsMono Nerd Font                        │"
echo "│     • Git (configured)                               │"
echo "│     • GitHub CLI (gh)                               │"
echo "│     • Modern CLI tools                               │"
echo "│       (eza, bat, fd, rg, zoxide, fzf)                │"
echo "│     • Starship (prompt theme)                        │"
echo "│     • Node.js 22                                     │"
echo "│     • Claude Code                                    │"
echo "│     • Shell, prompt, and terminal configs            │"
echo "│     • Zim plugins                                    │"
echo "│                                                      │"
echo "├──────────────────────────────────────────────────────┤"
echo "│                                                      │"
echo "│   What to do next:                                   │"
echo "│                                                      │"
echo "│   1. Quit Terminal (Cmd+Q)                           │"
echo "│   2. Open WezTerm (search for it in Spotlight)       │"
echo "│   3. Type 'cc' to start Claude Code                  │"
echo "│                                                      │"
echo "│   See docs/CHEATSHEET.md for shortcuts and tips.     │"
echo "│                                                      │"
echo "└──────────────────────────────────────────────────────┘"
echo ""
