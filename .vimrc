" Bundles
"============================================================================"
  if has('vim_starting')
    set nocompatible

    " required for bundly goodness:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

  " required
    call neobundle#begin(expand('~/.vim/bundle'))

  " Let NeoBundle manage itself
  " required:
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

  " Bundles
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'Shougo/vimshell.vim'
    NeoBundle 'bling/vim-airline'
    NeoBundle 'bling/vim-bufferline'
    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'tpope/vim-commentary'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'tpope/vim-markdown'
    NeoBundle 'jistr/vim-nerdtree-tabs'
    NeoBundle 'tpope/vim-repeat'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'tpope/vim-unimpaired'
    NeoBundle 'majutsushi/tagbar'
    NeoBundle 'Lokaltog/vim-easymotion'
    NeoBundle 'ap/vim-css-color'
    NeoBundle 'pangloss/vim-javascript'
    NeoBundle 'mattn/emmet-vim'
    NeoBundle 'm2mdas/phpcomplete-extended'
    NeoBundle 'airblade/vim-gitgutter'
    NeoBundle 'maxbrunsfeld/vim-yankstack'
    NeoBundle 'ctrlpvim/ctrlp.vim'
    NeoBundle 'Raimondi/delimitMate'
    NeoBundle 'Valloric/YouCompleteMe'
  " vim-misc is required for the colorscheme switcher
  " NeoBundle 'xolox/vim-misc'
  " NeoBundle 'xolox/vim-colorscheme-switcher'

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

  " Don't try to highlight lines longer than 800 characters.
  set synmaxcol=800

  function! ShowColourSchemeName()
    try
      echo g:colors_name
    catch /^Vim:E121/
      echo "default
    endtry
  endfunction
  nnoremap <F9> :call ShowColourSchemeName()<cr>

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

  " Jump to the last known cursor position automatically
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Non-standard syntax highlighting
    au BufRead,BufNewFile /etc/nginx/* set ft=nginx
    autocmd BufNewFile,BufRead *.jsx   set syntax=javascript
    autocmd BufNewFile,BufRead *.ejs   set syntax=html


" CtrlP
"============================================================================"
  " Rebind
    let g:ctrlp_map = '<c-i>'
  " Set up files to ignore
    let g:ctrlp_custom_ignore = '\vjsx-build|\.git'
  " When picking multiple files with <c-z>, open them in buffers
    let g:ctrlp_open_multiple_files = 'i'


" Airline
"============================================================================"
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='tomokai'


" Bufferline
"============================================================================"
  let g:bufferline_echo = 0
  let g:bufferline_show_bufnr = 0


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
  set cursorcolumn                " highlight the line of the cursor
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
  set tabstop=2                   " a tab is two spaces
  set shiftwidth=2                " an autoindent is two spaces
  " Use :retab to change tab characters to spaces
    set expandtab                   " use spaces, not tabs
    set backspace=indent,eol,start  " backspace through everything in insert mode
  " Create blank newlines and stay in Normal mode
    nnoremap <silent> zj o<Esc>
    nnoremap <silent> zk O<Esc>
  " Nuke whitespace at EOL
    :nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

  let delimitMate_expand_cr=1


" Buffers
"============================================================================"
  " Switch back and forth between buffers easily
    map <C-n> :bprev<CR>
    map <C-p> :bnext<CR>
    map <Leader>h :bprev<CR>
    map <Leader>l :bnext<CR>
  " allow backgrounding buffers without writing
  " remember marks/undo for background buffers
    set hidden
  " auto-reload buffers when file changed on disk
    set autoread
  " ignore case when using :e to open a file
    set wildignorecase
  " Persistent undo
    set undodir=~/.vim/undo/
    if !isdirectory(expand(&undodir))
      call mkdir(expand(&undodir), "p")
    endif
    set undofile


" Completion
"============================================================================"
  " Tern
    " let tern#is_show_argument_hints_enabled = 1
    set wildignore=*.o,*.obj,*~
    set wildignore+=*vim/backups*
    set wildignore+=*sass-cache*
    set wildignore+=*DS_Store*
    set wildignore+=vendor/rails/**
    set wildignore+=vendor/cache/**
    set wildignore+=*.gem
    set wildignore+=log/**
    set wildignore+=tmp/**
    set wildignore+=*.png,*.jpg,*.gif

  " YouCompleteMe
    let g:ycm_complete_in_comments = 1


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

  " ditch repeated keystrokes
    nnoremap dl dd
    nnoremap yl yy
    nnoremap zl zz
    nnoremap gl gg
    vnoremap gl gg
  " duplicate line
    nnoremap yp yyp
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

  " save with K
    nnoremap K :w<cr>

  " commenting shortcuts
    map <Leader>/ <Plug>Commentary $
  " sublime text-style commenting - you can press <c-/>
  " <c-_> is what the terminal receives from <c-/>
    map <c-_> <Plug>Commentary $

  " Emacs-style bindings for splits
  " But make it faster and switch by default if splitting
    nnoremap <space>1 <C-w>o
    nnoremap <space>2 :split<cr><C-^>
    nnoremap <space>3 :vsplit<cr><C-^>

  " Split navigation
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-h> <C-w>h
    nnoremap <C-l> <C-w>l

  " Heresy (from Steve Losh's vimrc)
    inoremap <c-a> <esc>I
    inoremap <c-e> <esc>A

  " Other goodies from Steve Losh's vimrc
    noremap H ^
    noremap L $
    vnoremap L g_
  " Keep the cursor in place while joining lines (uses z mark)
    nnoremap J mzJ`z


" Yankstack settings
"============================================================================"
  " Rotate yanks forward
    nmap - <Plug>yankstack_substitute_older_paste
  " Rotate yanks backward
    nmap = <Plug>yankstack_substitute_newer_paste


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


" Easymotion
"============================================================================"
  let g:EasyMotion_do_mapping = 0
  " Disable default mappings

  " Bi-directional find motion
  " `;{char}{label}`
    nmap ; <Plug>(easymotion-s)

  " Turn on case sensitive feature
    let g:EasyMotion_smartcase = 1


" Emmet
"============================================================================"
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,php,inc EmmetInstall


" PHPcomplete
"============================================================================"
  let g:phpcomplete_index_composer_command = "composer"


" Gui options
"============================================================================"
  set guifont=Droid\ Sans\ Mono\ 15
  set wak=no " don't open the menu when I press 'alt'
  set ghr=5

  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=L  "remove left-hand scroll bar
