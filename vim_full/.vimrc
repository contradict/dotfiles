set rtp+=/usr/share/vim/addons
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/ListToggle'
Plugin 'tikhomirov/vim-glsl'
Plugin 'JuliaLang/julia-vim'
Plugin 'sirtaj/vim-openscad'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'bkad/CamelCaseMotion'
Plugin 'fatih/vim-go'

call vundle#end()

filetype plugin on
filetype plugin indent on "indent depends on filetype
"" YouCompleteMe
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1

""" syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
syntax enable

set foldenable
set foldmethod=syntax
"Set space to toggle a fold
nnoremap <space> za

highlight TrailingSpaces ctermbg=red
match TrailingSpaces / \+$/

" paste toggling
set pastetoggle=<F2>

"ino is the Arduino main file extension
au BufNewFile,BufRead *.ino set filetype=cpp
autocmd BufRead,BufNewFile *.ino setlocal syntax=cpp

au BufRead,BufNewFile *.go set makeprg=go\ build

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

au! BufRead,BufNewFile *.scad set filetype=openscad

" better javascript folding
au FileType javascript call JavaScriptFold()

" yml 2-space indent
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

" python folding on indent
au FileType python setlocal foldmethod=indent
