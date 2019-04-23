"-------------------------------------------------------------------------------
" 編集に関する設定:

" タブの画面上での幅
set tabstop=2
" 自動インデントでずれる幅
set shiftwidth=2
" タブの代わりに空白文字を指定する
set expandtab
" 新しい行のインデントを現在行と同じにする
set autoindent

"-------------------------------------------------------------------------------
" ファイル操作に関する設定:

" バックアップファイル
"" 有効化
set backup
"" 出力先
set backupdir=~/.vim/.backup
" スワップファイル
"" 有効化
set swapfile
"" 出力先
set directory=~/.vim/.swap
" UNDOファイル
"" 有効化
set undofile
"" 出力先
set undodir=~/.vim/.undo

"-------------------------------------------------------------------------------
" その他設定:

" not ignore case.
se noic
" スペルチェック
set spell
set spelllang=en,cjk
" matchit.vim
runtime macros/matchit.vim

"-------------------------------------------------------------------------------