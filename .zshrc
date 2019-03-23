# Created by newuser for 5.7.1

#####################
### Env Variables ###
#####################


PATH=$PATH:$HOME/bin

eval "$(rbenv init - zsh)"

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PATH="$HOME/.rbenv/bin:$PATH"
export XDG_CONFIG_HOME=$HOME/.config
export PGDATA='/usr/local/var/postgres'
export PATH="/usr/local/opt/openssl/bin:$PATH"
export RAILS_ENV=development
export ZPLUG_HOME=/usr/local/opt/zplug

#############
### zplug ###
#############

source $ZPLUG_HOME/init.zsh

zplug "sorin-ionescu/prezto"

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
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=aunpack