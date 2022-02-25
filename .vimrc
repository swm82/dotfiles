" Don’t show the intro message when starting Vim
set shortmess=atI

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

" TABS (All tabs will be 4 spaces
" ----
set softtabstop=4
" Number of space chars inserted for indentation (prob when calling :retab to convert indent to tab)
set shiftwidth=4
" Expand tabs to spaces
set expandtab
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
" Enable syntax highlighting
syntax on
" Show the filename in the window titlebar
set title
" Set window title (%t is the original filename)
set titlestring=%t
" Have vim confirm if you :q or :e on an unsaved modified file
set confirm
" Use the dreaded mouse
set mouse=a
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamedplus
" Allow cursor keys in insert mode (vim only?)
" set esckeys
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
" Always show status line
set laststatus=2
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position - line number on bottom right
set ruler
" Show the current mode
set showmode
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Tell the bell to stfu
set noerrorbells visualbell t_vb=

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype indent plugin on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif


" PLUGINS
" -------
call plug#begin('~/.vim/plugged')
	Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-surround'
	Plug 'vim-syntastic/syntastic'
	Plug 'preservim/nerdcommenter'
	Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Theme
colorscheme dracula
" Status bar theme
let g:lightline = {
         \ 'colorscheme': 'dracula',
         \ }


" PLUGIN SETTINGS/CONFIG
" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" NERDcommenter
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" MAPPINGS
" --------
let mapleader=" "
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
" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Yank from cursor to the end of line.
nnoremap Y y$
" F6 to run current file as python script
" nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

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
"
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

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

" Python execution
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

set noshowmode " it's already in the lightline bar
