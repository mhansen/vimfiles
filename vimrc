"Use vim settings, rather than vi settings
"must be first, because it changes other options as a side effect
set nocompatible
filetype off

call plug#begin()

Plug 'editorconfig/editorconfig-vim'
Plug 'rust-lang/rust.vim'
Plug 'nathangrigg/vim-beancount'
"Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ledger/vim-ledger'
Plug 'vim-scripts/matchit.zip'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fugitive'
Plug 'jalvesaq/Nvim-R'
Plug 'vim-scripts/Wombat'
Plug 'vim-scripts/wombat256.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'deoplete-plugins/deoplete-lsp'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'ionide/Ionide-vim', {
        \ 'do':  'make fsautocomplete',
      \}


call plug#end()
filetype plugin indent on

"syntax highlighting, probably the most important setting here
syntax on

"moving by file line instead of screen line is stupid
"so move by screen line
nnoremap j gj
nnoremap k gk

" ':' is hard to type, you have to hold down shift.
" space isn't doing much useful in normal mode, lets remap it to ':'!
nnoremap <space> :

"forgot sudo when editing a file that you dont have access to?
"no worries! use :w!! and we'll sort it out
cmap w!! w !sudo tee % >/dev/null

"change the terminals title for gui toolkits
set title

set encoding=utf-8

"Use bash not sh for advanced features like color.
"I wish I could use fish here, but it doesn't play nice.
set shell=bash


"======== Keyboard Shortcuts ========"

"Go back a tag with backspace in normal mode, like hitting the back button in
"a browser.  Pop a tag off the tag stack.
nmap <bs> <C-t>

"Leader key for all sorts of custom mappings
let mapleader = ","

"quick .vimrc editing
nmap <Leader>.e :edit ~/.vim/vimrc<CR>
nmap <Leader>.s :source $MYVIMRC<CR>

nmap <Leader>r :redraw!<CR>
nmap <Leader>du :diffupdate<CR>
map <Leader>hs :lclose<CR>

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

set statusline+=%#warningmsg#
"display a warning if file encoding isnt utf-8
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

set statusline+=%=      "left/right separator
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set statusline+=\ %c      "cursor column

set laststatus=2

set linebreak "wrap lines at convenient points

"Give me higher color depth
set t_Co=256
colorscheme wombat256mod
if &term == "linux"
    "Old-school console, like you get with Ctrl-Alt-F1. No higher color
    "support.
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
set incsearch  "search as I type

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
set shiftwidth=2
set tabstop=2
set shiftround " user a multiple of shiftwidth when indenting with '<'/'>'
set autoindent
set smartindent
set expandtab "expand tabs to spaces
set smarttab " insert tabs on the start of a line according to shiftwidth, not
             " tabstop

"completion settings
set wildmenu
set wildmode=list:longest

"Scroll when I get three lines from the top or bottom of the screen.
set scrolloff=3

"gvim
if has('gui_running')
    set guioptions-=T "no toolbar
    set guioptions-=m "no menu
    set guifont=Monospace\ 8
    set guitablabel=(%n%M)\ %f
    set shellxquote=\"
endif

command! Spell setlocal spell spelllang=en_nz
set dictionary+=/usr/share/dict/british-english

let g:SuperTabLongestHighlight = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-o>'
" If I use a difference completion type (e.g. <c-x><c-k>),
" make supertab use that completion type till i close vim
let g:SuperTabRetainCompletionDuration = 'session'
let g:SuperTabLongestHighlight = 1

if version >= 703
    "store undo changes even after you close the file
    set undofile
    set undodir=/tmp
    "Maximum number of changes that can be undone.
    set undolevels=1000
    "Maximum number lines to save for undo on a buffer reload.
    set undoreload=10000
endif

"I always fat finger :W instead of :w
command! W w

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Auto write files when you leave the buffer
set autowrite

" Auto read back files that have been changed outside vim when vim detects
" they've changed
set autoread

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

:nnoremap <Leader>sp :set invpaste<CR>

let g:ctrlp_max_files = 100000

autocmd BufRead,BufNewFile *.watchr set ft=ruby
set autoread
let vimrplugin_assign = 0

"ledger
let g:ledger_bin = 'hledger'
au FileType ledger inoremap <silent> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>
au FileType ledger vnoremap <silent> <Tab> :LedgerAlign<CR>
let g:ledger_fold_blanks = 1
set nofoldenable
