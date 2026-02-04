# Modern Zsh Configuration
# Homebrew and anyenv are initialized in .zshenv to work with login shells

#######################
### Build Tool Flags ##
#######################

export CXXFLAGS="-stdlib=libc++ -std=c++11 -I$(xcrun --show-sdk-path)/usr/include/c++/v1"
export CPPFLAGS="-I$(brew --prefix)/include"
export LDFLAGS="-L$(brew --prefix)/lib"
export PKG_CONFIG_PATH="$(brew --prefix)/lib/pkgconfig"

##################
### Completion ###
##################

# Add Homebrew's zsh-completions to fpath
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
fi

# Initialize completion system before loading plugins
autoload -Uz compinit && compinit

################
### Sheldon ####
################

# Plugin manager for Zsh (https://sheldon.cli.rs/)
eval "$(sheldon source)"

#################
### Starship ####
#################

# Cross-shell prompt (https://starship.rs/)
eval "$(starship init zsh)"

###############
### setopts ###
###############

setopt always_last_prompt      # Preserve cursor position during completion
setopt auto_cd                 # cd to directory if command matches directory name
setopt auto_list               # List completion candidates
setopt auto_menu               # Use menu completion
setopt auto_param_keys         # Auto-complete parentheses
setopt auto_param_slash        # Add trailing slash to directory names
setopt auto_pushd              # Push directories onto stack
setopt complete_in_word        # Complete from cursor position
setopt correct                 # Correct command spelling
setopt extended_glob           # Extended globbing
setopt extended_history        # Record timestamp in history
setopt globdots                # Match dotfiles without explicit dot
setopt hist_expand             # Expand history on completion
setopt hist_ignore_dups        # Ignore duplicate commands
setopt hist_ignore_all_dups    # Remove older duplicates
setopt hist_ignore_space       # Ignore commands starting with space
setopt hist_no_store           # Don't store history command in history
setopt hist_verify             # Allow editing before execution
setopt hist_reduce_blanks      # Remove extra whitespace
setopt hist_save_no_dups       # Don't save duplicate commands
setopt ignoreeof               # Prevent Ctrl-D logout
setopt inc_append_history      # Append to history incrementally
setopt interactive_comments    # Allow comments in interactive shell
setopt list_types              # Show file type indicators
setopt magic_equal_subst       # Enable completion after = in arguments
setopt mark_dirs               # Add trailing slash to directory matches
setopt nobeep                  # Disable beep
setopt notify                  # Report background job status immediately
setopt print_eight_bit         # Enable 8-bit characters
setopt pushd_ignore_dups       # Don't push duplicates onto directory stack
setopt share_history           # Share history across sessions
setopt transient_rprompt       # Remove right prompt after command execution

# Tab key triggers menu completion
bindkey "^I" menu-complete

#########################
### Completion Styles ###
#########################

# Highlight completion candidates
zstyle ':completion:*:default' menu select=2

# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Detailed completion display
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'
zstyle ':completion:*:warnings' format '%F{RED}No matches for: %F{YELLOW}%d'
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'
zstyle ':completion:*:options' description 'yes'

# Group completion candidates by type
zstyle ':completion:*' group-name ''

# Completion display settings
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directory completion
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' ignore-parents parent pwd ..

######################
### History Search ###
######################

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

###################
### CDR Command ###
###################

# Persistent directory history
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-default true

####################
### SSH Completion ###
####################

function print_known_hosts() {
    if [ -f $HOME/.ssh/known_hosts ]; then
        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
    fi
}
_cache_hosts=($( print_known_hosts ))

