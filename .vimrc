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

  " Appearance
    NeoBundle 'vim-airline/vim-airline'
    NeoBundle 'vim-airline/vim-airline-themes'
    NeoBundle 'bling/vim-bufferline'
    NeoBundle 'airblade/vim-gitgutter'

  " Navigation
    NeoBundle 'jistr/vim-nerdtree-tabs'
    NeoBundle 'ctrlpvim/ctrlp.vim'

  " Git
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'gregsexton/gitv'

  " Tools
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundle 'tpope/vim-unimpaired'
    NeoBundle 'milkypostman/vim-togglelist'
    NeoBundle 'maxbrunsfeld/vim-yankstack'
    NeoBundle 'tpope/vim-abolish'
    NeoBundle 'tpope/vim-commentary'
    NeoBundle 'tpope/vim-repeat'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'Raimondi/delimitMate'
    NeoBundle 'PeterRincker/vim-argumentative'

  " The best
    NeoBundle 'Lokaltog/vim-easymotion'

  " Highlighting and stuff
    NeoBundle 'tpope/vim-markdown'
    NeoBundle 'ap/vim-css-color'
    NeoBundle 'pangloss/vim-javascript'
    NeoBundle 'moll/vim-node'
    NeoBundle 'mxw/vim-jsx'
    NeoBundle 'luochen1990/rainbow'
    NeoBundle 'm2mdas/phpcomplete-extended'
    NeoBundle 'digitaltoad/vim-pug'
    NeoBundle 'posva/vim-vue'

  " Snippets
    NeoBundle 'SirVer/ultisnips'
    NeoBundle 'honza/vim-snippets'

  " Tmux
    NeoBundle 'tmux-plugins/vim-tmux-focus-events'
    NeoBundle 'Keithbsmiley/tmux.vim'


    " Include optional local scripts
    if filereadable(glob("~/.vimrc.local"))
      source ~/.vimrc.local
    endif
  " xolox/vim-misc is required for the colorscheme switcher
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
  set lazyredraw

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

  " Jump to the last known cursor position automatically
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Non-standard syntax highlighting
    au BufRead,BufNewFile /etc/nginx/* set ft=nginx
    autocmd BufNewFile,BufRead *.jsx   set syntax=javascript
    autocmd BufNewFile,BufRead *.ejs   set syntax=html

  " Make the commandline window reopen to the same position after executing a command with <F5>
    autocmd CmdwinEnter * nnoremap <buffer> <F5> :let g:CmdWindowLineMark=line(".")<CR><CR>q::execute "normal ".g:CmdWindowLineMark."G"<CR>
  " Don't automatically insert comments
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" CtrlP
"============================================================================"
  " Rebind
    let g:ctrlp_map = '<c-i>'
  " Set up files to ignore
    let g:ctrlp_custom_ignore = '\vjsx-build|\.git'
  " When picking multiple files with <c-z>, open them in buffers
    let g:ctrlp_open_multiple_files = 'i'

  " Faster or something
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor

        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

        " No need for caching with ag
        let g:ctrlp_use_caching = 0

        " Search for word under cursor with M
        nnoremap M :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

        " Don't echo shell output
        set shellpipe=>

        " Use \ to search with Ag
        " From https://robots.thoughtbot.com/faster-grepping-in-vim
        command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
        nnoremap \ :Ag<SPACE>
    else
      let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
      let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
        \ }
    endif


" Togglelist
"============================================================================"
  let g:toggle_list_no_mappings = 1
  nmap <script> <silent> <leader>u :call ToggleQuickfixList()<CR>

" Airline
"============================================================================"
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='tomokai'


" Bufferline
"============================================================================"
  let g:bufferline_echo = 0
  let g:bufferline_show_bufnr = 0


" NERDTree
"============================================================================"
  let NERDTreeShowLineNumbers=1

  " Better NERDTree
    map <Leader>n <plug>NERDTreeTabsToggle<CR>

  " Show hidden files in NERDTree
    let NERDTreeShowHidden=1

  " Files to ignore
    let NERDTreeIgnore=['jsx-build$']


"" Relative line numbering
"============================================================================"
  au FocusLost * :set number
  au FocusGained * :set relativenumber

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
  set tw=80
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

  let g:neocomplete#enable_at_startup = 1
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"


" Searching
"============================================================================"
  set hlsearch                    " highlight matches
  set incsearch                   " incremental searching
  set ignorecase                  " searches are case insensitive...
  set smartcase                   " ... unless they contain at least one capital letter
  set gdefault                    " have :s///g flag by default on

  " turn off search highlighting after search by pressing Return/Enter
    nnoremap <BS> :nohlsearch<cr>
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
  " in a similar vein...
    nnoremap <Leader>l S
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

  " Use // for comments in .vue files to work with pug & scss (and js)
    autocmd FileType vue setlocal commentstring=//\ %s


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

  " Redo syntax highlighting
    noremap <F12> <Esc>:syntax sync fromstart<CR>
    inoremap <F12> <C-o>:syntax sync fromstart<CR>


" Yankstack settings
"============================================================================"
  " Rotate yanks forward
    nmap - <Plug>yankstack_substitute_older_paste
  " Rotate yanks backward
    nmap = <Plug>yankstack_substitute_newer_paste


" Snippets
"============================================================================"
  " Trigger configuration
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" Easymotion
"============================================================================"
  " Disable default mappings
    let g:EasyMotion_do_mapping = 0

  " Bind semicolon to comma before rebinding semicolon
    nnoremap , ;
  " Bi-directional find motion
  " `;{char}{label}`
    nmap ; <Plug>(easymotion-s)

  " Turn on case sensitive feature
    let g:EasyMotion_smartcase = 1


" RAINBOWS
"============================================================================"
  let g:rainbow_active = 1


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
