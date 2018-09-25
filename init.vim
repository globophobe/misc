call plug#begin('~/.vim/plugged')
"
Plug 'arcticicestudio/nord-vim'
Plug 'Shougo/deoplete.nvim'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
"
call plug#end()

colorscheme nord

set number
let mapleader = ','
:tnoremap <Esc> <C-\><C-n>

set colorcolumn=+1
set backupcopy=yes

set nofoldenable

set shiftwidth=2
set tabstop=2

:filetype on
set expandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4

let g:jedi#completions_enabled = 0
let g:pymode_rope = 0
" b/c: from foo import import bar
let g:jedi#smart_auto_mappings = 0

let ale_python_auto_pipenv = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_python_flake8_args=""
let g:ale_linters = {'html': [], 'javascript': ['eslint'], 'vue': ['eslint'], 'python': ['pylint', 'flake8 --max-line-length=89']}
let g:ale_fixers = {'css': ['prettier'], 'javascript': ['prettier'], 'typescript': ['prettier'], 'vue': ['prettier'], 'python': ['isort', 'black']}
let g:ale_fix_on_save = 1
" let g:ale_javascript_prettier_options = '--trailing-comma es5'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:jedi#completions_enabled = 1
let g:jedi#force_py_version = 3
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

map <Leader>x :Explore <CR>

map <C-p> :FZF <CR>
noremap <C-h> :Buffers<CR>
let g:fzf_buffers_jump = 1

" From the minimal but useful vimrc example:
" https://github.com/easymotion/vim-easymotion

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" s{char} to move to {char}
map  s <Plug>(easymotion-bd-f)
nmap s <Plug>(easymotion-overwin-f)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

nnoremap <leader>p oimport pdb; pdb.set_trace()<Esc>
