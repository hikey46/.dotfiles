#####################
### Env Variables ###
#####################

# Note: Homebrew and anyenv are initialized in .zprofile
# (after /etc/zprofile's path_helper to avoid PATH being reset)

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export XDG_CONFIG_HOME=$HOME/.dotfiles
export PGDATA='/usr/local/var/postgres'
# MySQL (latest version via Homebrew)
# LDFLAGS and CPPFLAGS are set in .zshrc for all build tools
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

#############
### CONST ###
#############

# ディレクトリスタックの記憶数
DIRSTACKSIZE=100

# 色の定義
local DEFAULT=$'%{^[[m%}'$
local RED=$'%{^[[1;31m%}'$
local GREEN=$'%{^[[1;32m%}'$
local YELLOW=$'%{^[[1;33m%}'$
local BLUE=$'%{^[[1;34m%}'$
local PURPLE=$'%{^[[1;35m%}'$
local LIGHT_BLUE=$'%{^[[1;36m%}'$
local WHITE=$'%{^[[1;37m%}'$

# PATH の内容と同期している配列変数 path も使える
path=(
    ~/bin
    $path
)
