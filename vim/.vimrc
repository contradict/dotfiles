set rtp+=/usr/share/vim/addons
filetype plugin indent on "indent depends on filetype

set nocompatible
" set backspace to be able to delete previous characters
set bs=2
" Enable line numbering, taking up 6 spaces
set number

"Turn off word wrapping
set nowrap
set textwidth=80

"Turn on smart indent
set expandtab
set autoindent
set tabstop=4 "set tab character to 4 characters
set softtabstop=4
set shiftwidth=4 "indent width for autoindent

"Turn on incremental search with ignore case (except explicit caps)
set incsearch
set ignorecase
set smartcase

"Informative status line
set statusline=%f%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %c\ (%p%%)]
set laststatus=2

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>80v.\+/

set colorcolumn=+1
highlight ColorColumn ctermbg=red

"Set color scheme
set t_Co=256
let g:inkpot_black_background = 1
colorscheme inkpot
"syntax enable

set foldenable
set foldmethod=syntax
"Set space to toggle a fold
nnoremap <space> za

highlight TrailingSpaces ctermbg=red
match TrailingSpaces /  +$/

" paste toggling
set pastetoggle=<F2>

"ino is the Arduino main file extension
au BufNewFile,BufRead *.ino set filetype=cpp
autocmd BufRead,BufNewFile *.ino setlocal syntax=cpp

au BufRead,BufNewFile *.go set makeprg=go\ build

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

