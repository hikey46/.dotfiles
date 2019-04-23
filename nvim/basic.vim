"-------------------------------------------------------------------------------
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden

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
"yank した文字列をクリップボードにコピー
set clipboard=unnamed  
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

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
" 検索

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch

"-------------------------------------------------------------------------------
" その他設定:

" not ignore case.
se noic
" スペルチェック
set spell
set spelllang=en,cjk
" matchit.vim
runtime macros/matchit.vim

" 最後のカーソル位置を復元する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

" 構文毎に文字色を変化させる
syntax on
filetype on

"-------------------------------------------------------------------------------
" vim cheatsheet

let g:cheatsheet#cheat_file = '~/.cheatsheet.md'

"-------------------------------------------------------------------------------
" 閉じタグの補完

let g:closetag_filenames = '*.html'

"-------------------------------------------------------------------------------