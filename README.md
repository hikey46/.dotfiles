# Dotfiles

Personal dotfiles for productive CLI environment on macOS.

## Features

- **Shell**: Zsh with Sheldon plugin manager
- **Prompt**: Starship cross-shell prompt
- **CLI Tools**: eza, bat, fzf, zoxide, fd, ripgrep, delta, btop
- **Git**: Enhanced with delta diff viewer
- **Version Management**: anyenv for unified language version management

## Requirements

- macOS (Apple Silicon or Intel)
- Xcode Command Line Tools

## Installation

### Quick Setup

```bash
# Clone repository
git clone https://github.com/hikey46/.dotfiles.git ~/.dotfiles

# Run setup script
cd ~/.dotfiles
./setup.sh

# Restart terminal
exec $SHELL -l
```

### Manual Setup

If you prefer to install components manually:

#### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

For Apple Silicon, add to `~/.zprofile`:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### 2. Install Packages

```bash
cd ~/.dotfiles
brew bundle --file=Brewfile
```

#### 3. Setup fzf

```bash
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
```

#### 4. Create Symlinks

```bash
cd ~/.dotfiles
for file in .zshrc .zshenv .gitconfig .tmux.conf; do
    ln -sf "$PWD/$file" "$HOME/$file"
done
```

#### 5. Setup Sheldon

```bash
# XDG_CONFIG_HOME is set to ~/.dotfiles in .zshenv
# Sheldon will automatically use ~/.dotfiles/sheldon/plugins.toml
sheldon lock
```

#### 6. Setup Starship

```bash
mkdir -p ~/.config
ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml
```

#### 7. Setup anyenv

```bash
anyenv install --init
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
```

#### 8. Change Default Shell

```bash
chsh -s $(which zsh)
```

## Structure

```
~/.dotfiles/
├── README.md              # This file
├── ONBOARDING.md          # CLI tools guide
├── Brewfile               # Homebrew packages
├── setup.sh               # Automated setup script
├── .zshrc                 # Zsh configuration
├── .zshenv                # Zsh environment variables
├── .gitconfig             # Git configuration
├── .tmux.conf             # Tmux configuration
├── starship.toml          # Starship prompt configuration
├── sheldon/
│   └── plugins.toml       # Sheldon plugins configuration
├── gh/                    # GitHub CLI configuration
├── configstore/           # Node.js tools configuration store
└── anyenv/                # anyenv data (git-ignored)
```

## Post-Installation

### Install Language Runtimes

Using anyenv, you can install various language version managers:

```bash
# Ruby
anyenv install rbenv
exec $SHELL -l
rbenv install 3.2.0
rbenv global 3.2.0

# Node.js
anyenv install nodenv
exec $SHELL -l
nodenv install 20.10.0
nodenv global 20.10.0

# Python
anyenv install pyenv
exec $SHELL -l
pyenv install 3.11.7
pyenv global 3.11.7

# Go
anyenv install goenv
exec $SHELL -l
goenv install 1.21.5
goenv global 1.21.5
```

### Customize Prompt

Edit `~/.config/starship.toml`:

```bash
nvim ~/.config/starship.toml
```

See [Starship documentation](https://starship.rs/config/) for configuration options.

### Customize Plugins

Edit `~/.dotfiles/sheldon/plugins.toml`:

```bash
nvim ~/.dotfiles/sheldon/plugins.toml
```

After editing, run:

```bash
sheldon lock
exec $SHELL -l
```

## CLI Tools Guide

For detailed guide on using the installed CLI tools, see [ONBOARDING.md](./ONBOARDING.md).

**Quick Reference:**

- `ls` → `eza`: Enhanced directory listing with icons and git status
- `cat` → `bat`: Syntax-highlighted file viewer
- `cd` → `zoxide`: Smart directory jumping
- `find` → `fd`: Fast and user-friendly file finder
- `grep` → `rg`: Extremely fast text search
- `Ctrl+R`: fzf history search
- `Ctrl+T`: fzf file finder
- `Alt+C`: fzf directory navigation

## Key Bindings

### Zsh

- `Ctrl+R`: Fuzzy command history search (fzf)
- `Ctrl+T`: Fuzzy file search (fzf)
- `Alt+C`: Fuzzy directory search (fzf)
- `Ctrl+P`: Previous command in history (matching prefix)
- `Ctrl+N`: Next command in history (matching prefix)
- `Ctrl+W`: Delete word backward (by path segment)
- `Ctrl+[`: Insert last word from previous command

### Tmux

- Prefix: `Ctrl+Q` (instead of default `Ctrl+B`)
- `Prefix + |`: Split pane vertically
- `Prefix + -`: Split pane horizontally
- `Prefix + h/j/k/l`: Navigate panes (Vim-style)
- `Prefix + Ctrl+h/l`: Navigate windows
- `Prefix + r`: Reload configuration

### Git

- `n`/`N`: Navigate diff sections (in delta)
- `Ctrl+/`: Toggle preview (in fzf)

## Aliases

### General

```bash
rm='rm -i'           # Interactive deletion
cp='cp -i'           # Interactive copy
mv='mv -i'           # Interactive move
vi='nvim'            # Use Neovim
vim='nvim'           # Use Neovim
...='cd ../..'       # Go up 2 directories
....='cd ../../..'   # Go up 3 directories
```

### eza (ls replacement)

```bash
ls='eza --icons --git'
la='eza --icons --git -a'
ll='eza --icons --git -l'
lla='eza --icons --git -la'
lt='eza --icons --git --tree'
```

### bat (cat replacement)

```bash
cat='bat --style=auto'
ccat='/bin/cat'  # Original cat
```

### Git

```bash
g='git'
gs='git status'
ga='git add'
gc='git commit'
gp='git push'
gl='git pull'
gd='git diff'
gco='git checkout'
gb='git branch'
glog='git log --oneline --graph --decorate'
```

### Other

```bash
python='python3'
pip='pip3'
gr='ghq-fzf'  # Interactive repository selection
```

## Customization

### Local Configuration

For machine-specific settings, create `~/.zshrc.local`:

```bash
# Example: ~/.zshrc.local
export CUSTOM_VAR="value"
alias custom='echo "custom alias"'
```

This file is automatically loaded by `.zshrc` if it exists.

### Environment Variables

Edit `~/.zshenv` for environment variables that should be available in all shells.

## Troubleshooting

### Shell Not Loading New Configuration

```bash
exec $SHELL -l
```

### Homebrew Command Not Found (Apple Silicon)

Add to `~/.zprofile`:

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Plugins Not Loading

```bash
sheldon lock
exec $SHELL -l
```

### Starship Not Showing

Check if initialized in `.zshrc`:

```bash
grep starship ~/.zshrc
```

### fzf Key Bindings Not Working

Reinstall fzf completions:

```bash
$(brew --prefix)/opt/fzf/install --key-bindings --completion --update-rc
exec $SHELL -l
```

## Maintenance

### Update Packages

```bash
# Update Homebrew and packages
brew update && brew upgrade

# Update Sheldon plugins
sheldon lock --update
```

### Update anyenv and Language Versions

```bash
# Update anyenv
anyenv update

# Update specific version manager (e.g., rbenv)
anyenv install --force rbenv
```

### Backup

The setup script automatically creates backups of existing dotfiles in:

```
~/.dotfiles_backup_YYYYMMDD_HHMMSS/
```

## Contributing

This is a personal dotfiles repository, but feel free to fork and adapt to your needs.

## License

MIT

## Author

HiromuKihira (h.kihira.9246@gmail.com)
