"Use vim settings, rather than vi settings
"must be first, because it changes other options as a side effect
set nocompatible

set encoding=utf-8
"Use bash not sh for advanced features like color
set shell=bash

"initialize bundles in .vim/bundle
call pathogen#runtime_append_all_bundles()
"Note that you need to invoke the pathogen functions before invoking "filetype
"plugin indent on" if you want it to load ftdetect files. On Debian (and
"probably other distros), the system vimrc does this early on, so you actually
"need to 'filetype off' before 'filetype plugin indent on' to force reloading.
filetype off 
filetype plugin indent on

"======== Keyboard Shortcuts ========"

"jump to tag with enter
nmap <cr> <C-]>
"go back a tag with backspace
nmap <bs> <C-t>

let mapleader = "," "Leader key

nmap <Leader>e :FuzzyFinderTextMate<CR>

"quick .vimrc editing
nmap <Leader>.e :edit $MYVIMRC<CR>
nmap <Leader>.s :source $MYVIMRC<CR>

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

set linebreak "wrap lines at convenient points

if &term == "xterm" || &term == "screen-bce"
    set t_Co=256 "give me higher color depth
    colorscheme wombat
elseif &term == "linux"
    colorscheme default
else
  "do stuff for other terminals
endif


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

"completion settings
set wildmode=list:longest

"scroll settings
set scrolloff=3 

"======== HTML Settings ========"
:let html_number_lines = 0  "no line numbers
:let html_use_css = 1       "optimize html for new browsers
:let html_no_pre = 1        "don't wrap everything in <pre>

"==========Ruby Settings==========
"parse the entire buffer to add a list of classes to autocompletion results
let g:rubycomplete_classes_in_global = 1

"gvim
if has('gui_running')
    set guioptions-=T "no toolbar
    set guifont=Consolas\ 10
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


command! Spell setlocal spell spelllang=en_nz

" Eclim Settings
let g:SuperTabDefaultCompletionTypeDiscovery = [
\ "&completefunc:<c-x><c-u>",
\ "&omnifunc:<c-x><c-o>",
\ ]
let g:SuperTabLongestHighlight = 1

nnoremap <Leader>ji :JavaImport<CR>
nnoremap <Leader>jd :JavaDocSearch -x declarations<CR>
nnoremap <Leader>jc :JavaCorrect<CR>
