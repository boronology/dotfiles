"hilight paren
set showmatch
set matchtime=3

"show line number
set number

"show title
set title

"indent settings
set ambiwidth=double
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set softtabstop=4
set cindent
set hidden

"show invisible chars
set list

"enable backspace anywhere
set backspace=indent,eol,start

"enable syntax hilite
syntax on

"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

" Required:
set runtimepath^=/home/boronji/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/home/boronji/.vim/dein/'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" dein plugin files
let s:toml = '~/.vim/dein.toml'
let s:lazy_toml = '~/.vim/dein_lazy.toml'
call dein#load_toml(s:toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

" Required:
call dein#end()
call dein#save_state()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" ########## Unite.vim ##########

" ########## lightline ##########
set laststatus=2

" ########## neocomplete ##########
" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:]*\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:]*\t]\%(\.\|->\)\|\h\w*::'
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"""}}}

" ########## C++ ##########
" 'justmao945/vim-clang'
" disable auto completion for vim-clanG
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'
"
let g:clang_exec = 'clang'
let g:clang_format_exec = 'clang-format'

" vim-clang : C++ completion
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++14 --pedantic-errors'

" ########## JavaScript ##########
let g:tern_map_keys = 0

" ########## TypeScript ##########
let g:neocomplete#force_omni_input_patterns.typescript = '[^. *\t]\.\w*\|\h\w*::'

" ########## C# ##########
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType cs setlocal completeopt-=preview

" ########## Python ##########
autocmd Filetype python setlocal completeopt-=preview
let g:jedi#force_py_version=3
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

" ########## Scala ##########
"
" ########## Ruby ##########
"
" ########## Golang ##########
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint']
