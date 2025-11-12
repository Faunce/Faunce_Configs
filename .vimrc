" ═══════════════════════════════════════════════════════════════════════════════
"  VIM CONFIGURATION
"  A beautiful, organized configuration for productive editing
" ═══════════════════════════════════════════════════════════════════════════════

" ───────────────────────────────────────────────────────────────────────────────
"  Vim-Plug Plugin Manager Setup
" ───────────────────────────────────────────────────────────────────────────────
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = ""
let g:vim_bootstrap_editor = "vim"
let g:vim_bootstrap_theme = "molokai"
let g:vim_bootstrap_frams = ""

" Install vim-plug if not found
if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"
  autocmd VimEnter * PlugInstall
endif

" ───────────────────────────────────────────────────────────────────────────────
"  Plugin Installation
" ───────────────────────────────────────────────────────────────────────────────
call plug#begin(expand('~/.vim/plugged'))

" → File Navigation & Search
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/grep.vim'

" → Git Integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" → UI & Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/CSApprox'

" → Code Editing & Completion
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" → Session & Workflow
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'editor-bootstrap/vim-bootstrap-updater'

" → Custom Bundles
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

filetype plugin indent on

" ═══════════════════════════════════════════════════════════════════════════════
"  CORE SETTINGS
" ═══════════════════════════════════════════════════════════════════════════════

" ───────────────────────────────────────────────────────────────────────────────
"  Encoding & File Formats
" ───────────────────────────────────────────────────────────────────────────────
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set ttyfast

" ───────────────────────────────────────────────────────────────────────────────
"  Editor Behavior
" ───────────────────────────────────────────────────────────────────────────────
set backspace=indent,eol,start       " Make backspace work as expected
set hidden                            " Enable hidden buffers
set autoread                          " Auto-reload changed files
let mapleader=','                     " Set leader key to comma

" ───────────────────────────────────────────────────────────────────────────────
"  Indentation & Tabs
" ───────────────────────────────────────────────────────────────────────────────
set tabstop=4                         " Tab width
set softtabstop=0                     " Disable soft tabs
set shiftwidth=4                      " Indent width
set expandtab                         " Use spaces instead of tabs

" ───────────────────────────────────────────────────────────────────────────────
"  Search Settings
" ───────────────────────────────────────────────────────────────────────────────
set hlsearch                          " Highlight search results
set incsearch                         " Incremental search
set ignorecase                        " Case insensitive search
set smartcase                         " Smart case sensitivity

" ───────────────────────────────────────────────────────────────────────────────
"  Shell Configuration
" ───────────────────────────────────────────────────────────────────────────────
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" ═══════════════════════════════════════════════════════════════════════════════
"  VISUAL SETTINGS
" ═══════════════════════════════════════════════════════════════════════════════

" ───────────────────────────────────────────────────────────────────────────────
"  Appearance
" ───────────────────────────────────────────────────────────────────────────────
syntax on
set ruler                             " Show cursor position
set number                            " Show line numbers
set scrolloff=3                       " Keep 3 lines visible when scrolling
set laststatus=2                      " Always show status line
set title                             " Set terminal title
set titleold="Terminal"
set titlestring=%F

" Color scheme
let no_buffers_menu=1
colorscheme molokai
set t_Co=256
if &term =~ '256color'
  set t_ut=
endif

" ───────────────────────────────────────────────────────────────────────────────
"  Cursor & Visual Feedback
" ───────────────────────────────────────────────────────────────────────────────
set gcr=a:blinkon0                    " Disable cursor blinking
set mouse=a                           " Enable mouse support
set mousemodel=popup
set wildmenu                          " Enhanced command completion

" ───────────────────────────────────────────────────────────────────────────────
"  GUI-Specific Settings
" ───────────────────────────────────────────────────────────────────────────────
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1
  
  " Terminal color settings
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
endif

" ───────────────────────────────────────────────────────────────────────────────
"  Status Line
" ───────────────────────────────────────────────────────────────────────────────
set modeline
set modelines=10
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" ═══════════════════════════════════════════════════════════════════════════════
"  PLUGIN CONFIGURATION
" ═══════════════════════════════════════════════════════════════════════════════

" ───────────────────────────────────────────────────────────────────────────────
"  Airline (Status Line)
" ───────────────────────────────────────────────────────────────────────────────
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

" Airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴'
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" ───────────────────────────────────────────────────────────────────────────────
"  NERDTree (File Explorer)
" ───────────────────────────────────────────────────────────────────────────────
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

" ───────────────────────────────────────────────────────────────────────────────
"  FZF (Fuzzy Finder)
" ───────────────────────────────────────────────────────────────────────────────
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND = "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" Use ripgrep if available
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
" Use ag if available
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ───────────────────────────────────────────────────────────────────────────────
"  Grep
" ───────────────────────────────────────────────────────────────────────────────
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" ───────────────────────────────────────────────────────────────────────────────
"  Session Management
" ───────────────────────────────────────────────────────────────────────────────
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" ───────────────────────────────────────────────────────────────────────────────
"  UltiSnips (Snippets)
" ───────────────────────────────────────────────────────────────────────────────
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ───────────────────────────────────────────────────────────────────────────────
"  ALE (Linting)
" ───────────────────────────────────────────────────────────────────────────────
let g:ale_linters = {}