function _ssh {
    compadd $(fgrep 'Host ' ~/.ssh/*/config 2>/dev/null | grep -v '*' | awk '{print $2}' | sort)
}

########################
### Word Style Config ###
########################

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

# Ctrl-W deletes path segments by slash
autoload -U select-word-style
select-word-style bash

# Ctrl-[ inserts last word from previous command
autoload -Uz smart-insert-last-word
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
zle -N insert-last-word smart-insert-last-word
bindkey '^[' insert-last-word

#####################
### Modern CLI Tools ###
#####################

# eza - Modern ls replacement (https://github.com/eza-community/eza)
if command -v eza &> /dev/null; then
    alias ls='eza --icons --git'
    alias la='eza --icons --git -a'
    alias ll='eza --icons --git -l'
    alias lla='eza --icons --git -la'
    alias lt='eza --icons --git --tree'
else
    alias ls='ls -aF'
    alias ll='ls -l'
fi

# bat - Cat with syntax highlighting (https://github.com/sharkdp/bat)
if command -v bat &> /dev/null; then
    alias cat='bat --style=auto'
    alias ccat='/bin/cat'  # Original cat
    export BAT_THEME="Monokai Extended"
else
    alias cat='cat -n'
fi

# fzf - Fuzzy finder (https://github.com/junegunn/fzf)
if command -v fzf &> /dev/null; then
    # Auto-completion
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    # fzf configuration
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_DEFAULT_OPTS='
        --height 40%
        --layout=reverse
        --border
        --inline-info
        --preview "bat --color=always --style=numbers --line-range=:500 {}"
        --preview-window=right:60%:wrap
        --bind "ctrl-/:toggle-preview"
        --color=dark
        --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
        --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
    '
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

    # Ctrl-R: History search with fzf
    function fzf-history-widget() {
        local selected
        selected=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | fzf --query="$LBUFFER")
        if [ -n "$selected" ]; then
            BUFFER=$selected
            CURSOR=${#BUFFER}
        fi
        zle reset-prompt
    }
    zle -N fzf-history-widget
    bindkey '^R' fzf-history-widget
fi

# zoxide - Smarter cd command (https://github.com/ajeetdsouza/zoxide)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    # Override cd with zoxide
    alias cd='z'

    # Show directory tree after cd (if tree is available)
    if command -v tree &> /dev/null; then
        function chpwd() {
            tree -L 1 -C
        }
    fi
fi

# fd - Modern find replacement (https://github.com/sharkdp/fd)
if command -v fd &> /dev/null; then
    alias find='fd'
fi

# ripgrep - Fast grep replacement (https://github.com/BurntSushi/ripgrep)
if command -v rg &> /dev/null; then
    alias grep='rg'
fi

# delta - Better git diff (configured in .gitconfig)
# btop - Modern top replacement

###############
### Aliases ###
###############

# Basic command safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Editor
alias vi='nvim'
alias vim='nvim'

# Less
alias less='less -NM'

# Archive extraction
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=aunpack

# Multi-level cd
alias ...='cd ../..'
alias ....='cd ../../..'

# Python
alias python='python3'
alias pip='pip3'

# Git shortcuts (additional to git-aliases.zsh plugin)
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

####################
### Path Settings ###
####################

# System paths (append to preserve anyenv shims priority)
export PATH="$PATH:/usr/local/sbin"

# Database
# MySQL latest version
export PATH="$PATH:$(brew --prefix mysql)/bin"

# Java (jenv managed by anyenv)
export PATH="$PATH:$HOME/.jenv/bin"

# Rancher Desktop
export PATH="$PATH:/Users/kihira.hiromu/.rd/bin"

###########################
### Environment Variables ###
###########################

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# GitHub Packages token
# IMPORTANT: Set this in ~/.zshrc.local (not version controlled)
# export BUNDLE_RUBYGEMS__PKG__GITHUB__COM=your_token_here

##################
### direnv Setup ###
##################

# Automatic environment switching
eval "$(direnv hook zsh)"

##################
### Functions ####
##################

# ghq + fzf: Repository navigation
if command -v ghq &> /dev/null && command -v fzf &> /dev/null; then
    function ghq-fzf() {
        local repo=$(ghq list | fzf --preview "ls -la $(ghq root)/{}")
        if [ -n "$repo" ]; then
            cd $(ghq root)/$repo
        fi
    }
    alias gr='ghq-fzf'
fi

# Show directory size
function dsize() {
    du -sh ${1:-.}
}

# Create directory and cd into it
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract archives automatically
function extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#################
### Local Config ###
#################

# Load local configuration if it exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
