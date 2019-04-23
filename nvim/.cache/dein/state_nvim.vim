if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/hiromu/.dotfiles/nvim,/etc/xdg/nvim,/Users/hiromu/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.3.4/share/nvim/runtime,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/hiromu/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/hiromu/.dotfiles/nvim/after,(s:base_dir),/Users/hiromu/.dotfiles/nvim/.cache/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/hiromu/.dotfiles/nvim/init.vim', '/Users/hiromu/.dotfiles/nvim/toml/general.toml', '/Users/hiromu/.dotfiles/nvim/toml/colorscheme.toml', '/Users/hiromu/.dotfiles/nvim/toml/neovim.toml', '/Users/hiromu/.dotfiles/nvim/toml/completion.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/hiromu/.dotfiles/nvim/.cache/dein'
let g:dein#_runtime_path = '/Users/hiromu/.dotfiles/nvim/.cache/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/Users/hiromu/.dotfiles/nvim/.cache/dein/.cache/init.vim'
let &runtimepath = '/Users/hiromu/.dotfiles/nvim,/etc/xdg/nvim,/Users/hiromu/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/Users/hiromu/.dotfiles/nvim/.cache/dein/repos/github.com/Shougo/dein.vim,/Users/hiromu/.dotfiles/nvim/.cache/dein/.cache/init.vim/.dein,/usr/local/Cellar/neovim/0.3.4/share/nvim/runtime,/Users/hiromu/.dotfiles/nvim/.cache/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/hiromu/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/hiromu/.dotfiles/nvim/after,(s:base_dir)'
filetype off
  if !exists('g:context_filetype#filetypes')
    let g:context_filetype#filetypes = {}
  endif
  let g:context_filetype#filetypes['toml'] = [ {'filetype':'vim', 'start':'^\s*hook_\(add\|source\|post_source\)\s*=\s*'.'""'.'"', 'end':'""'.'"'}, {'filetype':'vim', 'start':'^\s*hook_\(add\|source\|post_source\)\s*=\s*'."''"."'", 'end':"''"."'"},]
  colorscheme iceberg