" ───────────────────────────────────────────────────────────────────────────────
"  IndentLine
" ───────────────────────────────────────────────────────────────────────────────
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = ''
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" ───────────────────────────────────────────────────────────────────────────────
"  Tagbar
" ───────────────────────────────────────────────────────────────────────────────
let g:tagbar_autofocus = 1

" ═══════════════════════════════════════════════════════════════════════════════
"  KEY MAPPINGS
" ═══════════════════════════════════════════════════════════════════════════════

" ───────────────────────────────────────────────────────────────────────────────
"  Command Abbreviations
" ───────────────────────────────────────────────────────────────────────────────
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" ───────────────────────────────────────────────────────────────────────────────
"  Function Keys
" ───────────────────────────────────────────────────────────────────────────────
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nmap <silent> <F4> :TagbarToggle<CR>

" ───────────────────────────────────────────────────────────────────────────────
"  Leader Mappings - File & Buffer Operations
" ───────────────────────────────────────────────────────────────────────────────
nnoremap <leader>. :lcd %:p:h<CR>
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" ───────────────────────────────────────────────────────────────────────────────
"  Leader Mappings - Splits
" ───────────────────────────────────────────────────────────────────────────────
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" ───────────────────────────────────────────────────────────────────────────────
"  Leader Mappings - Git Operations
" ───────────────────────────────────────────────────────────────────────────────
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Git commit --verbose<CR>
noremap <Leader>gsh :Git push<CR>
noremap <Leader>gll :Git pull<CR>
noremap <Leader>gs :Git<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiffsplit<CR>
noremap <Leader>gr :GRemove<CR>
nnoremap <Leader>o :.GBrowse<CR>

" ───────────────────────────────────────────────────────────────────────────────
"  Leader Mappings - Sessions
" ───────────────────────────────────────────────────────────────────────────────
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" ───────────────────────────────────────────────────────────────────────────────
"  Leader Mappings - Search & Navigation
" ───────────────────────────────────────────────────────────────────────────────
nnoremap <silent> <leader>f :Rgrep<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
nmap <leader>y :History:<CR>
nnoremap <silent> <leader><space> :noh<cr>

" ───────────────────────────────────────────────────────────────────────────────
"  Leader Mappings - Buffer Navigation
" ───────────────────────────────────────────────────────────────────────────────
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
noremap <leader>c :bd<CR>

" ───────────────────────────────────────────────────────────────────────────────
"  Leader Mappings - Terminal
" ───────────────────────────────────────────────────────────────────────────────
nnoremap <silent> <leader>sh :terminal<CR>

" ───────────────────────────────────────────────────────────────────────────────
"  Tab Navigation
" ───────────────────────────────────────────────────────────────────────────────
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" ───────────────────────────────────────────────────────────────────────────────
"  Window Navigation
" ───────────────────────────────────────────────────────────────────────────────
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" ───────────────────────────────────────────────────────────────────────────────
"  Search Enhancements
" ───────────────────────────────────────────────────────────────────────────────
nnoremap n nzzzv
nnoremap N Nzzzv

" ───────────────────────────────────────────────────────────────────────────────
"  Visual Mode Enhancements
" ───────────────────────────────────────────────────────────────────────────────
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ───────────────────────────────────────────────────────────────────────────────
"  Copy/Paste/Cut
" ───────────────────────────────────────────────────────────────────────────────
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" ───────────────────────────────────────────────────────────────────────────────
"  Path Expansion
" ───────────────────────────────────────────────────────────────────────────────
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" ═══════════════════════════════════════════════════════════════════════════════
"  COMMANDS & FUNCTIONS
" ═══════════════════════════════════════════════════════════════════════════════

" ───────────────────────────────────────────────────────────────────────────────
"  Custom Commands
" ───────────────────────────────────────────────────────────────────────────────
command! FixWhitespace :%s/\s\+$//e

" ───────────────────────────────────────────────────────────────────────────────
"  Custom Functions
" ───────────────────────────────────────────────────────────────────────────────
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

" ═══════════════════════════════════════════════════════════════════════════════
"  AUTOCOMMANDS
" ═══════════════════════════════════════════════════════════════════════════════

" ───────────────────────────────────────────────────────────────────────────────
"  Syntax Highlighting
" ───────────────────────────────────────────────────────────────────────────────
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" ───────────────────────────────────────────────────────────────────────────────
"  Cursor Position Memory
" ───────────────────────────────────────────────────────────────────────────────
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" ───────────────────────────────────────────────────────────────────────────────
"  Text File Wrapping
" ───────────────────────────────────────────────────────────────────────────────
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" ───────────────────────────────────────────────────────────────────────────────
"  Make & CMake
" ───────────────────────────────────────────────────────────────────────────────
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" ───────────────────────────────────────────────────────────────────────────────
"  GUI Specific
" ───────────────────────────────────────────────────────────────────────────────
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" ═══════════════════════════════════════════════════════════════════════════════
"  LOCAL CONFIGURATION
" ═══════════════════════════════════════════════════════════════════════════════

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" ───────────────────────────────────────────────────────────────────────────────
"  Final Settings
" ───────────────────────────────────────────────────────────────────────────────
set nopaste

" ═══════════════════════════════════════════════════════════════════════════════
"  END OF CONFIGURATION
" ═══════════════════════════════════════════════════════════════════════════════
