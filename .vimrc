execute pathogen#infect()
set t_Co=256
set nocp
set nocompatible 		" choose no compatibility with legacy vi
syntax on
filetype plugin indent on
set background=dark
"colorscheme soruby
colorscheme tomokai

"" Display options
set number 			" show line numbers
set showcmd 			" display incomplete commands
set ruler 			" show the cursor position all the time
set cursorline 			" highlight the line of the cursor
"set list 			" show invisible characters
set scrolloff=5 " keep at least 5 lines above/below
set sidescrolloff=5 " keep at least 5 lines left/right
set ttyfast " better drawing because this is a fast terminal

"" Whitespace
"" set nowrap			" don't wrap lines
set tabstop=2 			" a tab is two spaces
set shiftwidth=2		" an autoindent is two spaces 
set expandtab 			" use spaces, not tabs
set backspace=indent,eol,start 	" backspace through everything in insert mode

"" Folding
" zO: open all folds at cursor (ie function with multiple nesting levels)
" zC: close all folds at cursor
" zR: open all folds in buffer 
" zM: close all folds in buffer
" set foldmethod=syntax 		" automatically fold based on syntax
" :nnoremap <Space> za 		" toggle the current fold

"" Buffers
" Switch back and forth between buffers easily
map <C-j> :bprev<CR>
map <C-k> :bnext<CR>
set hidden 			" allow backgrounding buffers without writing
				" remember marks/undo for background buffers
set autoread 			" auto-reload buffers when file changed on disk
set wildignorecase 		" ignore case when using :e to open a file

"" Mouse Usage
"set mouse=a 			" allow using mouse

"" Backups
set backupdir=~/.tmp

"" Searching
set hlsearch 			" highlight matches
set incsearch 			" incremental searching 
set ignorecase 			" searches are case insensitive...
set smartcase 			" ... unless they contain at least one capital letter
:nnoremap <CR> :nohlsearch<cr>  " turn off search highlighting after search
set gdefault 			" have :s///g flag by default on

"" Awesomeness
inoremap jj <Esc>   " press jj to escape in insert mode :)
nnoremap JJJJ <Nop>

" Create blank newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Search mappings: going to next item in search will center on it
map N Nzz
map n nzz
