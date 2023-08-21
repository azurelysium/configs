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
set hlsearch
set number
set backspace=indent,eol,start

" Custom Bindings
map t[ :tabprevious<cr>
map t] :tabnext<cr>
map t{ :-tabmove<cr>
map t} :+tabmove<cr>
map tn :tabnew<cr>
map tq :tabclose<cr>
map te :tabedit<cr>

map <ESC> :noh<CR>
map <Up> <C-w>k
map <Down> <C-w>j
map <Left> <C-w>h
map <Right> <C-w>l

nnoremap <leader>e :tabe ~/.config/nvim/vimrc.vim<CR>
nnoremap <leader>r :source ~/.config/nvim/init.lua<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap <PageUp> :bprevious<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprevious<CR>
nnoremap <leader>l :b#<CR>
nnoremap <leader>d :BufDel<CR>
nnoremap <leader>D :BufDelOthers<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>p :GFiles<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>/ :Rg<CR>
nnoremap <leader>q :qa<CR>
nnoremap <C-l> zz

" Plugin Installation
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'ojroques/nvim-bufdel'
Plug 'easymotion/vim-easymotion'
Plug 'thaerkh/vim-indentguides'
Plug 'ntpeters/vim-better-whitespace'

Plug 'mhinz/vim-startify'
Plug 'ibhagwan/fzf-lua'
Plug 'gennaro-tedesco/nvim-possession'

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'kylechui/nvim-surround'
Plug 'luochen1990/rainbow'

Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'jnurmine/Zenburn'

call plug#end()

" Color Scheme
colorscheme zenburn

" Plugin Settings
let g:limelight_conceal_ctermfg = 'DarkGray'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let g:NERDTreeWinSize=50
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:rainbow_active = 1
let $FZF_DEFAULT_COMMAND = 'rg --files'

" Autocmd
autocmd VimEnter * NERDTree | wincmd p | NERDTreeClose