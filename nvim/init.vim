let s:base_dir = expand('~/.dotfiles/vim')

" runtimepathに追加
execute 'set runtimepath+=(s:base_dir)'

runtime! basic.vim
runtime! dein.vim
runtime! keymaps.vim
runtime! appearance.vim
