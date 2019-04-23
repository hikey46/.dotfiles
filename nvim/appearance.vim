"行番号を表示
set number
"改行時に自動でインデントする
set autoindent
"タブを何文字の空白に変換するか
set tabstop=2
"自動インデント時に入力する空白の数
set shiftwidth=2
"タブ入力を空白に変換
set expandtab
"画面を縦分割する際に右に開く
set splitright
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" コマンドラインに使われる画面上の行数
set cmdheight=2
" ステータスラインを常に表示
set laststatus=2
" カーソルが何行目の何列目に置かれているかを表示する
set ruler
" コマンドラインの補完
set wildmode=list:longest
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示する
set showcmd
" 暗い背景色に合わせた配色にする
set background=dark
" 不可視文字を表示する
set list
" タブと行の続きを可視化する
set listchars=tab:>\ ,extends:<
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" http://inari.hatenablog.com/entry/2014/05/05/231307
" 全角スペースの表示

function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
" 挿入モード時、ステータスラインの色を変更

let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction