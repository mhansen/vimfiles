"Use vim settings, rather than vi settings
"must be first, because it changes other options as a side effect
set nocompatible

syntax on

"moving by file line instead of screen line is stupid
nnoremap j gj
nnoremap k gk

"debian/ubuntu call ack 'ack-grep' and set some bad options 
"for quickfixing. we need to override these
"this is used for the !Ack bundle
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" the colon is crazy hard to type, you have to hold down shift and stuff
" space isn't doing anything useful, lets remap it to colon!
nnoremap <space> :

function! RunShebang()
    if (match(getline(1),'^\#!') == 0)
        :!chmod +x % && ./%
    else
        echo "No shebang in this file"
    endif
endfunction
map <F5> :call RunShebang()<CR>

"forgot sudo? no worries! :w!!
cmap w!! w !sudo tee % >/dev/null

"change the terminals title
set title

set encoding=utf-8
"Use bash not sh for advanced features like color
set shell=bash

"initialize bundles in .vim/bundle
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"Note that you need to invoke the pathogen functions before invoking "filetype
"plugin indent on" if you want it to load ftdetect files. On Debian (and
"probably other distros), the system vimrc does this early on, so you actually
"need to 'filetype off' before 'filetype plugin indent on' to force reloading.
filetype off 
filetype plugin indent on

"======== Keyboard Shortcuts ========"

"go back a tag with backspace
nmap <bs> <C-t>

let mapleader = "," "Leader key

if has('ruby')
    nmap <Leader>e :CommandT<CR>
end

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
"statusline setup
set statusline=%f\       "tail of the filename

""display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

"git
set statusline+=%{fugitive#statusline()}

set statusline+=%=      "left/right separator
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set statusline+=\ %c      "cursor column

set laststatus=2

set linebreak "wrap lines at convenient points

if &term == "xterm" || &term == "screen-bce" || $term == "builtin-gui"
    set t_Co=256 "give me higher color depth
    colorscheme wombat
endif
if &term == "linux"
    colorscheme default
endif



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

"clear the search hilghlighting with double escape
nmap <silent> <esc><esc> :nohlsearch<CR>

"fix Vim’s horribly broken default regex “handling” by automatically inserting
"a \v before any string you search for. This turns off Vim’s crazy default
"regex characters and makes searches use normal regexes. I already know
"Perl/Python compatible regex formatting, why would I want to learn another
"scheme?
nnoremap / /\v
vnoremap / /\v

"indent settings
set shiftwidth=4
set tabstop=4  
set shiftround " user a multiple of shiftwidth when indenting with '<'/'>'
set autoindent
set smartindent
set expandtab "expand tabs to spaces
set smarttab " insert tabs on the start of a line according to shiftwidth, not
             " tabstop

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
    set guioptions-=m "no menu
    set guifont=Monospace\ 8
    set guitablabel=(%n%M)\ %f
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
set dictionary+=/usr/share/dict/british-english

let g:SuperTabLongestHighlight = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-o>'
" If I use a difference completion type (e.g. <c-x><c-k>),
" make supertab use that completion type till i close vim
let g:SuperTabRetainCompletionDuration = 'session'
let g:SuperTabLongestHighlight = 1

nnoremap <Leader>ji :JavaImport<CR>
nnoremap <Leader>jd :JavaDocSearch -x declarations<CR>
nnoremap <Leader>jc :JavaCorrect<CR>

" vertically expand the window you move into
map <C-j> <C-w>j<C-w>_
map <C-k> <C-w>k<C-w>_
map <C-h> <C-w>h<C-w>_
map <C-l> <C-w>l<C-w>_

"restore cursor position (for irb)
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

if version >= 703
    set undofile "store undo changes even after you close the file
    set undodir=~/.vim/undodir
    set undolevels=1000 "maximum number of changes that can be undone
    set undoreload=10000 "maximum number lines to save for undo on a buffer reload
    "set relativenumber "show the number of lines up/down on the side
    set colorcolumn=+1,+2,+3,+4,+5,+6,+7,+8,+9,+10 "remind me not to make long lines
    hi ColorColumn ctermbg=black
endif
