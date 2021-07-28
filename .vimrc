" Use the Solarized Dark theme
set background=dark
colorscheme elflord
"let g:solarized_termtrans=1
" Enable powerline fonts in airline
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'

" Turn off the thing that turns off the cool parts of vim - make vim useful again
set nocompatible

" SEARCH
" ------
" Highlight search results while searching
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed (don't wait for enter)
set incsearch
" Use smartcase (if all lower case search qury, then insens. if one or more cap, case sens.
set smartcase

" TABS
" ----
" Expand tabs to spaces
set expandtab
" Make tabs as wide as two spaces
set tabstop=4
" Number of space chars inserted for indentation (prob when calling :retab to convert indent to tab)
set shiftwidth=4
" Automatically indent line the same as prev
set autoindent

" LINE NUMBERING
" --------------
" Enable line numbers
set number
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif

" COMMAND LINE COMPLETION
" Enable auto completion menu after pressing TAB.
set wildmenu
" on first tab, small unobtrusive menu on bottom with longest common str first, subsequent tabs cycle through rest
set wildmode=longest:full,full
" Wildmenu ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Buffers
" Allow unsaved work to live in hidden window
set hidden


" OTHER
" -----
" Set window title (%t is the original filename)
set titlestring=%t
" Have vim confirm if you :q or :e on an unsaved modified file
set confirm
" Use the dreaded mouse
set mouse+=a

" Determine filetype if possible, use it to allow intelligent auto-indenting and for plugins
if has('filetype')
	filetype indent plugin on
endif


" PLUGINS
" -------
call plug#begin('~/.vim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'preservim/nerdtree'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-surround'
	Plug 'vim-syntastic/syntastic'
call plug#end()

" SYNTASTIC RECOMMENDED SETTINGS
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" MAPPINGS
" --------
" Unbind stuff
nmap Q <Nop>
map <C-a> <Nop>
map <C-x> <Nop>
" Toggle NERDTree
map <F5> :NERDTreeToggle<CR>
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
" set backupdir=~/.vim/backups
" set directory=~/.vim/swaps
" if exists("&undodir")
" 	set undodir=~/.vim/undo
" endif

" Don’t create backups when editing files in certain directories
" set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable syntax highlighting
syntax on
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
"if has("autocmd")
"	" Enable file type detection
"	filetype on
"	" Treat .json files as .js
"	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
"	" Treat .md files as Markdown
"	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
"endif