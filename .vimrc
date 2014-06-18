" Bundles
"============================================================================"
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=/home/thomas/.vim/bundle/neobundle.vim/
endif

" Required
call neobundle#begin(expand('/home/thomas/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" vimproc
let vimproc_updcmd = has('win64') ?
      \ 'tools\\update-dll-mingw 64' : 'tools\\update-dll-mingw 32'
execute "NeoBundle 'Shougo/vimproc.vim'," . string({
      \ 'build' : {
      \     'windows' : vimproc_updcmd,
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ })

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'majutsushi/tagbar'

" Not sure how this doesn't conflict with neobundle but it seems ok
" Airline doesn't work without this, others may not as well
execute pathogen#infect()

call neobundle#end()

syntax on

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" Basic Settings
"============================================================================"
set t_Co=256
set background=dark
colorscheme tomokai

" No swapfile so that we can run a very low updatetime
set noswapfile
set nobackup

" Remap leader
let mapleader = "s"

" show the status bar
set laststatus=2

" make system clipboard the default
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif


" Unite
" ============================================================================"
" Use quick-match gratuitously
let g:unite_source_rec_unit = 250
let g:unite_prompt = '» '
let g:unite_kind_file_vertical_preview = 1
call unite#custom#source('file_rec/async', 'ignore_pattern', '\.sass-cache')
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Fuzzy file searching
" --------------------
" >>> Open in existing buffer
nnoremap <space>o :Unite -no-split -start-insert file_rec/async<cr>
" >>> Open horizontal split, new file on top
nnoremap <space>k :Unite -no-split -start-insert file_rec/async -default-action=split<cr>
" >>> Open horizontal split, new file on bottom
nnoremap <space>j :Unite -no-split -start-insert file_rec/async -default-action=below<cr>
" >>> Open vertical split, new file on left
nnoremap <space>h :Unite -no-split -start-insert file_rec/async -default-action=vsplit<cr>
" >>> Open vertical split, new file on right
nnoremap <space>l :Unite -no-split -start-insert file_rec/async -default-action=right<cr>

" Content searching
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -C4'
  let g:unite_source_grep_recursive_opt=''
endif
nnoremap <space>/ :Unite -quick-match grep:.<cr>

" Yank history
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite -quick-match history/yank<cr>

" Buffer switching
nnoremap <space>s :Unite -quick-match buffer<cr>


" Airline
"============================================================================"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='tomokai'


" Tagbar
"============================================================================"
" Reduce the updatetime for faster feedback in tagbar. Default = 4000
" Swapfile is disabled to prevent heavy disk I/O
set updatetime=100
nnoremap <silent> <space>t :TagbarToggle<CR>
nnoremap <silent> <leader>f :TagbarOpenAutoClose<CR>
" Haskell support
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" NERDTree
"============================================================================"
"" Better NERDTree
map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=1 " does not seem to be working...

"" Show hidden files in NERDTree
let NERDTreeShowHidden=1


"" Relative line numbering
"============================================================================"
:au FocusLost * :set number
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd BufReadPost * :set relativenumber


" Display options
"============================================================================"
set number                      " show line numbers
set showcmd                     " display incomplete commands
set ruler                       " show the cursor position all the time
set cursorline                  " highlight the line of the cursor
set scrolloff=5                 " keep at least 5 lines above/below
set sidescrolloff=5             " keep at least 5 lines left/right
set ttyfast                     " better drawing because this is a fast terminal
set visualbell                  " No sounds
set history=1000                " Store lots of :cmdline history
set display+=lastline           " show as much as possible of last line in window
set tabpagemax=50
au BufWinEnter * normal zR


" Whitespace
"============================================================================"
"" set nowrap                   " don't wrap lines
set tabstop=2                   " a tab is two spaces
set shiftwidth=2                " an autoindent is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
" Create blank newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
" Nuke whitespace at EOL
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


" Buffers
"============================================================================"
" Switch back and forth between buffers easily
map <C-h> :bprev<CR>
map <C-l> :bnext<CR>
map <Leader>h :bprev<CR>
map <Leader>l :bnext<CR>
set hidden                      " allow backgrounding buffers without writing
                                " remember marks/undo for background buffers
set autoread                    " auto-reload buffers when file changed on disk
set wildignorecase              " ignore case when using :e to open a file


" Completion / Neocomplete
"============================================================================"
" Disable AutoComplPop
let g:acp_enableAtStartup = 0
" Use neocomplete
let g:neocomplete#enable_at_startup = 1

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Use smartcase
let g:neocomplete#enable_smart_case = 1

" Enable omni completion.
autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" set wildmode=list:longest
" set wildmenu                    "enable ctrl-n and ctrl-p to scroll thru matches
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


" Backups
"============================================================================"
set backupdir=~/.tmp


" Searching
"============================================================================"
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set gdefault                    " have :s///g flag by default on
" turn off search highlighting after search by pressing Return/Enter
:nnoremap <CR> :nohlsearch<cr>
" Search mappings: going to next item in search will center on it
map N Nzz
map n nzz


" Custom key bindings
"============================================================================"
"" make sure no spaces before " or you get unexpected behavior
" To enable Alt / Meta keys in Gnome terminal
" Edit > Keyboard Shortcuts..., and uncheck "Enable menu access keys".
" ^[ is Alt / <M>
" To get the ^[ press Ctrl-V and Ctrl-[

" ditch repeated keystrokes
nnoremap dl dd
nnoremap yl yy
nnoremap zl zz
nnoremap gl gg
" mash j and k together to escape in insert mode (order doesn't matter)
inoremap kj <Esc>
inoremap jk <Esc>

" close and save
nnoremap zs ZZ
" close and save everything
nnoremap za :wqa<cr>
" close without saving
nnoremap zx ZQ
" close everything without saving
nnoremap zq :qa!<cr>
" close current buffer
nnoremap zd :BD<cr>

" Emacs-style bindings for splits
" But make it faster and switch by default if splitting
nnoremap <space>1 <C-w>o
nnoremap <space>2 :split<cr><C-^>
nnoremap <space>3 :vsplit<cr><C-^>

" save
nnoremap s :w<cr>

" pastetoggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" fix meta-keys which generate <Esc>a .. <Esc>z
let c='a'
while c <= 'z'
  exec "set <M-".toupper(c).">=\e".c
  exec "imap \e".c." <M-".toupper(c).">"
  let c = nr2char(1+char2nr(c))
endw


" Syntastic settings
"============================================================================"
" Don't run by default on file open; this can be very slow
let g:syntastic_check_on_open=0

" Checkers and configuration -------------------------------------------
" npm install -g jshint # Silent fail means the "node" in your $PATH is incorrect!
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_javascript_jshint_conf='~/.jshintrc'

" pear install PHP_CodeSniffer
" >> phpcs is the cli usage
let g:syntastic_php_checkers=['phpcs']

" gem install rubocop
let g:syntastic_ruby_checkers=['rubocop']

" Turn off Syntastic when it's annoying
nnoremap <silent> <leader>y :SyntasticToggleMode<cr>

" Toggle error list
function! ToggleErrors()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
         " No location/quickfix list shown, open syntastic error location panel
         Errors
    else
        lclose
    endif
endfunction

nnoremap <silent> <Leader>e :<C-u>call ToggleErrors()<CR>
