set nocompatible
filetype off
filetype plugin indent on

inoremap <C-g> <ESC>
nnoremap <SPACE> <Nop>
let mapleader=" "

set hidden
set encoding=utf-8
set formatoptions-=tc

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

syntax on
set history=500
set shiftwidth=4
set tabstop=4
set expandtab
set ruler
set number
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set iskeyword-=_
set mouse=

" Custom Bindings
nnoremap <Up> <C-w>k
nnoremap <Down> <C-w>j
nnoremap <Left> <C-w>h
nnoremap <Right> <C-w>l

nnoremap t[ :tabprevious<CR>
nnoremap t] :tabnext<CR>
nnoremap t{ :-tabmove<CR>
nnoremap t} :+tabmove<CR>
nnoremap tn :tabnew<CR>
nnoremap tq :tabclose<CR>
nnoremap te :tabedit<CR>

nnoremap <leader>e :e ~/.config/nvim/vimrc.vim<CR>
nnoremap <leader>r :source ~/.config/nvim/init.lua<CR>
nnoremap <leader>R :e<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap <PageUp> :bprevious<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprevious<CR>
nnoremap <leader>l :b#<CR>
nnoremap <leader>d :BufDel<CR>
nnoremap <leader>D :BufDelOthers<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>f :Telescope find_files<CR>
nnoremap <leader>g :Telescope live_grep<CR>
nnoremap <leader>h :Telescope oldfiles<CR>
nnoremap <leader>H :Telescope command_history<CR>
nnoremap <leader>p :Telescope commmands<CR>
nnoremap <leader>k :Telescope registers<CR>
nnoremap <leader>/ :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>sl :Telescope possession list<CR>
nnoremap <leader>ss :PossessionSave<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :quitall<CR>
nnoremap <C-l> zz
nnoremap <Esc> :noh<CR>
nnoremap <leader>j <Plug>(easymotion-overwin-line)

" Plugin Installation
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'ojroques/nvim-bufdel'
Plug 'easymotion/vim-easymotion'
Plug 'roobert/search-replace.nvim'
Plug 'thaerkh/vim-indentguides'
Plug 'ntpeters/vim-better-whitespace'

Plug 'nvim-lua/plenary.nvim'
Plug 'jedrzejboczar/possession.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'kylechui/nvim-surround'
Plug 'luochen1990/rainbow'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'jnurmine/Zenburn'

call plug#end()

" Color Scheme
colorscheme zenburn

" Plugin Settings
let g:limelight_conceal_ctermfg = 'DarkGray'

let g:airline_section_b = '%{fnamemodify(getcwd(),":t")}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'

let g:NERDTreeWinSize=50
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:rainbow_active = 1
let g:better_whitespace_filetypes_blacklist = ['dashboard', 'nofile', 'terminal']

" Autocmd
"autocmd VimEnter * NERDTree | wincmd p | NERDTreeClose
