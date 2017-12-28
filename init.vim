call plug#begin('~/.vim/plugged')
"
Plug 'cocopon/iceberg.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
"
call plug#end()

colorscheme iceberg

set number
let mapleader = ','
:tnoremap <Esc> <C-\><C-n>

set textwidth=80
set colorcolumn=+1

set nofoldenable

set shiftwidth=2
set tabstop=2

:filetype on
set expandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4

let g:ale_completion_enabled = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_linters = {'html': [], 'javascript': ['eslint'], 'python': ['flake8']}
let g:ale_fixers = {'css': ['prettier'], 'javascript': ['prettier_eslint'], 'typescript': ['prettier'], 'python': ['isort', 'yapf']}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:jedi#completions_enabled = 0
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

map <Leader>x :Explore <CR>

map <C-p> :FZF <CR>
noremap <C-b> :Buffers<CR>
noremap <C-h> :History<CR>
let g:fzf_buffers_jump = 1
