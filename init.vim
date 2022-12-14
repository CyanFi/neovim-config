set number
set nocompatible
filetype off

call plug#begin('~/.local/shared/nvim/plugged')
    "tag line 
    Plug 'nanozuki/tabby.nvim'
    "status bar
    " Plug 'https://github.com/vim-airline/vim-airline' " Status bar
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'romgrk/barbar.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    " Core completion extension
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    " Find files
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'sharkdp/fd' " (finder)
    " Plug 'nvim-treesitter/nvim-treesitter ' "(finder/preview)
    Plug 'BurntSushi/ripgrep'
    " Edit related
    Plug 'scrooloose/nerdtree' " file system
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
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
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




"Status bar
lua << END
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '???'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return '???'
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = '??? ', warn = '??? ', info = '??? ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = '??? LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '???',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = '??? ', modified = '??? ', removed = '??? ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '???'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
END





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
let g:NERDTreeDirArrowExpandable = '???'
let g:NERDTreeDirArrowCollapsible = '???'
" quit nerd tree when quiting the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" toggle nerdtree
nmap <leader>nn :NERDTreeToggle<CR>

"show-indent-line
let g:indentLine_enabled = 1
let g:indentLine_char='??'

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

" Load the colorscheme
" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
" let g:seoul256_background = 256
colo seoul256
" colo seoul256-light

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
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Vim Bookmark
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '???'
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
