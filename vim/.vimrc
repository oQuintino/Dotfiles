" Main Settings

syntax on            " Enable syntax highlight
set nu               " Enable line numbers
set tabstop=4        " Show existing tab with 4 spaces width
set softtabstop=4    " Show existing tab with 4 spaces width
set shiftwidth=4     " When indenting with '>', use 4 spaces width
set expandtab        " On pressing tab, insert 4 spaces
set smarttab         " insert tabs on the start of a line according to shiftwidth
set smartindent      " Automatically inserts one extra level of indentation in some cases
set hidden           " Hides the current buffer when a new file is openned
set incsearch        " Incremental search
set ignorecase       " Ingore case in search
set smartcase        " Consider case if there is a upper case character
set scrolloff=8      " Minimum number of lines to keep above and below the cursor
set colorcolumn=100  " Draws a line at the given line to keep aware of the line size
set signcolumn=yes   " Add a column on the left. Useful for linting
set cmdheight=2      " Give more space for displaying messages
set updatetime=100   " Time in miliseconds to consider the changes
set encoding=utf-8   " The encoding should be utf-8 to activate the font icons
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set autoread         " Update vim after file update from outside
set mouse=a          " Enable mouse support
filetype on          " Detect and set the filetype option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any

set laststatus=2
set noshowmode

" Vim-plug Configurations

call plug#begin()

Plug 'junegunn/vim-plug'

" For reading .editorconfig files
Plug 'editorconfig/editorconfig-vim'

" Insert vim-airline info bar
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Use this instead of vim-airline
Plug 'itchyny/lightline.vim'

" Insert sonokai theme plugin
Plug 'sainnhe/sonokai'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
" Plug 'honza/vim-snippets'

" Autocompletion / linter / fixer / debugger Plugins
Plug 'dense-analysis/ale'

Plug 'neoclide/coc.nvim', {
			\ 'branch': 'release',
			\ 'for': ['c', 'cpp', 'python', 'ocaml', 'html', 'css', 'json']}

Plug 'puremourning/vimspector', { 'for': ['c', 'python'] }

" Insert a test plugin for each language
Plug 'vim-test/vim-test'

" All of your Plugins must be added before the following line
call plug#end()

filetype plugin indent on    " Required

" FZF

" Using fzf in combination with ripgrep to show only the files that are tracked by Git and ignoring
" the ones specified in the .gitignore file.
command! -bang -nargs=* Files
  \ call fzf#vim#files('', {'source': 'rg --files --hidden --glob "!.git/*"'}, <bang>0)

command! -bang Files call fzf#vim#files(expand('%:p:h'), {
  \ 'source': 'rg --files --hidden --glob "!.git/*"',
  \ 'options': '--preview "batcat --style=numbers --color=always --line-range :50 {}"'
  \ }, <bang>0)


" Mapeia Ctrl-P para abrir o finder de arquivos
nnoremap <silent> <C-p> :Files<CR>

" Pesquisa por buffers abertos
nnoremap <silent> <leader>fb :Buffers<CR>

" Pesquisa por palavras no projeto
nnoremap <silent> <leader>fg :Rg<CR>

" Pesquisa por tags
nnoremap <silent> <leader>ft :Tags<CR>

let g:fzf_preview_window = ['right:30%:hidden']

" CoC

let g:coc_global_extensions = [
\ 'coc-clangd',
\ 'coc-pyright',
\ 'coc-snippets',
\ 'coc-json'
\ ]

" Vimspector

let g:vimspector_enable_mappings = 'HUMAN'

let g:vimspector_install_gadgets = [ 'CodeLLDB' ]

" ALE

" Set this. Airline will handle the rest.
" let g:airline#extensions#ale#enabled = 1

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Don´t let ALE instantiate two clangd´s processes.
" Instead, it can reuse that´s already instantiated by Coc
let b:ale_linters = {'c': [], 'python': ['ruff', 'bandit'],}

let b:ale_fixers = {
\ '*': ['trim_whitespace'],
\ 'c': ['clang-format'],
\ 'python': ['isort', 'ruff_format'],
\ 'ocaml': ['ocp-indent'],
\ 'html': ['prettier'],
\ 'css': ['prettier'],
\ 'javascript': ['prettier'],
\ }

let g:ale_c_clangformat_options = "-style=file"

let g:ale_prettier_options = "--write"

" Airline

" let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1
" let g:airline_theme = 'sonokai'

let g:lightline = {
  \ 'colorscheme': 'sonokai',
  \ 'active': {
  \   'left': [ ['mode'], ['readonly', 'filename', 'modified'] ],
  \   'right': [ ]
  \ }
\ }

if has('termguicolors')
	set termguicolors
endif

let g:sonokai_style = 'espresso'
let g:sonokai_better_performance = 1
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 0
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_current_word = 'bold'

colorscheme sonokai
