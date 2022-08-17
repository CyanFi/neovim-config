set number
set nocompatible
filetype off

call plug#begin('~/.local/shared/nvim/plugged')
    "status bar
    Plug 'https://github.com/vim-airline/vim-airline' " Status bar
    " Core completion extension
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    " Edit related
    Plug 'scrooloose/nerdtree' " file system
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'Yggdroot/indentLine'
    Plug 'https://github.com/tpope/vim-commentary' " comment
    Plug 'vim-python/python-syntax'
    " Plug 'vim-scripts/vim-auto-save'
    " Plug 'jiangmiao/auto-pairs'
    Plug 'https://github.com/preservim/tagbar'
    Plug 'tpope/vim-surround'
    Plug 'airblade/vim-gitgutter'
    Plug 'MattesGroeger/vim-bookmarks'
    " Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal, but not
    " working
    " Special Script Grammar enhancement
    Plug 'cespare/vim-toml'
    " Color Scheme
    Plug 'liuchengxu/space-vim-theme'
    Plug 'junegunn/seoul256.vim'
    Plug 'crusoexia/vim-monokai'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'rakr/vim-one'
    "Goyo
    Plug 'junegunn/goyo.vim'
call plug#end()


" set up the python version Vim is gonna use
" let g:python3_host_prog= "/usr/bin/python3"
let g:python3_host_prog = "/research/d4/gds/yzhuang22/anaconda3/bin/python"
" let g:python_host_prog = "/research/d4/gds/yzhuang22/anaconda3/bin/python"

set fileencodings=utf-8
set termencoding=utf-8
set encoding=utf-8

filetype plugin indent on  " Load plugins according to detected filetype.
if !exists("g:syntax_on") "Enable syntax
    syntax enable
endif

set nowrap                 " nobreak for a line of code
"set nu

set backspace=indent,eol,start
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set tabstop=4              " Tab key indents by 4 spaces
set shiftwidth  =4         "  indents by 4 spaces.
set shiftround             "  indents to next multiple of 'shiftwidth'.
set display     =lastline  " Show as much as possible of the last line.
set ruler
set showmode               " Show current mode in command-line.
set laststatus  =2         " Always show statusline.
set showcmd                " Show already typed keys when more are expected.
set mouse=ac
set incsearch              " Highlight while searching with / or ?.
set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

" tagbar
nmap <F8> :TagbarToggle<CR>
" leader key related
"let mapleader="\<Space>"
:command WQ wq
:command W w
:command Q q

" copy text to clipboard
map <leader>y "+y 
"save
map <leader>s :w<CR> 
imap jk <ESC>

" modifiy the insert mode behavior
inoremap <C-F> <Right>
inoremap <C-B> <Left>

"open file at the lat position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Plugin settings
"--------------------Nerd-Tree----------------
" show number
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeWinSize=20
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" quit nerd tree when quiting the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" toggle nerdtree
nmap <leader>nn :NERDTreeToggle<CR>

"show-indent-line
let g:indentLine_enabled = 1
let g:indentLine_char='¦'

" Goyo
nmap <leader>o :Goyo<CR>

" Fold
set foldmethod=indent "syntax highlighting items specify folds
set foldlevelstart=99 "start file with all folds opened

" Auto Save
let g:auto_save = 1
let g:auto_save_slient = 1

" True color terminal support
set t_Co=256
set termguicolors
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 237
colo seoul256

" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
" let g:seoul256_background = 256
" colo seoul256
" " set background=dark
" colorscheme one 
"colorscheme PaperColor
"colorscheme monokai
"colorscheme space_vim_theme
"
"For horizon color theme
"colorscheme horizon
 "lightline
"let g:lightline.colorscheme = 'horizon'
 "or this line
"let g:lightline = {'colorscheme' : 'horizon'}


"Python Syntax Plus
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

" coc Autocompletion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" confirm by <CR>
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Vim Bookmark
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '⚑'
let g:bookmark_highlight_lines = 1

" Quick Run
map <leader>r :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec '!gcc % -o %<'
        exec '!time ./%<'
        exec '!rm %<'
    elseif &filetype == 'cpp'
        exec '!g++ % -o %<'
        exec '!time ./%<'
        exec '!rm %'
    elseif &filetype == 'python'
        exec '!python3 %'
    elseif &filetype == 'tex'
        exec '!xelatex %'
    elseif &filetype == 'php'
        exec '!php %'
    elseif &filetype == 'sh'
        exec '!./%'
    elseif &filetype == 'javascript'
        exec '!node %'
    elseif &filetype == 'typescript'
        exec '!tsc %'
    :endif
:endfunction
