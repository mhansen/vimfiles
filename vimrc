"Use vim settings, rather than vi settings
"must be first, because it changes other options as a side effect
set nocompatible

"Use bash not sh for advanced features like color
set shell=bash

"======== MinTTY Mouse Wheel ======"

map <Esc>Oa <Up>
map <Esc>Ob <Down>
map <Esc>[1;2a <PageUp>
map <Esc>[1;2b <PageDown>

"======== Java Shortcuts ==========="

"Import the class under the cursor with <leader>i.
nmap <silent> <buffer> <leader>i :JavaImport<cr>

"Search for the javadocs of the element under the cursor with <leader>d.
nmap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>

"Perform a context sensitive search of the element under the cursor with <enter>.
nmap <silent> <buffer> <leader><cr> :JavaSearchContext<cr>

nmap <Leader>pi <C-R>:call JavaPackageAndImport()<CR>

function! JavaPackageAndImport()
    let filename = expand("%:h")
    echo filename
    let packagePath = substitute(filename, '\v(src|tests)/(.*)$', '\2', "g")
    let package = substitute(packagePath, '/', '.', "g")
    let text =  "import ".package.".*;\n"."package ".package.";\n"
    return text
endfunction

"======== End Java Shortcuts ======="

"======== Keyboard Shortcuts ========"

"jump to tag with enter
nmap <cr> <C-]>
"go back a tag with backspace
nmap <bs> <C-t>

"Leader key
let mapleader = ","

"FuzzyFinder_TextMate
nmap <Leader>e :FuzzyFinderTextMate<CR>

".vimrc
nmap <Leader>.e :edit $MYVIMRC<CR>
nmap <Leader>.s :source $MYVIMRC<CR>

"markdown
nmap <Leader>mkd :!markdown <C-R>% > <C-R>%.html<CR>

"vimshell keybindings
nmap <C-W>e :new \| :vimshell bash<CR>
nmap <C-W>E :vnew \| :vimshell bash<CR>

"taglist bindings
nmap <Leader>tl :TlistToggle<CR>

"NERDTree
nmap <Leader>nt :NERDTreeToggle<CR>

"Toggle Numbering lines
map <F12> :set number!<CR>
"======== End Keyboard Shortcuts ========"

"========    Visual Settings     ========"

"echo incomplete cmds down the bottom
set showcmd
set showmode

"status bar settings
set ruler
set laststatus=2

"wrap lines at convenient points
set linebreak

"give me higher color depth
set t_Co=256

"awesome color scheme
colorscheme wombat

"load filetype modes and indent files
filetype plugin on
filetype indent on
syntax on

"========  End Visual Settings  ========"

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

"Search Settings
set ignorecase "ignore search case
set smartcase  "unless theres capital letters in the search
set hlsearch
set incsearch

"indent settings
set shiftwidth=4
set tabstop=4  
set autoindent
set smartindent
set expandtab "expand tabs to spaces
autocmd FileType make setlocal noexpandtab "makefiles need explicit tab characters	
autocmd FileType html setlocal shiftwidth=2 
autocmd FileType html setlocal tabstop=2

"completion settings
set wildmode=list:longest

"scroll settings
set scrolloff=3 

"======== HTML Settings ========"
:let html_number_lines = 0  "no line numbers
:let html_use_css = 1       "optimize html for new browsers
:let html_no_pre = 1        "don't wrap everything in <pre>

"==========Ruby Settings==========
autocmd FileType ruby compiler ruby "not sure if this will interfere with other code

"load/evaluate code to provide completions
"CARE: will cause code execution
let g:rubycomplete_buffer_loading = 1

"parse the entire buffer to add a list of classes to autocompletion results
let g:rubycomplete_classes_in_global = 1

"markdown
augroup mkd
    autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:>
augroup END

"gvim
if has('gui_running')
    set guioptions-=T "no toolbar
    set guifont=Consolas:h10:cANSI
    set guitablabel=(%n%M)\ %f
    set shell=bash
    set shellcmdflag=--login\ -c
    set shellxquote=\"
endif

"tab navigation with Alt
map <A-1>  1gt
map <A-2>  2gt
map <A-3>  3gt
map <A-4>  4gt
map <A-5>  5gt
map <A-6>  6gt
map <A-7>  7gt
map <A-8>  8gt
map <A-9>  9gt
map <A-0>  10gt
