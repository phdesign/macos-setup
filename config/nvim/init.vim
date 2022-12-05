" Load plugins with Plug
call plug#begin(stdpath('data') . '/plugged')

"Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'christoomey/vim-sort-motion'
"Plug 'djoshea/vim-autoread'
Plug 'dsimidzija/vim-nerdtree-ignore'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'github/copilot.vim'
Plug 'kien/ctrlp.vim'
"Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
"Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'mg979/vim-visual-multi'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
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
set colorcolumn=80          " show a column marker
set showcmd                 " show number of selected lines

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
autocmd FileType typescript setlocal sts=2 ts=2 sw=2
autocmd FileType typescriptreact setlocal sts=2 ts=2 sw=2
autocmd FileType less setlocal sts=2 ts=2 sw=2
autocmd FileType go setlocal sts=4 ts=4 sw=4 noet nowrap
autocmd FileType * setlocal formatoptions-=cro        " Disable auto insert comment after 'o' or 'O'
let g:html_indent_inctags="html,body,head,tbody"

" Commands
command -range=% DeleteBlanks <line1>,<line2>g/^\s*$/d
command -range=% DeleteTrailingSpaces <line1>,<line2>s/\s\+$
command -range=% DeleteDuplicateLines <line1>,<line2>sort|<line1>,<line2>g/^\(.*\)\n\1$/d
command -nargs=0 Prettier :CocCommand prettier.formatFile

" Mapping
let mapleader = ","
" title case a line or selection (better)
vmap <leader>t :s/\%V\<\(\w\)\(\w*\)\>/\u\1\L\2/ge<bar>noh<cr>
" sort lines
map <leader>s :'<,'>sort i<cr>
" sort javascript object by keys
map <leader>sj :!node -r 'process' -e 'process.stdin.on("data", data => console.log(JSON.stringify(eval(`(${data})`))))' \| jq --sort-keys -c '.'<cr>
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
" Insert new GUID at current position (relies on python)
nmap <silent><leader>uu "=system('python -c "import uuid; print(uuid.uuid4(), end=\"\");"')<CR>p

" don't automatically open first search result with silver searcher
ca ag Ag!
ca Ag Ag!

" Invisibles
set listchars=tab:▸\ ,eol:¬
set list

" Airline
let g:airline_theme='tomorrow'
set laststatus=2           " show status bar even with no split
let g:airline_powerline_fonts=1                 " use powerline fonts
let g:airline#extensions#tabline#enabled=1      " enable the list of buffers
let g:airline#extensions#tabline#fnamemod=':t'  " just show the filename
let g:airline#extensions#nerdtree_status=0      " disable airline on NERDTree

function! AirlineInit()
  let g:airline_section_y=airline#section#create(['ffenc', ' ', '%{strftime("%I:%M%p")}'])
endfunction
autocmd VimEnter * call AirlineInit()

" indentLine 
" Fix indentLine concealing characters in json and md
let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0

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
let g:ctrlp_cmd='CtrlPMRU'                      " start ctrl-p in mru mode 
let g:ctrlp_show_hidden=1                       " let ctrl-p search hidden files (e.g. .gitignore)
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bower_components\|vendor'   " 

" vim-go
let g:go_fmt_autosave = 1
let g:go_imports_autosave = 1
let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_autosave = 1

" EditorConfig
let g:EditorConfig_disable_rules = ['max_line_length']

" Conquer of Completion (coc)
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-cssmodules',
    \ 'coc-emmet',
    \ 'coc-eslint',
    \ 'coc-go',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-jest',
    \ 'coc-json',
    \ 'coc-prettier',
    \ 'coc-pyright',
    \ 'coc-sh',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ 'coc-ultisnips',
    \ 'coc-yaml',
\ ]

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Enter to confirm completion.
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" CocFix mapped to Alt-Enter
nmap <silent> <a-cr> <Plug>(coc-fix-current)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" use ,k to show type help
nmap <silent> <leader>k :call CocAction('doHover')<cr>
" Format document / selection with coc (e.g. Prettier)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc-jest
" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
" Init jest in current cwd, require global jest command exists
command! JestInit :call CocAction('runCommand', 'jest.init')

" Enable fzf
set rtp+=/opt/homebrew/opt/fzf

" Allow project level configuration
set exrc
" Prevent :autocmd, shell and write commands
set secure
