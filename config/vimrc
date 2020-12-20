call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'djoshea/vim-autoread'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'kien/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/BufOnly.vim'
Plug 'vim-scripts/OnSyntaxChange'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Yggdroot/indentLine'

call plug#end()

" General
color Tomorrow-Night-Eighties
set number                  " show line numbers
set nohlsearch              " disable highlight searched phrases.
set ignorecase              " make searches case-insensitive.
"set spell spelllang=en_au   " enable spell check
"set autochdir               " change working directory to the active file
set hidden                  " allow switching buffers without saving
"set wrap                    " enable wrapping
set linebreak               " don't split words when wrapping
set synmaxcol=250           " improve performance when displaying super long lines
set nostartofline           " stop jumping to start of line when switching buffer
set colorcolumn=120         " show a column marker

" highlight the current line but only in active window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

if !has('win32')
    set gfn=Fira\ Code\ Light:h14
    set guifont=Fira\ Code\ Light:h14
    set guioptions=
    set directory=$HOME/.vim/tmp/
    set mouse=a

    " Stop annoying shift arrow mistakes
    nmap <S-Up> V
    nmap <S-Down> V
    vmap <S-Up> k
    vmap <S-Down> j

    " SHIFT-ALT-L like ReShaper show in file list 
    nmap Ò :NERDTreeFind<cr>
endif

" Indentation
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 4 columns
set expandtab             " use spaces instead of tabs
autocmd FileType go setlocal sts=4 ts=4 sw=4 noet nowrap
autocmd FileType * setlocal formatoptions-=cro        " Disable auto insert comment after 'o' or 'O'

" Commands
command -range=% DeleteBlanks <line1>,<line2>g/^\s*$/d
command -range=% DeleteTrailingSpaces <line1>,<line2>s/\s\+$
command -range=% DeleteDuplicateLines <line1>,<line2>sort|<line1>,<line2>g/^\(.*\)\n\1$/d

" Mapping
let mapleader = ","
" title case a line or selection (better)
vmap <leader>t :s/\%V\<\(\w\)\(\w*\)\>/\u\1\L\2/ge<bar>noh<cr>
" sort lines
map <leader>s :'<,'>sort i<cr>
" close buffer and switch to previous
nmap <leader>d :b#<bar>bd#<bar>b<cr>
" Close all buffers but this
nmap <leader>bo :BufOnly<cr>
" Reset indentation to 2 spaces
nmap <leader>i2 :setlocal sts=2 ts=2 sw=2 et<cr>:IndentLinesReset<cr>
" Reset indentation to 4 spaces
nmap <leader>i4 :setlocal sts=4 ts=4 sw=4 et<cr>:IndentLinesReset<cr>

" Invisibles
set listchars=tab:▸\ ,eol:¬
set list

" Airline
let g:airline_theme='tomorrow'
set laststatus=2           " show status bar even with no split
let g:airline_powerline_fonts=1                 " use powerline fonts
let g:airline#extensions#tabline#enabled=1      " enable the list of buffers
let g:airline#extensions#tabline#fnamemod=':t'  " just show the filename
let g:airline#extensions#gutentags#enabled=1    " enable gutentags
let g:airline#extensions#nerdtree_status=0      " disable airline on NERDTree

function! AirlineInit()
  let g:airline_section_y=airline#section#create(['ffenc', ' ', '%{strftime("%I:%M%p")}'])
endfunction
autocmd VimEnter * call AirlineInit()

" VIM Session
let g:session_autoload='no'
let g:session_autosave='yes'
let g:session_autosave_periodic=1
let g:session_autosave_silent=1

" NERDTree
"let g:nerdtree_tabs_open_on_gui_startup=0      " disable nerdtree_tabs on startup as it conflicts with vim-session
let NERDTreeShowHidden=1    " show hidden files a folders in NERDTree
"let NERDTreeShowBookmarks=1 " show bookmarks table in NERDTreeA
nmap <leader>ne :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.swp$', '\~$', '\.DS_Store']
" Fix issue that NERDTree is always collapsed. Restore size
autocmd SessionLoadPost * exe 'vert 1resize 31'

" Ctrl-P
let g:ctrlp_working_path_mode='ra'              " use the nearest .git directory as the cwd
let g:ctrlp_cmd='CtrlPMixed'                    " start ctrl-p in mixed mode 
let g:ctrlp_show_hidden=1                       " let ctrl-p search hidden files (e.g. .gitignore)
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bower_components\|vendor'   " 

" Conquer of Completion (coc)
let g:coc_node_path = '/Users/paul/.nvm/versions/node/v14.8.0/bin/node'
let g:coc_global_extensions = [
    \ 'coc-go',
    \ 'coc-highlight',
    \ 'coc-snippets',
    \ 'coc-ultisnips',
\ ]

" Allow project level configuration
set exrc
" Prevent :autocmd, shell and write commands
set secure

