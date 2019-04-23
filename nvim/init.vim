" dein.vimによるプラグイン管理
if &compatible
  set nocompatible
endif

" dein.vimのclone先を指定する
set runtimepath+=~/dotfiles/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/dotfiles/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

" 補完、スニペット
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet')

" その他必要なプラグインはこちらに追加する

call dein#end()
