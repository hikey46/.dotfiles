#!/bin/bash

# Modern Dotfiles Setup Script
# Automates the setup of a modern CLI environment on macOS

set -e  # Exit on error

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "=================================================="
echo "  Modern Dotfiles Setup"
echo "=================================================="
echo ""

# Function to print step messages
print_step() {
    echo ""
    echo ">>> $1"
    echo "----------------------------------------"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Check if running on macOS
print_step "Checking system compatibility"
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script is designed for macOS only"
    exit 1
fi
echo "✓ macOS detected"

# 2. Install Xcode Command Line Tools
print_step "Installing Xcode Command Line Tools"
if xcode-select -p >/dev/null 2>&1; then
    echo "✓ Xcode Command Line Tools already installed"
else
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Please complete the installation and run this script again"
    exit 0
fi

# 3. Install Homebrew
print_step "Installing Homebrew"
if command_exists brew; then
    echo "✓ Homebrew already installed"
    echo "Updating Homebrew..."
    brew update
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# 4. Install packages from Brewfile
print_step "Installing packages from Brewfile"
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    cd "$DOTFILES_DIR"
    brew bundle --file=Brewfile
    echo "✓ Packages installed"
else
    echo "Warning: Brewfile not found at $DOTFILES_DIR/Brewfile"
fi

# 5. Setup fzf
print_step "Setting up fzf"
if command_exists fzf; then
    # Install useful key bindings and fuzzy completion
    if [ -f $(brew --prefix)/opt/fzf/install ]; then
        $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
        echo "✓ fzf key bindings and completion installed"
    fi
fi

# 6. Backup existing dotfiles
print_step "Backing up existing dotfiles"
mkdir -p "$BACKUP_DIR"
for file in .zshrc .zshenv .gitconfig .tmux.conf; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        echo "Backing up ~/$file to $BACKUP_DIR"
        mv "$HOME/$file" "$BACKUP_DIR/"
    fi
done
echo "✓ Backup completed at $BACKUP_DIR"

# 7. Create symlinks
print_step "Creating symlinks"
cd "$DOTFILES_DIR"
for file in .??*; do
    # Skip certain files
    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue

    target="$HOME/$file"

    if [ -e "$target" ]; then
        if [ -L "$target" ]; then
            echo "Removing existing symlink: $target"
            rm "$target"
        fi
    fi

    echo "Creating symlink: $target -> $DOTFILES_DIR/$file"
    ln -sf "$DOTFILES_DIR/$file" "$target"
done
echo "✓ Symlinks created"

# 8. Setup Sheldon
print_step "Setting up Sheldon"
if command_exists sheldon; then
    # XDG_CONFIG_HOME is set to ~/.dotfiles, so Sheldon will use ~/.dotfiles/sheldon/
    # No need to create symlinks

    # Lock plugins
    echo "Installing Sheldon plugins..."
    sheldon lock
    echo "✓ Sheldon configured"
else
    echo "Warning: Sheldon not installed"
fi

# 9. Setup Starship config
print_step "Setting up Starship"
if command_exists starship; then
    mkdir -p "$HOME/.config"

    # Create symlink for starship.toml
    if [ -f "$DOTFILES_DIR/starship.toml" ]; then
        echo "Creating symlink: ~/.config/starship.toml -> $DOTFILES_DIR/starship.toml"
        ln -sf "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
    fi
    echo "✓ Starship configured"
else
    echo "Warning: Starship not installed"
fi

# 10. Setup anyenv
print_step "Setting up anyenv"
if command_exists anyenv; then
    # Initialize anyenv
    if [ ! -d "$HOME/.anyenv" ]; then
        anyenv install --init
    fi

    # Install anyenv-update plugin
    if [ ! -d "$(anyenv root)/plugins/anyenv-update" ]; then
        mkdir -p "$(anyenv root)/plugins"
        git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"
    fi

    echo "✓ anyenv configured"
    echo "Note: Run 'exec $SHELL -l' to reload your shell and use anyenv"
else
    echo "Warning: anyenv not installed"
fi

# 11. Setup Zsh as default shell
print_step "Setting Zsh as default shell"
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
    echo "✓ Default shell changed to Zsh"
else
    echo "✓ Zsh is already the default shell"
fi

# 12. Setup Neovim
print_step "Setting up Neovim"
if command_exists nvim; then
    echo "✓ Neovim installed"
    echo "Note: You may want to install a Neovim plugin manager like vim-plug or lazy.nvim"
else
    echo "Warning: Neovim not installed"
fi

# 13. Final message
echo ""
echo "=================================================="
echo "  Setup Complete!"
echo "=================================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: exec \$SHELL -l"
echo "  2. Review the configuration in ~/.dotfiles/"
echo "  3. Check ~/.dotfiles/ONBOARDING.md for CLI tools guide"
echo ""
echo "Optional:"
echo "  - Install language versions via anyenv:"
echo "    anyenv install rbenv"
echo "    anyenv install nodenv"
echo "    anyenv install pyenv"
echo "  - Customize Starship prompt: ~/.config/starship.toml"
echo "  - Customize Sheldon plugins: ~/.config/sheldon/plugins.toml"
echo ""
echo "Backup of old dotfiles: $BACKUP_DIR"
echo ""
