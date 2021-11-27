call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ryanoasis/vim-devicons'
Plug 'arcticicestudio/nord-vim'
Plug 'justinmk/vim-sneak'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Python
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
call plug#end()

let g:python3_host_prog = '/usr/bin/python3.8'

autocmd VimEnter * CHADopen
autocmd VimEnter * COQnow [--shut-up]

lua << EOF
local lsp = require "lspconfig"
local coq = require "coq"

lsp.pyright.setup{coq.lsp_ensure_capabilities()}
lsp.tsserver.setup{coq.lsp_ensure_capabilities()}
EOF

nmap <silent> <C-k> :lua vim.lsp.diagnostic.goto_prev()<cr>
nmap <silent> <C-j> :lua vim.lsp.diagnostic.goto_next()<cr>

colorscheme nord
let mapleader = ','
:tnoremap <Esc> <C-\><C-n>

set colorcolumn=+1
set backupcopy=yes

set nofoldenable

set shiftwidth=2
set tabstop=2

:filetype on
set expandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 completeopt-=preview

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.ts set filetype=typescript
    au BufNewFile,BufRead *.js set filetype=typescript
augroup END

let g:pydocstring_formatter = 'google'

let g:ale_fixers = {
\   'python': ['isort', 'black'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'graphql': ['prettier'],
\   'vue': ['prettier'],
\   'html': [],
\   'css': ['prettier'],
\   'json': ['prettier']
\ }
let g:ale_fix_on_save = 1

nnoremap <leader>x <cmd>CHADopen<cr>

map <C-p> :FZF <cr>
noremap <C-h> :Buffers<cr>
let g:fzf_buffers_jump = 1

map f <Plug>Sneak_s
map F <Plug>Sneak_S

noremap <leader>p oimport pdb; pdb.set_trace()<Esc>
