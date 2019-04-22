# Created by newuser for 5.7.1

#############
### CONST ###
#############

PATH=$PATH:$HOME/bin

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

#####################
### Env Variables ###
#####################

eval "$(rbenv init - zsh)"
eval "$(ndenv init - zsh)"

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
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
### zplug ###
#############

source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# theme (https://github.com/sindresorhus/pure#zplug)
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
# peco/fzf/percol/zaw などのラッパー関数を提供する。pecoとzshの連携のために
zplug "mollifier/anyframe"
# gitルートへcd
zplug "mollifier/cd-gitroot"
# jsonを扱うために
zplug "stedolan/jq", from:gh-r, as:command
# 移動強化
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "peco/peco", as:command, from:gh-r
zplug "b4b4r07/dotfiles", as:command, use:bin/peco-tmux
zplug "b4b4r07/zsh-gomi", as:command, use:bin
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# history関係
zplug "zsh-users/zsh-history-substring-search"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"

zplug "supercrabtree/k"

zplug "paulirish/git-open", as:plugin

zplug "zsh-users/zsh-syntax-highlighting", defer:2
: "cd先のディレクトリのファイル一覧を表示する" && {
  [ -z "$ENHANCD_ROOT" ] && function chpwd { tree -L 1 } # enhancdがない場合
  [ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="tree -L 1" # enhancdがあるときはそのHook機構を使う
}

: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' |  awk '{print $2}' | sort) }
}

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
  ¦ echo; zplug install
  fi
fi
# Then, source plugins and add commands to $PATH
zplug load --verbose

###############
### setopts ###
###############

# 補完に関するオプション
# http://voidy21.hatenablog.jp/entry/20090902/1251918174
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash      
# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs             
# 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt list_types            
# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu             
# カッコの対応などを自動的に補完
setopt auto_param_keys       
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments  
# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst     
# 語の途中でもカーソル位置で補完
setopt complete_in_word      
# カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt always_last_prompt    
#日本語ファイル名等8ビットを通す
setopt print_eight_bit  
# 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt extended_glob  
# 明確なドットの指定なしで.から始まるファイルをマッチ
setopt globdots 
# ディレクトリスタックの記憶。cd -<Tab>で過去の履歴から移動先の絶対パス候補を表示する。
setopt AUTO_PUSHD 
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt EXTENDED_HISTORY
# historyの共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks  
# 古いコマンドと同じものは無視 
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開         
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history

# cdを展開する前に補完候補を出させる(Ctrl-iで補完するようにする)
bindkey "^I" menu-complete   

##############
### zstyle ###
##############

# 補完候補をハイライトする
autoload -Uz compinit && compinit
zstyle ':completion:*:default' menu select=2

## 補完候補をオプションやディレクトリで分けて表示する
# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

## オプションを補完するときの表示を分かりやすくする
# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# 変数の添字を補完する
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# apt-getとかdpkgコマンドをキャッシュを使って速くする
zstyle ':completion:*' use-cache true

# ディレクトリを切り替える時の色々な補完スタイル
#あらかじめcdpathを適当に設定しておく
cdpath=(~ ~/myapp/gae/ ~/myapp/gae/google_appengine/demos/)
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補に出す
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#cd は親ディレクトリからカレントディレクトリを選択しないので表示させないようにする (例: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# オブジェクトファイルとか中間ファイルとかはfileとして補完させない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

############
### peco ###
############

function peco-history-selection() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

###############
### aliases ###
###############

alias ls='ls -aF'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#alias vi='nvim'
alias cat='cat -n'
alias less='less -NM'
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=aunpackexport PATH="/usr/local/opt/mysql@5.7/bin:$PATH"