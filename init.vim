call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'Shougo/deoplete.nvim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'arcticicestudio/nord-vim'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
" Python
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
call plug#end()

let g:python3_host_prog = '/usr/bin/python3'
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 0

lua << EOF
local lsp = require "lspconfig"
-- local coq = require "coq"

lsp.tsserver.setup{}
-- lsp.tsserver.setup{coq.lsp.ensure_capabilities()}
-- lsp.pyright.setup{coq.lsp_ensure_capabilities()}
-- lsp.volar.setup{coq.lsp.ensure_capabilities()}
-- vim.cmd('COQnow -s')
EOF

map <C-p> :FZF <CR>
nnoremap <C-b> <cmd>Telescope registers<cr>
nnoremap <C-s> <cmd>Telescope lsp_document_symbols<cr>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nmap <silent> <C-k> :lua vim.lsp.diagnostic.goto_prev()<cr>
" nmap <silent> <C-j> :lua vim.lsp.diagnostic.goto_next()<cr>

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

let g:ale_linters = {
\   'python': ['flake8'],
\   'html': [],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'graphql': ['eslint'],
\   'vue': ['eslint'],
\ }
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

" Tab completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

map <leader>x :Explore <CR>

noremap <leader>p oimport pdb; pdb.set_trace()<Esc>
noremap <leader>c o// eslint-disable-next-line<Esc>oconsole.log()<Esc>

noremap <leader>d :PydocstringFormat<Esc>
