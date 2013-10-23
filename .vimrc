execute pathogen#infect()
set t_Co=256
set nocp
set nocompatible 		" choose no compatibility with legacy vi
syntax on
filetype plugin indent on
set background=dark
colorscheme tomokai

"" Display options
set number 			" show line numbers
set showcmd 			" display incomplete commands
set ruler 			" show the cursor position all the time
set cursorline 			" highlight the line of the cursor
"set list 			" show invisible characters

"" Folding
" zO: open all folds at cursor (ie function with multiple nesting levels)
" zC: close all folds at cursor
" zR: open all folds in buffer 
" zM: close all folds in buffer
" set foldmethod=syntax 		" automatically fold based on syntax
" :nnoremap <Space> za 		" toggle the current fold

"" Buffers
set hidden 			" allow backgrounding buffers without writing
				" remember marks/undo for background buffers
set autoread 			" auto-reload buffers when file changed on disk
" set wildignore 			" ignore case when using :e to open a file

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
