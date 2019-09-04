if g:dein#_cache_version !=# 150 || g:dein#_init_runtimepath !=# '/Users/hiromu_kihira/.dotfiles/nvim,/etc/xdg/nvim,/Users/hiromu_kihira/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.3.8/share/nvim/runtime,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/hiromu_kihira/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/hiromu_kihira/.dotfiles/nvim/after,(s:base_dir),/Users/hiromu_kihira/.dotfiles/nvim/plugins/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/hiromu_kihira/.dotfiles/nvim/init.vim', '/Users/hiromu_kihira/.dotfiles/nvim/toml/general.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/completion.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/colorscheme.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/airline.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/ale.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/nerdcommenter.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/nerdtree.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/neovim.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/denite.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/vimproc.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/vim-fugitive.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/vim-gitgutter.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/deoplete.toml', '/Users/hiromu_kihira/.dotfiles/nvim/toml/lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/hiromu_kihira/.dotfiles/nvim/plugins/dein'
let g:dein#_runtime_path = '/Users/hiromu_kihira/.dotfiles/nvim/plugins/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/Users/hiromu_kihira/.dotfiles/nvim/plugins/dein/.cache/init.vim'
let &runtimepath = '/Users/hiromu_kihira/.dotfiles/nvim,/etc/xdg/nvim,/Users/hiromu_kihira/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/Users/hiromu_kihira/.dotfiles/nvim/plugins/dein/repos/github.com/Shougo/dein.vim,/Users/hiromu_kihira/.dotfiles/nvim/plugins/dein/.cache/init.vim/.dein,/usr/local/Cellar/neovim/0.3.8/share/nvim/runtime,/Users/hiromu_kihira/.dotfiles/nvim/plugins/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/hiromu_kihira/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/hiromu_kihira/.dotfiles/nvim/after,(s:base_dir)'
filetype off
  nnoremap [denite] <Nop>
  nmap <C-d> [denite]
  nnoremap <silent> [denite]g :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>
  nnoremap <silent> [denite]r :<C-u>Denite -resume -buffer-name=search-buffer-denite<CR>
  nnoremap <silent> [denite]p :<C-u>Denite file_rec<CR>
  call denite#custom#option('default', 'prompt', '>')
  call denite#custom#option('_', 'highlight_matched_range', 'None')
  call denite#custom#option('_', 'highlight_matched_char', 'None')
  call denite#custom#map('insert', "<Tab>", '<denite:move_to_next_line>')
  call denite#custom#map('insert', "<S-Tab>", '<denite:move_to_previous_line>')
  call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')
  call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')
  call denite#custom#map('normal', "v", '<denite:do_action:vsplit>')
  call denite#custom#var('grep', 'command', ['pt', '--follow', '--nogroup', '--nocolor', '--hidden'])
  call denite#custom#var('grep', 'default_opts', [])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('file_rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
  colorscheme iceberg
  if !exists('g:context_filetype#filetypes')
    let g:context_filetype#filetypes = {}
  endif
  let g:context_filetype#filetypes['toml'] = [ {'filetype':'vim', 'start':'^\s*hook_\(add\|source\|post_source\)\s*=\s*'.'""'.'"', 'end':'""'.'"'}, {'filetype':'vim', 'start':'^\s*hook_\(add\|source\|post_source\)\s*=\s*'."''"."'", 'end':"''"."'"},]
    let g:airline_theme = 'wombat'
    set laststatus=2
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#wordcount#enabled = 0
    let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
    let g:airline_section_c = '%t'
    let g:airline_section_x = '%{&filetype}'
    let g:airline_section_z = '%3l:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
    let g:airline#extensions#ale#error_symbol = ' '
    let g:airline#extensions#ale#warning_symbol = ' '
    let g:airline#extensions#default#section_truncate_width = {}
    let g:airline#extensions#whitespace#enabled = 1
    let g:NERDSpaceDelims=1
    let g:NERDDefaultAlign='left'
  set signcolumn=yes
  set updatetime=1000
  
  nnoremap [gitgutter] <Nop>
  nmap <C-h> [gitgutter]
  nmap [gitgutter]j <Plug>GitGutterNextHunk
  nmap [gitgutter]k <Plug>GitGutterPrevHunk
  nmap [gitgutter]u <Plug>GitGutterUndoHunk
  autocmd QuickFixCmdPost *grep* cwindow
  
  command Gst :Gstatus
  command Gdf :Gdiff
  command Gbl :Gblame
    let g:NERDTreeShowBookmarks=1
    autocmd vimenter * NERDTree
    map <C-n> :NERDTreeToggle<CR>
    function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
        exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
        exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
    endfunction
    call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
    call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
    call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
    call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
    call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
    call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
    call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
    call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
    call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
    call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
    call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
    call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')
    let g:NERDTreeDirArrows = 1
    let g:NERDTreeDirArrowExpandable  = '▶'
    let g:NERDTreeDirArrowCollapsible = '▼'
  let g:deoplete#enable_at_startup = 1
  inoremap <expr><Tab> pumvisible() ? "\<DOWN>" : "\<Tab>"
  inoremap <expr><S-Tab> pumvisible() ? "\<UP>" : "\<S-Tab>"
    let g:ale_lint_on_text_changed = 0
    let g:ale_sign_error = ''
    let g:ale_sign_warning = ''
    let g:airline#extensions#ale#open_lnum_symbol = '('
    let g:airline#extensions#ale#close_lnum_symbol = ')'
    let g:ale_echo_msg_format = '[%linter%]%code: %%s'
    highlight link ALEErrorSign Tag
    highlight link ALEWarningSign StorageClass
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
autocmd dein-events InsertEnter * call dein#autoload#_on_event("InsertEnter", ['deoplete.nvim'])
