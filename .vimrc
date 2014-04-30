execute pathogen#infect()
set t_Co=256
set nocp
set nocompatible                " choose no compatibility with legacy vi
syntax on
filetype plugin indent on
set background=dark
colorscheme tomokai

" powerline 
" if you have to get it from github again,
" https://github.com/Lokaltog/powerline
set rtp+=~/.vim/powerline/powerline/bindings/vim

"" Better NERDTree
let mapleader = ","
map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=1 " does not seem to be working...

"" Show hidden files in NERDTree
let NERDTreeShowHidden=1

"" Relative line numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

:au FocusLost * :set number
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd BufReadPost * :set relativenumber

"" Display options
set number                      " show line numbers
set showcmd                     " display incomplete commands
set ruler                       " show the cursor position all the time
set cursorline                  " highlight the line of the cursor
set scrolloff=5                 " keep at least 5 lines above/below
set sidescrolloff=5             " keep at least 5 lines left/right
set ttyfast                     " better drawing because this is a fast terminal
set visualbell                  " No sounds
set history=1000                " Store lots of :cmdline history

"" Whitespace
"" set nowrap                   " don't wrap lines
set tabstop=2                   " a tab is two spaces
set shiftwidth=2                " an autoindent is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Buffers
" Switch back and forth between buffers easily
map <C-j> :bprev<CR>
map <C-k> :bnext<CR>
set hidden                      " allow backgrounding buffers without writing
                                " remember marks/undo for background buffers
set autoread                    " auto-reload buffers when file changed on disk
set wildignorecase              " ignore case when using :e to open a file

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                    "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~     "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"" Backups
set backupdir=~/.tmp

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
:nnoremap <CR> :nohlsearch<cr>" turn off search highlighting after search
set gdefault                    " have :s///g flag by default on

"" Custom key bindings
  " don't put comments at the end of the line or your screen will eat your face
  " press kj to escape in insert mode :)
inoremap <silent> kj <Esc>
  " press kj to escape in visual mode :)
vnoremap <silent> kj <Esc>
  " close and save
nnoremap <silent> zs ZZ
  " close without saving
nnoremap <silent> zx ZQ
  " save - seriously, who uses "s" by itself?
nnoremap <silent> s :w<cr>
  " To enable Alt / Meta keys
  " Edit > Keyboard Shortcuts..., and uncheck "Enable menu access keys".
  " ^[ is Alt / <M>
  " To get the ^[ press Ctrl-V and Ctrl-[ 

" Create blank newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Search mappings: going to next item in search will center on it
map N Nzz
map n nzz

" fix meta-keys which generate <Esc>a .. <Esc>z
let c='a'
while c <= 'z'
  exec "set <M-".toupper(c).">=\e".c
  exec "imap \e".c." <M-".toupper(c).">"
  let c = nr2char(1+char2nr(c))
endw

" Syntastic settings
" npm install -g jshint
" >> Silent fail means the "node" in your $PATH is incorrect!
" pear install PHP_CodeSniffer
" >> phpcs is the cli usage
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_javascript_jshint_conf='~/.jshintrc'
