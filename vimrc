"|\     /|\__   __/(       )(  ____ )(  ____ \
"| )   ( |   ) (   | () () || (    )|| (    \/
"| |   | |   | |   | || || || (____)|| |
"( (   ) )   | |   | |(_)| ||     __)| |
" \ \_/ /    | |   | |   | || (\ (   | |
"  \   /  ___) (___| )   ( || ) \ \__| (____/\
"   \_/   \_______/|/     \||/   \__/(_______/
"
set nocompatible              " required
filetype off                  " required
"au FIleType perl set filetype=prolog

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/indentpython.vim'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'jakwings/vim-colors'
Plug 'vim-python/python-syntax'
Plug 'Valloric/YouCompleteMe'
Plug 'takac/vim-hardtime'
Plug 'lervag/vimtex'
call plug#end()


set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.
set nowrap                 " nobreak for a line of code
set number
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.
set ruler
set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set mouse=a
set incsearch              " Highlight while searching with / or ?.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

let mapleader="\<Space>"
:command WQ wq
:command Wq wq
:command W w
:command Q q
:nmap <leader>y +"y
"Remove trailing space before saving
autocmd BufWritePre * %s/\s\+$//e

"--------------------Nerd-Tree----------------
" show number
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeWinSize=25
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" quit nerd tree when quiting the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"open file at the last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Plugin settings

" toggle nerdtree
nmap <leader>nn :NERDTreeToggle<CR>
"show-indent-line
let g:indentLine_enabled = 1
let g:indentLine_char='¦'
"nerd-commenter
nmap <leader>cm  <leader>ci<CR>
" color
set t_Co=256
colorscheme gruvbox
"Python Syntax Plus
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

"YCM
"" 自动补全配置

set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" "回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR> "force recomile with syntastic
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = 'path to .ycm_extra_conf.py'
"

"GUI setting
set guifont=Input:h16
set linespace=6
" turn off the cursor blink
set gcr=a:block-blinkon0
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" turn of the toolbar and meau bar
set guioptions-=m
set guioptions-=T"
set background=dark


" Quickly Run
map <leader>b :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec '!gcc % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'cpp'
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'python'
        exec '!python3 %'
    "elseif &filetype == 'perl'
        "exec '!perl %'
    elseif &filetype == 'tex'
        exec '!xelatex %'
    elseif &filetype == 'sh'
        :!time bash %
    endif
endfunc

" vim-hard time
let g:hardtime_default_on = 0
let g:hardtime_ignore_buffer_patterns = [ "CustomPatt[ae]rn", "NERD.*" ]
let g:hardtime_timeout = 100
let g:hardtime_maxcount = 2
let g:hardtime_showmsg = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
let g:hardtime_allow_different_key = 1

""""""""""""""""Code Fold"""""""""""""""""

set foldmethod=indent
set foldlevelstart=99

""""""""""""""""""Vimtex setting""""""""""""""""""
set conceallevel=1
let g:tex_conceal='abdmg'

