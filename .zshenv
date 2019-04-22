#####################
### Env Variables ###
#####################

# PATH の設定（お好みで）
PATH=$PATH:$HOME/bin

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITORP=vim
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.ndenv/bin:$PATH"
export XDG_CONFIG_HOME=$HOME/.config
export PGDATA='/usr/local/var/postgres'
export PATH="/usr/local/opt/openssl/bin:$PATH"
export RAILS_ENV=development
export ZPLUG_HOME=/usr/local/opt/zplug
# For compilers to find mysql@5.7 you may need to set
export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
export PATH=/usr/local/opt/mysql@5.7/bin:${PATH}
export DYLD_LIBRARY_PATH=/usr/local/opt/mysql@5.7/:${DYLD_LIBRARY_PATH}
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