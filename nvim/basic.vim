let s:base_dir = expand('~/.dotfiles/nvim')

" runtimepathに追加
execute 'set runtimepath+=' . fnamemodify(s:base_dir, ':p')

runtime! basic.vim
runtime! keymaps.vim
runtime! dein.vim
runtime! appearance.vim