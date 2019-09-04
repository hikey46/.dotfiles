"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

set encoding=utf-8
scriptencoding utf-8

filetype plugin indent off
syntax off

" Required:
set runtimepath+=/Users/hiromu_kihira/.dotfiles/nvim/plugins/dein/repos/github.com/Shougo/dein.vim

" Required:
let g:python_host_prog  = '/Users/hiromu_kihira/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/hiromu_kihira/.pyenv/versions/neovim3/bin/python'
let g:ruby_host_prog    = '/Users/hiromu_kihira/.rbenv/versions/2.5.3/bin/neovim-ruby-host'
let g:node_host_prog    = '/Users/hiromu_kihira/.ndenv/versions/11.12.0/bin/neovim-node-host'

let s:base_dir = expand('/Users/hiromu_kihira/.dotfiles/nvim')
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('/Users/hiromu_kihira/.dotfiles/nvim/plugins') : $XDG_CACHE_HOME
let s:dein_dir = s:base_dir . '/plugins/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml_dir = s:base_dir . '/toml'

" Required:
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " Let dein manage dein
    " Required:
    call dein#add(s:dein_repo_dir)

    call dein#load_toml(s:toml_dir . '/general.toml',       {'lazy':0})
    call dein#load_toml(s:toml_dir . '/completion.toml',    {'lazy':0})
    call dein#load_toml(s:toml_dir . '/colorscheme.toml',   {'lazy':0})
    call dein#load_toml(s:toml_dir . '/airline.toml',       {'lazy':0})
    call dein#load_toml(s:toml_dir . '/ale.toml',           {'lazy':0})
    call dein#load_toml(s:toml_dir . '/nerdcommenter.toml', {'lazy':0})
    call dein#load_toml(s:toml_dir . '/nerdtree.toml',      {'lazy':0})
    call dein#load_toml(s:toml_dir . '/neovim.toml',        {'lazy':0})
    call dein#load_toml(s:toml_dir . '/denite.toml',        {'lazy':0})
    call dein#load_toml(s:toml_dir . '/vimproc.toml',       {'lazy':0})
    call dein#load_toml(s:toml_dir . '/vim-fugitive.toml',  {'lazy':0})
    call dein#load_toml(s:toml_dir . '/vim-gitgutter.toml', {'lazy':0})
    call dein#load_toml(s:toml_dir . '/deoplete.toml',      {'lazy':1})
    call dein#load_toml(s:toml_dir . '/lazy.toml',          {'lazy':1})
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#end()
    call dein#save_state()
endif

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
