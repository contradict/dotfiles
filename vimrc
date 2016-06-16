set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

let g:syntastic_always_populate_loc_list = 1

Bundle 'gmarik/vundle'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'
" Bundle 'Valloric/ListToggle'

" set backspace to be able to delete previous characters
set bs=2
" Enable line numbering, taking up 6 spaces
set number

"Turn off word wrapping
set wrap!
set textwidth=80

"Turn on smart indent
set expandtab
set autoindent
set tabstop=4 "set tab character to 4 characters
set softtabstop=4
set shiftwidth=4 "indent width for autoindent
filetype plugin indent on "indent depends on filetype

"Turn on incremental search with ignore case (except explicit caps)
set incsearch
set ignorecase
set smartcase

"Informative status line
set statusline=%f%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %c]
set laststatus=2

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>80v.\+/

set colorcolumn=+1
highlight ColorColumn ctermbg=red

"Set color scheme
"set t_Co=256
"colorscheme inkpot
syntax enable

set foldenable
"Set space to toggle a fold
nnoremap <space> za
set foldmethod=syntax

highlight TrailingSpaces ctermbg=red
match TrailingSpaces /  +$/

au BufNewFile,BufRead *.ino set filetype=cpp

au BufRead,BufNewFile *.go set makeprg=go\ build

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

au! BufRead,BufNewFile *.scad set filetype=openscad
