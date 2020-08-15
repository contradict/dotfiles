set nocompatible
filetype off
set rtp+=/usr/share/vim/addons
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
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
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'psf/black'
Plugin '1995parham/vim-spice'
Plugin 'ledger/vim-ledger'
Plugin 'fisadev/vim-isort'
Plugin 'cespare/vim-toml'
Plugin 'jpalardy/vim-slime'
Plugin 'kdheepak/JuliaFormatter.vim'

call vundle#end()

runtime macros/matchit.vim

filetype plugin indent on

"" YouCompleteMe
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1
"will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 0 "default 0

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info

let g:ycm_confirm_extra_conf = 1

"let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
"let g:ycm_filetype_whitelist = { '*': 1 }
"let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_python_interpreter = '/usr/bin/python3'

nnoremap <leader>yf :YcmCompleter FixIt<CR>

""" syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore=E203 --ignore=E266 --ignore=E501 --ignore=W503 --max-line-length=88 --select=B,C,E,F,W,T4,B9 --max-complexity=18"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_disabled_filetypes=['JULIA']

""" Julia
let g:latex_to_unicode_auto = 1

""" JuliaFormatter
nnoremap <localleader>jf :<C-u>call JuliaFormatter#Format(0)<CR>
vnoremap <localleader>jf :<C-u>call JuliaFormatter#Format(1)<CR>

let g:vim_isort_map = '<C-i>'

let g:slime_target = "tmux"
let g:slime_python_ipython = 1

" let g:vim_markdown_fenced_languages = ['julia=JULIA']

set encoding=utf-8

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
silent! colorscheme vividchalk

"mark last column of reasonable line length
set colorcolumn=+1
highlight ColorColumn ctermbg=red

"Highlight trailing space
highlight TrailingSpaces ctermbg=red
match TrailingSpaces /  \+$/

highlight Comment cterm=italic

"Configure folding
set foldenable
set foldmethod=syntax
"Set space to toggle a fold
nnoremap <space> za

" paste toggling
set pastetoggle=<F2>

" diff with changed file on disk
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"ino is the Arduino main file extension
au BufNewFile,BufRead *.ino set filetype=cpp
autocmd BufRead,BufNewFile *.ino setlocal syntax=cpp

au BufRead,BufNewFile *.md.html set filetype=markdown

au BufRead,BufNewFile *.jmd set filetype=markdown
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" recognize dockerfiles with extensions
au BufRead,BufNewFile Dockerfile.* set filetype=dockerfile syntax=dockerfile

" better javascript folding
au FileType javascript call JavaScriptFold()

" yml 2-space indent
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

" python folding on indent
au FileType python setlocal foldmethod=indent

" wrap and spell check markdown files
au FileType markdown setlocal wrap lbr nolist fo+=l cc= tw=80 wm=80 spell

au BufNewFile,BufRead *.config,*.pbtxt setfiletype prototxt

au FileType PROTOTXT setlocal foldmethod=indent
