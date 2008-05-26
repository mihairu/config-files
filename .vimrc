set helplang=cs
set ruler
set showmode
set nocompatible
set backspace=2
syntax on
set fileencodings=utf-8,latin2

map <C-p> :bprev<CR>
map <C-n> :bnext<CR> 

map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:DisablePHPFolds<Cr> 
source ~/.vim/after/ftplugin/phpfolding.vim

map <F9> <Esc>:TlistToggle<Cr>

map ,/ :call CommentLineToEnd('//')<CR>+ 


version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
map! <S-Insert> <MiddleMouse>
map Q gq
nmap gx <Plug>NetrwBrowseX
map <S-Insert> <MiddleMouse>
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetBrowseX(expand("<cWORD>"),0)
map <F12> :w|!php -l '%'
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set backspace=indent,eol,start
set backupdir=~/.vim-backup/
set cmdheight=2
set directory=~/.vim-backup/
set expandtab
set guifont=Terminus\ 8
set helplang=cs
set history=50
set hlsearch
set incsearch
set mouse=a
set ruler
set shiftwidth=4
set showcmd
set softtabstop=4
set termencoding=utf-8
set window=37
set number
let g:loaded_matchparen= 1 

:nmap <Right> :echo "use L you bastard!"<CR>
:nmap <Left> :echo "use H you punk!"<CR>
:nmap <Up> :echo "use K you slug!"<CR>
:nmap <Down> :echo "mom said I am dirty bitch...just use J!"<CR>

fun! WriteBackup()
    let fname = expand("%:p") . "-" . strftime("%y%m%d-%H%Mmor")
    silent exe ":w " . fname
    echo "Wrote " . fname
endfun
nnoremap <Leader>ba :call WriteBackup()<CR>

