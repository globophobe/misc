call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'numToStr/FTerm.nvim'
Plug 'Robitx/gp.nvim'
Plug 'dense-analysis/ale'
Plug 'github/copilot.vim'
Plug 'muniftanjim/nui.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'lewis6991/gitsigns.nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'rust-lang/rust.vim'
call plug#end()

lua << EOF
local actions = require "telescope.actions"
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-u>"] = false
      }
    }
  }
}

vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })

local fterm = require("FTerm")

local gitui = fterm:new({
    ft = 'fterm_gitui',
    cmd = "gitui",
    dimensions = {
        height = 0.9,
        width = 0.9
    }
})

vim.keymap.set('n', '<C-g>', function()
    gitui:toggle()
end)


local default_chat_system_prompt = "I am a programmer. I am asking you instead of searching stack overflow.\n"


require("gp").setup({ 
  providers = {
    googleai = {
			disable = false,
			endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
			secret = os.getenv("GOOGLEAI_API_KEY"),
		},
    copilot = {
      disable = false,
      endpoint = "https://api.githubcopilot.com/chat/completions",
      secret = {
        "bash",
        "-c",
        "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
			},
		},
  },
  agents = {
    {
			provider = "googleai",
			name = "ChatGemini",
			chat = true,
			command = true,
			-- string with model name or table with model name and parameters
			model = { model = "gemini-pro", temperature = 1.1, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = default_chat_system_prompt,
		},
    {
      provider = "copilot",
      name = "ChatCopilot",
      chat = true,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4", temperature = 1.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = default_chat_system_prompt,
    },
  },
  chat_confirm_delete = false
})

require('gitsigns').setup()
EOF

map <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-b> <cmd>Telescope registers<cr>
nnoremap <C-s> <cmd>Telescope lsp_document_symbols<cr>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.ts set filetype=typescript
    au BufNewFile,BufRead *.js set filetype=typescript
augroup END

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

let g:ale_python_auto_virtualenv = 1 
let g:ale_python_auto_poetry = 1 
let g:ale_disable_lsp = 1
let g:ale_use_neovim_diagnostics_api = 1
let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'python': ['ruff'],
\   'go': ['golangci-lint'],
\   'rust': ['analyzer'],
\   'html': [],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'graphql': ['eslint'],
\   'vue': ['eslint']
\ }
let g:ale_fixers = {
\   'python': ['black', 'ruff'],
\   'go': ['gofmt', 'goimports'],
\   'rust': ['rustfmt'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'graphql': ['prettier'],
\   'vue': ['prettier'],
\   'html': [],
\   'css': ['prettier'],
\   'json': ['prettier'],
\   'yaml': ['prettier']
\ }

map <leader>x :Explore <CR>

noremap <leader>f :GpChatToggle<Esc>
noremap <leader>p :GpChatPaste<Esc>
noremap <leader>d :GpChatDelete<Esc>

noremap <leader>e ofrom IPython import embed; embed()<Esc>
noremap <leader>t oimport pdb; pdb.set_trace()<Esc>
noremap <leader>c o// eslint-disable-next-line<Esc>oconsole.log()<Esc>
