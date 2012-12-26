"Initialize bundles in .vim/bundle.
filetype off

"Use vim settings, rather than vi settings
"must be first, because it changes other options as a side effect
if &compatible
  set nocompatible
endif

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"Note that you need to invoke the pathogen functions before invoking "filetype
"plugin indent on" if you want it to load ftdetect files. On Debian (and
"probably other distros), the system vimrc does this early on, so you actually
"need to 'filetype off' before 'filetype plugin indent on' to force reloading.
filetype plugin indent on

"syntax highlighting, probably the most important setting here
syntax on

"moving by file line instead of screen line is stupid
"so move by screen line
nnoremap j gj
nnoremap k gk

"debian/ubuntu call ack 'ack-grep' and set some bad options
"for quickfixing. we need to override these
"this is used for the :Ack bundle
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" ':' is crazy hard to type, you have to hold down shift and stuff.
" space isn't doing anything useful in normal mode, lets remap it to ':'!
nnoremap <space> :

function! RunShebang()
    if (match(getline(1),'^\#!') == 0)
        :!chmod +x % && ./%
    elseif (match(getline(1),'^<!') == 0) "match like <!doctype
        :!google-chrome ./%
    else
        echo "No shebang in this file"
    endif
endfunction
map <F5> :call RunShebang()<CR>

"forgot sudo when editing a file that you dont have access to?
"no worries! use :w!! and we'll sort it out
cmap w!! w !sudo tee % >/dev/null

"change the terminals title for gui toolkits
set title

"It's 2011. There's only one encoding, and that's utf-8.
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

"Don't bug me with an error if I don't have ruby and I try to use Cmd-T
if has('ruby')
    nmap <Leader>e :CommandT<CR>
end

"quick .vimrc editing
nmap <Leader>.e :edit ~/.vim/vimrc<CR>
nmap <Leader>.s :source $MYVIMRC<CR>

"NERDTree
nmap <Leader>nt :NERDTreeToggle<CR>

"FuGitIve Shortcuts
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gb :Gbrowse<CR>

nmap <Leader>r :redraw!<CR>
nmap <Leader>du :diffupdate<CR>

"Toggle Numbering lines
map <F12> :set number!<CR>

map <F1> :set invpaste<CR>
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
set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
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

"Give me higher color depth
set t_Co=256
colorscheme wombat
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

"Ruby: parse the entire buffer to add a list of classes to autocompletion
"results
let g:rubycomplete_classes_in_global = 1

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

" Accordion style user-interface: vertically expand the window you move into
map <C-j> <C-w>j<C-w>_
map <C-k> <C-w>k<C-w>_
map <C-h> <C-w>h<C-w>_
map <C-l> <C-w>l<C-w>_

if version >= 703
    "store undo changes even after you close the file
    set undofile
    set undodir=/tmp
    "Maximum number of changes that can be undone.
    set undolevels=1000
    "Maximum number lines to save for undo on a buffer reload.
    set undoreload=10000
    "Remind me not to make long lines with a subtle column of gray on the
    "right.
    set colorcolumn=+1,+2,+3,+4,+5,+6,+7,+8,+9,+10
    hi ColorColumn ctermbg=darkgray
endif

"I always fat finger :W instead of :w
command! W w

"Start python files with boilerplate done
augroup BufNewFileFromTemplate
au!
autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e
augroup BufNewFileFromTemplate

"auto compile coffeescript files on save
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow 2 | redraw!

"auto gofmt go files on save
if executable('gofmtwrapper') 
    autocmd BufRead,BufWrite *.go 
        \ execute 'normal mx' | 
        \ execute 'silent %!gofmtwrapper' | 
        \ execute 'normal `x' 
    autocmd Filetype go set formatprg=gofmtwrapper 
endif 


"auto compile markdown files on save
"autocmd BufWritePost,FileWritePost *.markdown :silent !markdown <afile> > <afile>.html
"
function! HamlMake()
    py << ENDOFPYTHON
import os
import vim

in_file = vim.current.buffer.name
dirname = os.path.dirname(in_file)
if os.path.exists(dirname + "/.autohaml"):
    out_file = in_file[0:-5] + ".html"
    os.system("haml %s %s" % (in_file, out_file))

ENDOFPYTHON
endfunction

"auto compile haml files on save (only if there's a .autohaml file touched
au BufWritePost *.haml call HamlMake()

"Close html tags quickly with ,/
"http://stackoverflow.com/questions/130734/how-can-one-close-html-tags-in-vim-quickly/532656#532656
imap ,/ </<C-X><C-O>

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Destroy infuriating keys
nnoremap K <nop> " manual key

" Show tabs with an arrow
set list
set listchars=tab:▸\

" Auto write files when you leave the buffer
set autowrite

" Auto read back files that have been changed outside vim when vim detects
" they've changed
set autoread

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

"Syntastic options
let g:syntastic_auto_loc_list=0
let g:syntastic_quiet_warnings=0
let g:syntastic_disabled_filetypes = ['html', 'js']

:nnoremap <Leader>sp :set invpaste<CR>

let g:ctrlp_max_files = 100000

" You know, I almost never want to delete-and-replace the current line
" So I almost never use the S command (and cc is quicker to type anyway)
" On the other hand, I’m forever using :%s/pattern/replacement/g
" So I optimized my workflow:
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>
