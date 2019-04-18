# Created by newuser for 5.7.1

#####################
### Env Variables ###
#####################


PATH=$PATH:$HOME/bin

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
