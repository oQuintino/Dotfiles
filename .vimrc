" Author: oQuintino
" Source: https://github.com/oQuintino/Dotfiles
" Description: Personal Vim configuration file.


" Main Settings
" Adapted From: https://www.manualdocodigo.com.br/vim-basico/

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
set scrolloff=5      " Minimum number of lines to keep above and below the cursor
set colorcolumn=100  " Draws a line at the given line to keep aware of the line size
set signcolumn=yes   " Add a column on the left. Useful for linting
set cmdheight=2      " Give more space for displaying messages
set updatetime=300   " Time in miliseconds to consider the changes
set encoding=utf-8   " The encoding should be utf-8 to activate the font icons
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set autoread         " Update vim after file update from outside
filetype on          " Detect and set the filetype option and trigger the FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any

set relativenumber
set signcolumn=yes
set shortmess+=c    " Less messages
set laststatus=2
set noshowmode

" Bundle

if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * ++once PlugInstall --sync | source $MYVIMRC
endif

" Vim-plug

call plug#begin()

" Minimal setup
Plug 'tpope/vim-sensible'

" For reading .editorconfig files
Plug 'editorconfig/editorconfig-vim'

" The sonokai theme
Plug 'sainnhe/sonokai'

" Syntax highlight
Plug 'sheerun/vim-polyglot'

" The vim-airline info bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" The fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Autocompletion, linter, fixer and debugger Plugins
Plug 'dense-analysis/ale'

let g:coc_filetypes = ['c', 'cpp', 'python', 'ocaml', 'html', 'css', 'json']

Plug 'neoclide/coc.nvim', { 'branch': 'release', 'for': g:coc_filetypes }

Plug 'honza/vim-snippets', { 'for': g:coc_filetypes }

Plug 'puremourning/vimspector', { 'for': ['c', 'python'] }

" Test plugin
Plug 'vim-test/vim-test', { 'for': ['python'] }

call plug#end()

" FZF

let g:fzf_preview_window = ['right:30%:hidden']

" Using fzf in combination with ripgrep to show only the files that are tracked by Git and ignoring
" the ones specified in the .gitignore file.
command! -bang -nargs=* Files
      \ call fzf#vim#files('', {'source': 'rg --files --hidden --glob "!.git/*"'}, <bang>0)

command! -bang Files call fzf#vim#files(getcwd(), {
      \ 'source': 'rg --files --hidden --follow --glob "!.git/*"',
      \ 'options': '--preview "batcat --style=numbers --color=always --line-range :50 {}" ' .
      \ '--layout=reverse'
      \ }, <bang>0)

nnoremap <silent> <C-p> :Files<CR>

nnoremap <silent> <leader>fb :Buffers<CR>

nnoremap <silent> <leader>fg :Rg<CR>

nnoremap <silent> <leader>ft :Tags<CR>

" CoC

let g:coc_global_extensions = [
      \ 'coc-diagnostic',
      \ 'coc-clangd',
      \ 'coc-pyright',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-snippets',
      \ 'coc-pairs'
      \ ]

augroup CocKeymaps
  autocmd!
  autocmd User CocNvimInit source ~/.vim/coc_keymaps.vim
augroup END

" Vimspector

let g:vimspector_enable_mappings = 'HUMAN'

let g:vimspector_install_gadgets = ['CodeLLDB']

" ALE

let g:ale_enabled = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'

let g:ale_fixers = {
      \ '*': ['trim_whitespace', 'remove_trailing_lines'],
      \ 'c': ['clang-format'],
      \ 'python': ['isort', 'ruff_format'],
      \ 'ocaml': ['ocp-indent'],
      \ 'html': ['prettier'],
      \ 'css': ['prettier'],
      \ 'javascript': ['prettier'],
      \ }

let g:ale_c_clangformat_options = "-style=file"

let g:ale_prettier_options = "--write"

let g:ale_fix_on_save = 1

" Airline

let g:airline_powerline_fonts = 0
let g:airline_theme = 'sonokai'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#coc#enabled = 1

let g:airline_section_z = '%l:%c'

" Sonokai

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
