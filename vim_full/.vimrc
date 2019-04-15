set nocompatible
filetype off
set rtp+=/usr/share/vim/addons
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'sirtaj/vim-openscad'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'fatih/vim-go'
Plugin 'thinca/vim-localrc'
Plugin 'tpope/vim-vividchalk'
Plugin 'tpope/vim-sensible'
Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'chiphogg/vim-prototxt'

call vundle#end()

filetype plugin indent on

"" YouCompleteMe
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1

""" syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Enable line numbering, taking up 6 spaces
set number

" removed by vim-sensible, restore it
set nrformats+=octal

"Turn off word wrapping
set nowrap
set textwidth=80

"Turn on smart indent
set expandtab
set tabstop=4 "set tab character to 4 characters
set softtabstop=4
set shiftwidth=4 "indent width for autoindent

"Turn on incremental search with ignore case (except explicit caps)
set ignorecase
set smartcase

"Informative status line
set statusline=%f%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ %c\ (%p%%)]
set laststatus=2

"Set color scheme
set t_Co=256
"let g:inkpot_black_background = 1
"colorscheme inkpot
set background=dark
colorscheme vividchalk

"mark last column of reasonable line length
set colorcolumn=+1
highlight ColorColumn ctermbg=red

"Highlight trailing space
highlight TrailingSpaces ctermbg=red
match TrailingSpaces /  \+$/

"Configure folding
set foldenable
set foldmethod=syntax
"Set space to toggle a fold
nnoremap <space> za

" paste toggling
set pastetoggle=<F2>

"ino is the Arduino main file extension
au BufNewFile,BufRead *.ino set filetype=cpp
autocmd BufRead,BufNewFile *.ino setlocal syntax=cpp

au BufRead,BufNewFile *.go set makeprg=go\ build

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" recognize dockerfiles with extensions
au! BufRead,BufNewFile Dockerfile.* set filetype=dockerfile syntax=dockerfile

" better javascript folding
au FileType javascript call JavaScriptFold()

" yml 2-space indent
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

" python folding on indent
au FileType python setlocal foldmethod=indent

" wrap markdown files
au FileType markdown setlocal wrap lbr nolist fo+=l cc= tw=80 wm=80

au BufNewFile,BufRead *.config,*.pbtxt setfiletype prototxt

au FileType PROTOTXT setlocal foldmethod=indent
