let s:base_dir = expand('~/.dotfiles/nvim')

" runtimepathに追加
execute 'set runtimepath+=(s:base_dir)'

runtime! basic.vim
runtime! dein.vim
runtime! keymaps.vim
runtime! appearance.vim
