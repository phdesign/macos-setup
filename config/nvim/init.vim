" Load plugins with Plug
call plug#begin(stdpath('data') . '/plugged')

"Plug 'bkad/CamelCaseMotion'
"Plug 'dearrrfish/vim-applescript'
"Plug 'digitaltoad/vim-pug'
"Plug 'garbas/vim-snipmate'
"Plug 'genoma/vim-less'
"Plug 'godlygeek/tabular'
"Plug 'honza/vim-snippets'
"Plug 'JulesWang/css.vim'
"Plug 'majutsushi/tagbar'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'mxw/vim-jsx'
"Plug 'pangloss/vim-javascript'
"Plug 'PProvost/vim-ps1'
"Plug 'scrooloose/syntastic'
"Plug 'tomtom/tlib_vim'
"Plug 'tpope/vim-fugitive'
"Plug 'vim-scripts/AutoComplPop'
"Plug 'vim-scripts/hexHighlight.vim'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'djoshea/vim-autoread'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'jparise/vim-graphql'
Plug 'kien/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'Raimondi/yaifa'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
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
    "if has("gui_running") && argc() == 0
        "set fullscreen                          " start in fullscreen mode
    "endif
    set gfn=Fira\ Code:h14
    set guifont=Fira\ Code:h14
    let &directory=stdpath('data') . '/tmp/'
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
autocmd FileType html setlocal sts=2 ts=2 sw=2
autocmd FileType javascript setlocal sts=2 ts=2 sw=2
autocmd FileType less setlocal sts=2 ts=2 sw=2
autocmd FileType * setlocal formatoptions-=cro        " Disable auto insert comment after 'o' or 'O'
let g:html_indent_inctags="html,body,head,tbody"

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
" delete blank lines
map <leader>db :DeleteBlanks<cr>
" close buffer and switch to previous
nmap <leader>d :b#<bar>bd#<bar>b<cr>
" paste the system clipboard after this line
nmap <leader>p :pu *<cr>
" paste the system clipboard before this line
nmap <leader>P :pu! *<cr>
" Replace the word under cursor with " register
nmap <leader>rw "_diwP
" Replace the selection with " register
vmap <leader>rv "_diwP
" Replace word under cursor with system clipboard
nmap <silent> <leader>srw "_ciw<c-r>*<esc>
" Close all buffers but this
nmap <leader>bo :BufOnly<cr>
" Reset indentation to 2 spaces
nmap <leader>i2 :setlocal sts=2 ts=2 sw=2 et<cr>:IndentLinesReset<cr>
" Reset indentation to 4 spaces
nmap <leader>i4 :setlocal sts=4 ts=4 sw=4 et<cr>:IndentLinesReset<cr>
" Insert new GUID at current position (relies on `npm install -g node-uuid`)
nmap <leader>uu a<CR><ESC>:.-1read !uuid<CR>I<BS><ESC>j0i<BS><ESC>l
" run prettier
nmap <Leader>py <Plug>(Prettier)
" don't automatically open first search result with silver searcher
ca ag Ag!
ca Ag Ag!

if !has('win32')
    nmap <leader>g :silent !open %:p -a /Applications/Google\ Chrome.app/<cr>  " open in Google Chrome
endif

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

" vim-json
let g:vim_json_syntax_conceal = 0

" VIM Session
let g:session_autoload='no'
let g:session_autosave='yes'
let g:session_autosave_periodic=1
let g:session_autosave_silent=1
let g:session_directory=stdpath('data') . '/sessions'

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

" AutoComplPop
"call OnSyntaxChange#Install('Comment', '^Comment$', 0, 'i') 
"autocmd User SyntaxCommentEnterI silent! AcpLock 
"autocmd User SyntaxCommentLeaveI silent! AcpUnlock

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_python_python_exec = '/usr/local/bin/python3'

" Blamer.nvim
let g:blamer_enabled = 1

" Gutentags
" (thanks https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/)
let g:gutentags_ctags_executable_javascript = 'es-ctags'
"let g:gutentags_add_default_project_roots = 0
"let g:gutentags_project_root = ['package.json', '.git']

let g:gutentags_cache_dir = stdpath('data') . '/tmp/ctags/'
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" Conquer of Completion (coc)
let g:coc_global_extensions = [
    \ 'coc-angular',
    \ 'coc-css',
    \ 'coc-cssmodules',
    \ 'coc-emmet',
    \ 'coc-go',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-sh',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ 'coc-ultisnips',
    \ 'coc-yaml',
\ ]

" Prettier
let g:prettier#autoformat = 0       " Don't format on save
let g:prettier#partial_format=1     " Format just the selection by default (PrettierPartial)

" Allow project level configuration
set exrc
" Prevent :autocmd, shell and write commands
set secure

