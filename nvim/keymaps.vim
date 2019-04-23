" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>
" 常にvery magicを利用
nnoremap / /\v
" タブ移動
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>

" :ls + :buffer
cnoremap bb ls<CR>:buf
" 開いてるファイルのパスを表示 (Show Path)
cnoremap sp echo expand("%:p")<CR>
" 現在日時を入力 (yyyy/MM/dd)
cnoremap date <ESC>a<C-r>=strftime("%Y/%m/%d")<CR><ESC>
" 現在日時を入力 (yyyy/MM/dd hh:mm:ss)
cnoremap datetime <ESC>a<C-r>=strftime("%Y/%m/%d %H:%M:%S")<CR><ESC>