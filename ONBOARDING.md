# CLI Tools Guide

Comprehensive guide to the CLI tools installed in this environment.

## Table of Contents

0. [Ghostty - Terminal Emulator](#ghostty---terminal-emulator)
1. [eza - Enhanced Directory Listing](#eza---enhanced-directory-listing)
2. [bat - Syntax-Highlighted File Viewer](#bat---syntax-highlighted-file-viewer)
3. [fzf - Fuzzy Finder](#fzf---fuzzy-finder)
4. [zoxide - Smart Directory Navigation](#zoxide---smart-directory-navigation)
5. [fd - Fast File Finder](#fd---fast-file-finder)
6. [ripgrep - Fast Text Search](#ripgrep---fast-text-search)
7. [delta - Enhanced Git Diff](#delta---enhanced-git-diff)
8. [btop - System Monitor](#btop---system-monitor)
9. [ghq - Repository Manager](#ghq---repository-manager)
10. [jq - JSON Processor](#jq---json-processor)
11. [Workflow Examples](#workflow-examples)

---

## Ghostty - Terminal Emulator

Modern, GPU-accelerated terminal emulator configured for multi-agent development workflows.

### Configuration

- **Theme**: Nord (dark blue color scheme)
- **Font**: Hack Nerd Font 13pt
- **Tab Bar**: Always visible with directory-based titles
- **Shell Integration**: Automatic tab title updates

### Tab Management

```bash
# Create new tab
Cmd+T

# Close tab
Cmd+W

# Switch tabs
Cmd+1 through Cmd+9

# Next/previous tab
Cmd+Shift+]  # Next
Cmd+Shift+[  # Previous
```

### Split Panes

**Default shortcuts:**
```bash
# Create splits
Cmd+D              # Horizontal split
Cmd+Shift+D        # Vertical split
```

**Vim-style shortcuts (custom):**
```bash
# Navigate splits
Opt+h              # Move to left split
Opt+j              # Move to bottom split
Opt+k              # Move to top split
Opt+l              # Move to right split

# Create splits
Opt+Shift+h        # New split on left
Opt+Shift+j        # New split below
Opt+Shift+k        # New split above
Opt+Shift+l        # New split on right
```

### Project Color Identification

Since tabs cannot have different background colors, use prompt colors to identify projects:

```bash
# Set prompt colors for current tab
pc red             # Project A (red theme)
pc green           # Project B (green theme)
pc blue            # Project C (blue theme)
pc yellow          # Project D (yellow theme)
pc magenta         # Project E (magenta theme)
pc cyan            # Project F (cyan theme)
pc default         # Reset to default (cyan/purple)
```

**Usage pattern:**
```bash
# Tab 1: Project A
cd ~/Projects/project-a
pc red
# Now directory and git branch show in red

# Tab 2: Project B (new tab with Cmd+T)
cd ~/Projects/project-b
pc green
# Now directory and git branch show in green
```

### Tab Titles

Tab titles automatically update to show current directory thanks to shell integration:

- Short directory name when in deep paths
- Full path expansion with `~` notation
- Updates on `cd` command automatically

### Multi-Agent Workflows

**Scenario 1: Multiple projects in tabs**
```bash
# Tab 1: Frontend project
cd ~/Projects/frontend
pc blue
# Run Claude Code agent for frontend

# Tab 2: Backend project
cd ~/Projects/backend
pc green
# Run Claude Code agent for backend

# Tab 3: Database work
cd ~/Projects/database
pc red
# Run queries, migrations
```

**Scenario 2: Same project, multiple agents in splits**
```bash
# Main pane
cd ~/Projects/myapp
pc yellow
# Run main development agent

# Split pane (Cmd+D)
# Run testing agent in same directory
npm test --watch

# Another split (Opt+Shift+l)
# Run build watcher
npm run dev
```

### Configuration File

Location: `~/.config/ghostty/config` (symlinked from `~/.dotfiles/.config/ghostty/config`)

Edit configuration:
```bash
nvim ~/.config/ghostty/config
```

After editing, reload:
```bash
# Cmd+Shift+, (in Ghostty)
# Or restart Ghostty
```

### Customization Options

**Change opacity:**
```
background-opacity = 0.95  # 95% opacity (5% transparent)
background-blur = 20       # Blur background
```

**Change tab position:**
```
tab-bar-position = top     # or bottom
```

**Disable splits:**
```
# Remove keybind lines for splits if not needed
```

**Change font size:**
```
font-size = 14  # Increase to 14pt
```

### Integration with Starship

Ghostty works seamlessly with Starship prompt (already configured in `~/.dotfiles/starship.toml`):

- Directory shown with icons and colors
- Git branch with status indicators
- Command duration for long-running commands
- Language version detection (Node, Python, Ruby, etc.)

The `pc` command modifies Starship colors via environment variables.

### Troubleshooting

**Tab titles not updating:**
```bash
# Check shell integration
echo $GHOSTTY_SHELL_INTEGRATION

# Should output: 1
# If empty, shell integration is not active
```

**Font not rendering correctly:**
```bash
# Verify Hack Nerd Font is installed
fc-list | grep -i "hack nerd"

# Should show multiple font files
# If empty, install via Homebrew:
brew install font-hack-nerd-font
```

**Colors look wrong:**
```bash
# Check theme setting
cat ~/.config/ghostty/config | grep theme

# Should show: theme = dark:Nord,light:Nord Light
```

### Documentation

- [Ghostty Official Docs](https://ghostty.org/docs)
- [Configuration Reference](https://ghostty.org/docs/config/reference)
- [Keybindings](https://ghostty.org/docs/config/keybind)

---

## eza - Enhanced Directory Listing

Replacement for `ls` with colors, icons, and git integration.

### Aliases

```bash
ls      # eza --icons --git
la      # eza --icons --git -a (all files)
ll      # eza --icons --git -l (long format)
lla     # eza --icons --git -la (long + all)
lt      # eza --icons --git --tree (tree view)
```

### Basic Usage

```bash
# Standard listing
ls

# Show hidden files
la

# Long format with details
ll

# All files in long format
lla

# Tree view
lt
```

### Advanced Usage

```bash
# Tree with depth limit
eza --tree --level=2

# Sort by modification time
eza -l --sort=modified

# Sort by size
eza -l --sort=size

# Show only directories
eza -D

# Show file headers
eza -lh --header

# Show git ignored files
eza -la --git-ignore

# Show extended attributes and metadata
eza -l@ --extended
```

### Output Columns

When using `-l` flag:

- Permissions
- Links count
- Owner
- Group
- Size
- Modified time
- Git status
- Name

### Documentation

[eza GitHub](https://github.com/eza-community/eza)

---

## bat - Syntax-Highlighted File Viewer

Replacement for `cat` with syntax highlighting and line numbers.

### Aliases

```bash
cat     # bat --style=auto
ccat    # /bin/cat (original cat)
```

### Basic Usage

```bash
# View file with syntax highlighting
cat file.js

# Use original cat
ccat file.txt
```

### Advanced Usage

```bash
# Show specific line range
bat -r 10:20 file.py

# Show only line numbers and changes
bat --style=numbers,changes file.rb

# Show line numbers only
bat -n file.ts

# Plain output (no decorations)
bat --style=plain file.txt

# Output to pager
bat --paging=always large_file.log

# Disable paging
bat --paging=never file.md

# Show non-printable characters
bat -A file.txt

# Multiple files
bat file1.txt file2.txt
```

### Themes

```bash
# List available themes
bat --list-themes

# Use specific theme
bat --theme="Solarized (dark)" file.json

# Preview all themes
bat --list-themes | fzf --preview="bat --theme={} --color=always file.js"
```

Default theme is set in `.zshrc`:

```bash
export BAT_THEME="Monokai Extended"
```

### Integration with Other Tools

```bash
# With fzf preview
fzf --preview 'bat --color=always {}'

# With find
find . -name "*.js" -exec bat {} \;

# With tail for logs
tail -f /var/log/system.log | bat --paging=never -l log
```

### Documentation

[bat GitHub](https://github.com/sharkdp/bat)

---

## fzf - Fuzzy Finder

Interactive fuzzy finder for files, command history, and more.

### Key Bindings

- `Ctrl+T`: Find files in current directory
- `Ctrl+R`: Search command history
- `Alt+C`: Find and cd to directory

### Basic Usage

```bash
# Find and edit file
nvim $(fzf)

# Find and cd
cd $(fd --type d | fzf)

# Kill process
kill -9 $(ps aux | fzf | awk '{print $2}')

# Git checkout branch
git branch | fzf | xargs git checkout

# SSH to host
ssh $(grep "Host " ~/.ssh/config | awk '{print $2}' | fzf)
```

### Preview Window

- Default: Right side, 60% width
- Toggle: `Ctrl+/`
- Scroll: `Shift+Up/Down` or mouse wheel

### Configuration

Set in `.zshrc`:

```bash
# Use fd for file search
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Use fd for Ctrl+T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Use fd for Alt+C
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
```

### Advanced Usage

```bash
# Multi-select with Tab
fzf --multi

# Custom preview
fzf --preview 'head -100 {}'

# Preview for images
fzf --preview 'imgcat {}'

# Change preview position
fzf --preview 'bat {}' --preview-window=up:60%

# Reverse layout
fzf --reverse

# Full screen
fzf --height 100%

# Custom prompt
fzf --prompt="Select file: "
```

### Search Syntax

- `'word`: Exact match
- `^word`: Prefix match
- `word$`: Suffix match
- `!word`: Inverse match
- `'word1 word2`: AND operator
- `word1 | word2`: OR operator

### Examples

```bash
# Find and delete files
fd | fzf --multi | xargs rm

# Find and copy files
fd | fzf --multi | xargs -I {} cp {} /dest/

# Find and open in browser
fd -e html | fzf | xargs open

# Find git commits
git log --oneline | fzf | awk '{print $1}' | xargs git show

# Find and checkout git commit
git log --oneline | fzf | awk '{print $1}' | xargs git checkout
```

### Documentation

[fzf GitHub](https://github.com/junegunn/fzf)

---

## zoxide - Smart Directory Navigation

Tracks frequently used directories and allows quick jumping.

### Aliases

```bash
cd      # Aliased to zoxide (z command)
```

### Basic Usage

```bash
# Jump to directory
cd project

# Interactive selection (if multiple matches)
z project

# Jump to subdirectory
z proj doc

# Use full path
z /full/path
```

### Advanced Usage

```bash
# Add directory manually
zoxide add /path/to/dir

# Remove directory
zoxide remove /path/to/dir

# Query database
zoxide query project

# Query with score
zoxide query --list

# Interactive query
zoxide query -i

# Edit database directly
zoxide edit
```

### How It Works

1. Tracks directories you visit
2. Ranks them by "frecency" (frequency + recency)
3. Allows jumping using partial matches

### Examples

```bash
# After visiting ~/Documents/work/myproject several times
cd ~/Documents/work/myproject

# Later, from anywhere:
cd myproject        # Jumps to ~/Documents/work/myproject

# Partial match:
cd mypr             # Also works

# Subdirectory:
cd work proj        # Matches "work" and "project"
```

### Integration

Automatically shows directory tree after cd (via `chpwd` function in `.zshrc`).

### Documentation

[zoxide GitHub](https://github.com/ajeetdsouza/zoxide)

---

## fd - Fast File Finder

Replacement for `find` with simpler syntax and better performance.

### Basic Usage

```bash
# Find files by name
fd pattern

# Find in specific directory
fd pattern /path/to/search

# Find only files
fd --type f pattern

# Find only directories
fd --type d pattern

# Case-insensitive
fd -i pattern

# Include hidden files
fd -H pattern

# Exclude patterns
fd pattern --exclude node_modules
```

### Advanced Usage

```bash
# Find by extension
fd -e js
fd -e py -e rb

# Find by size
fd --size +100m          # Larger than 100MB
fd --size -1k            # Smaller than 1KB

# Find by modification time
fd --changed-within 1d   # Last 24 hours
fd --changed-before 1w   # More than 1 week ago

# Follow symlinks
fd -L pattern

# Max depth
fd --max-depth 3 pattern

# Execute command
fd pattern --exec rm {}

# Execute with placeholder
fd -e jpg --exec convert {} {.}.png

# Execute batch
fd -e log --exec-batch rm
```

### Examples

```bash
# Find all JavaScript files
fd '.js$'

# Find all files in current dir only
fd --max-depth 1

# Find empty files
fd --type f --size 0

# Find and count
fd -e js | wc -l

# Find and archive
fd -e log | tar -czf logs.tar.gz -T -

# Find large files
fd --size +100m --exec ls -lh

# Find recently modified
fd --changed-within 1h
```

### Integration with fzf

```bash
# Find and preview
fd | fzf --preview 'bat --color=always {}'

# Find directories and cd
cd $(fd --type d | fzf)
```

### Documentation

[fd GitHub](https://github.com/sharkdp/fd)

---

## ripgrep - Fast Text Search

Replacement for `grep` with better performance and usability.

### Aliases

```bash
grep    # Aliased to ripgrep (rg)
```

### Basic Usage

```bash
# Search for pattern
rg pattern

# Search in specific files
rg pattern file1.txt file2.txt

# Search in specific directory
rg pattern /path/to/dir

# Case-insensitive
rg -i pattern

# Whole word match
rg -w pattern

# Show line numbers (default)
rg pattern
```

### File Type Filtering

```bash
# Search in JavaScript files
rg -t js pattern

# Search in Python files
rg -t py pattern

# Multiple types
rg -t js -t ts pattern

# Exclude type
rg -T js pattern

# List supported types
rg --type-list
```

### Context and Output

```bash
# Show context (3 lines before and after)
rg -C 3 pattern

# Show N lines before
rg -B 5 pattern

# Show N lines after
rg -A 5 pattern

# Show only filenames
rg -l pattern

# Show only count
rg -c pattern

# Show with column numbers
rg --column pattern

# No line numbers
rg -N pattern
```

### Advanced Usage

```bash
# Regex search
rg 'pattern.*other'

# Multiple patterns (OR)
rg 'pattern1|pattern2'

# Exclude directories
rg pattern -g '!node_modules'

# Include only specific files
rg pattern -g '*.js'

# Hidden files
rg --hidden pattern

# Follow symlinks
rg -L pattern

# Multiline search
rg -U 'pattern.*\n.*other'

# Fixed string (no regex)
rg -F 'literal.string'

# Word boundary
rg '\bword\b'
```

### Replace Preview

```bash
# Preview replacement (doesn't modify)
rg pattern -r replacement

# With color
rg pattern -r replacement --color=always
```

### Examples

```bash
# Find TODO comments
rg 'TODO|FIXME|XXX'

# Find function definitions
rg 'fn \w+' -t rust

# Find imports
rg '^import' -t js

# Find with context
rg -C 5 'error'

# Find and show stats
rg pattern --stats

# Find in specific files
rg pattern -g '*.{js,ts}'

# Exclude multiple directories
rg pattern -g '!{node_modules,dist,build}'

# Find non-ASCII characters
rg '[^\x00-\x7F]'
```

### Performance

ripgrep is optimized for speed:

- Respects `.gitignore` by default
- Uses multiple threads
- Skips binary files
- Memory-mapped I/O

### Documentation

[ripgrep GitHub](https://github.com/BurntSushi/ripgrep)

---

## delta - Enhanced Git Diff

Syntax-highlighted diff viewer with side-by-side mode.

### Configuration

Configured in `.gitconfig`:

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    side-by-side = true
    line-numbers = true
    syntax-theme = Monokai Extended
```

### Usage

Delta is automatically used for:

```bash
# View diff
git diff

# View staged changes
git diff --staged

# View specific commit
git show <commit>

# View log with patches
git log -p

# Interactive add
git add -p
```

### Navigation

- `n`: Next diff section
- `N`: Previous diff section
- `q`: Quit pager
- `/`: Search forward
- `?`: Search backward

### Features

- Syntax highlighting
- Side-by-side view
- Line numbers
- Within-line highlights
- Git integration
- Hyperlinks support

### Customization

Edit `.gitconfig`:

```ini
[delta]
    side-by-side = false      # Disable side-by-side
    line-numbers = false      # Disable line numbers
    navigate = true           # Enable n/N navigation
    light = true              # Use light theme
    syntax-theme = GitHub     # Change theme
```

Available themes:

```bash
git config --list | grep delta
```

### Documentation

[delta GitHub](https://github.com/dandavison/delta)

---

## btop - System Monitor

Resource monitor with beautiful interface.

### Basic Usage

```bash
# Launch btop
btop
```

### Key Bindings

- `q`: Quit
- `h`: Help
- `m`: Menu
- `t`: Toggle tree view
- `k`: Kill selected process
- `+/-`: Increase/decrease update interval
- `f`: Filter processes
- `Tab`: Next box
- `Shift+Tab`: Previous box

### Features

- CPU usage graph
- Memory usage graph
- Disk usage
- Network usage
- Process management
- Tree view
- Sorting options
- Search/filter

### Monitoring

- CPU: Per-core usage, temperature
- Memory: Used, available, cached
- Disks: Read/write speed, usage
- Network: Upload/download speed
- Processes: CPU%, MEM%, PID, user, command

### Documentation

[btop GitHub](https://github.com/aristocratos/btop)

---

## ghq - Repository Manager

Manage multiple git repositories with consistent directory structure.

### Basic Usage

```bash
# Clone repository
ghq get https://github.com/user/repo
ghq get github.com/user/repo

# List repositories
ghq list

# Get repository root
ghq root

# Get repository path
ghq list --full-path

# Open repository in $EDITOR
ghq look repo-name
```

### Directory Structure

```
$(ghq root)/
  github.com/
    user1/
      repo1/
      repo2/
    user2/
      repo3/
  gitlab.com/
    user3/
      repo4/
```

Default root: `~/ghq`

### Configuration

Edit `~/.gitconfig`:

```ini
[ghq]
    root = ~/ghq
    root = ~/projects  # Multiple roots allowed
```

### Integration with fzf

Custom alias in `.zshrc`:

```bash
alias gr='ghq-fzf'

function ghq-fzf() {
    local repo=$(ghq list | fzf --preview "ls -la $(ghq root)/{}")
    if [ -n "$repo" ]; then
        cd $(ghq root)/$repo
    fi
}
```

Usage:

```bash
# Interactive repository selection
gr
```

### Examples

```bash
# Clone and cd
ghq get github.com/user/repo && cd $(ghq list --full-path | tail -1)

# Update all repositories
ghq list --full-path | xargs -n 1 -P 4 git -C fetch

# Find repository
ghq list | fzf

# Count repositories
ghq list | wc -l
```

### Documentation

[ghq GitHub](https://github.com/x-motemen/ghq)

---

## jq - JSON Processor

Parse, filter, and manipulate JSON data.

### Basic Usage

```bash
# Pretty-print
echo '{"name":"John"}' | jq '.'

# Extract field
echo '{"name":"John","age":30}' | jq '.name'

# Extract from array
echo '[1,2,3]' | jq '.[0]'

# Extract multiple fields
echo '{"name":"John","age":30}' | jq '.name, .age'
```

### Filtering

```bash
# Filter array
echo '[{"name":"John","age":30},{"name":"Jane","age":25}]' | jq '.[] | select(.age > 27)'

# Filter by field existence
jq '.[] | select(.email != null)' data.json

# Filter by type
jq '.[] | select(type == "string")' data.json
```

### Transforming

```bash
# Map transformation
echo '[{"name":"John","age":30}]' | jq '.[] | {name: .name}'

# Add field
echo '{"name":"John"}' | jq '.age = 30'

# Delete field
echo '{"name":"John","age":30}' | jq 'del(.age)'

# Rename field
echo '{"old":"value"}' | jq '{new: .old}'

# Array to object
echo '[{"key":"a","value":1}]' | jq 'map({(.key): .value}) | add'
```

### Array Operations

```bash
# Length
echo '[1,2,3]' | jq 'length'

# First/last element
echo '[1,2,3]' | jq 'first'
echo '[1,2,3]' | jq 'last'

# Map array
echo '[1,2,3]' | jq 'map(. * 2)'

# Filter array
echo '[1,2,3,4,5]' | jq 'map(select(. > 2))'

# Sort array
echo '[3,1,2]' | jq 'sort'

# Unique values
echo '[1,2,2,3]' | jq 'unique'

# Flatten array
echo '[[1,2],[3,4]]' | jq 'flatten'
```

### Combining Data

```bash
# Merge objects
echo '{"a":1}' | jq '. + {"b":2}'

# Merge arrays
echo '[1,2]' | jq '. + [3,4]'

# Merge multiple files
jq -s '.[0] * .[1]' file1.json file2.json

# Combine arrays from multiple files
jq -s 'add' file1.json file2.json
```

### Real-World Examples

```bash
# API response
curl -s https://api.github.com/users/octocat | jq '.name, .bio'

# Extract all URLs
curl -s https://api.github.com/users/octocat/repos | jq '.[].html_url'

# Count items
curl -s https://api.github.com/users/octocat/repos | jq 'length'

# Filter and transform
curl -s https://api.github.com/users/octocat/repos | \
  jq '.[] | select(.fork == false) | {name: .name, stars: .stargazers_count}'

# Package.json scripts
cat package.json | jq '.scripts'

# Docker containers
docker ps --format json | jq -r '.Names'

# AWS CLI output
aws ec2 describe-instances | jq '.Reservations[].Instances[] | {id: .InstanceId, type: .InstanceType}'
```

### Documentation

[jq Manual](https://stedolan.github.io/jq/manual/)

---

## Workflow Examples

### Example 1: Find and Edit Files

```bash
# Find file with preview and open in nvim
nvim $(fzf --preview 'bat --color=always {}')

# Find by extension
nvim $(fd -e js | fzf --preview 'bat --color=always {}')

# Find in specific directory
nvim $(fd . ~/projects | fzf --preview 'bat --color=always {}')
```

### Example 2: Search Code

```bash
# Find pattern
rg 'function.*getData'

# Find with context
rg -C 5 'TODO'

# Find in specific files
rg 'import' -t js

# Find and edit
nvim $(rg -l 'pattern' | fzf)
```

### Example 3: Navigate Repositories

```bash
# Clone repository
ghq get github.com/user/repo

# Interactive selection
gr

# Or use zoxide
cd repo-name
```

### Example 4: Git Workflow

```bash
# Check status
git status

# View diff with delta
git diff

# Interactive staging
git add -p

# Commit
git commit -m "message"

# View log with graph
git log --oneline --graph

# Checkout branch with fzf
git branch | fzf | xargs git checkout

# Open in browser
git open
```

### Example 5: Process Management

```bash
# Monitor system
btop

# Find process
ps aux | fzf

# Kill process
kill -9 $(ps aux | fzf | awk '{print $2}')
```

### Example 6: File Operations

```bash
# Find large files
fd --size +100m -x eza -l

# Find and delete
fd -e log | fzf --multi | xargs rm

# Find and move
fd -e jpg | fzf --multi | xargs -I {} mv {} ~/Pictures/

# Find and compress
fd -e log --changed-before 30d | tar -czf old_logs.tar.gz -T -
```

### Example 7: JSON Operations

```bash
# Pretty-print API response
curl -s api.example.com/data | jq '.'

# Extract specific fields
curl -s api.example.com/users | jq '.[] | {name, email}'

# Filter and count
curl -s api.example.com/users | jq '[.[] | select(.active == true)] | length'

# Save to file
curl -s api.example.com/data | jq '.' > data.json

# Merge multiple sources
jq -s 'add' source1.json source2.json > merged.json
```

### Example 8: Batch Operations

```bash
# Rename multiple files
fd -e txt | while read file; do mv "$file" "${file%.txt}.md"; done

# Convert images
fd -e jpg --exec convert {} {.}.png

# Update git repositories
ghq list --full-path | xargs -n 1 -P 4 git -C fetch --all

# Find and replace in multiple files
rg 'old_pattern' -l | xargs sed -i '' 's/old_pattern/new_pattern/g'
```

---

## Tips and Tricks

### Combining Tools

```bash
# fd + fzf + bat
fd | fzf --preview 'bat --color=always {}'

# rg + fzf + nvim
rg -l pattern | fzf --preview 'rg --color=always -C 3 pattern {}' | xargs nvim

# ghq + fzf + zoxide
cd $(ghq list --full-path | fzf)

# ps + fzf + kill
ps aux | fzf | awk '{print $2}' | xargs kill -9
```

### Shell Functions

Add to `~/.zshrc.local`:

```bash
# Find and cd to directory
function fcd() {
    cd $(fd --type d | fzf)
}

# Find and edit file
function fe() {
    nvim $(fzf)
}

# Search and edit
function se() {
    nvim $(rg -l "$1" | fzf)
}

# Git branch selection
function gb() {
    git branch | fzf | xargs git checkout
}
```

### Performance Tips

1. Use `.gitignore` (respected by rg and fd by default)
2. Limit search depth with `--max-depth`
3. Use file type filters (`-t` in rg, `-e` in fd)
4. Use `--threads` to control parallelism
5. Cache frequently accessed data

---

## Additional Resources

- [eza](https://github.com/eza-community/eza)
- [bat](https://github.com/sharkdp/bat)
- [fzf](https://github.com/junegunn/fzf)
- [fzf examples](https://github.com/junegunn/fzf/wiki/examples)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [ripgrep guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
- [delta](https://github.com/dandavison/delta)
- [btop](https://github.com/aristocratos/btop)
- [ghq](https://github.com/x-motemen/ghq)
- [jq manual](https://stedolan.github.io/jq/manual/)
- [jq playground](https://jqplay.org/)
