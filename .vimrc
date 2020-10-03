" Plugins using Plug -----------------------------------------------------------------------------------------------{{{
" Install vim-plug plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins
call plug#begin('~/.vim/plugged')
" Theme
Plug 'morhetz/gruvbox'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Navigation tree:
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
" Icons
Plug 'ryanoasis/vim-devicons'
" git integration
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" ripgrep integration
Plug 'jremmen/vim-ripgrep'
" fzf integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()
"}}}

" Key mappings -----------------------------------------------------------------------------------------------------{{{
" Change leader key to space
let mapleader = " "
" Toggle highlighting on/off for current search matches
noremap <F4> :set hlsearch! hlsearch?<CR>
" Create a new tab
noremap <F7> :tabe
" Move to the next tab
noremap <F8> :tabp<CR>
" Toggle navigation tree
noremap <F10> :NERDTreeToggle<CR>
"}}}

" Color ------------------------------------------------------------------------------------------------------------{{{
" Enable syntax processing
syntax on
" Set color scheme
colorscheme gruvbox
" Set color scheme background
set background=dark
" Set color scheme for status bar
let g:airline_theme='gruvbox'
"}}}

" Tabs -------------------------------------------------------------------------------------------------------------{{{
" Set tab to be 2 characters (2 spaces)
set tabstop=2 softtabstop=2
" Use spaces for tabs
set expandtab
" Shift tab length is 2 spaces
set shiftwidth=2
" Try to match indentation based on code
set smartindent
"}}}

" Layout -----------------------------------------------------------------------------------------------------------{{{
" Show line numbers
set nu
" Don't wrap lines when too long
set nowrap
" Draw a wrapping column for 120 characters
set colorcolumn=120
"highlight ColorColumn ctermbg=0 guibg=lightgrey
" Make navigation tree show hidden files
let NERDTreeShowHidden=1
"}}}

" System -----------------------------------------------------------------------------------------------------------{{{
" Disable bell sound
set noerrorbells
" Disable temp files
set noswapfile
set nobackup
" Define undo directory
set undodir =~/.vim/undodir
set undofile
" Mouse support
set mouse=a
"}}}

" Spell checks -----------------------------------------------------------------------------------------------------{{{
" Enable spell checking
set spell spelllang=en
" Highlight spelling errors
highlight clear SpellBad
highlight SpellBad cterm=underline
highlight SpellBad gui=undercurl
" Spell check git commits
autocmd FileType gitcommit setlocal spell
" Autocomplete with dictionary words when spell check is on
set complete+=kspell
"}}}

" Search -----------------------------------------------------------------------------------------------------------{{{
" Ignore case until an upper case is typed in search
set smartcase
" Show match as characters are entered
set incsearch
" Allow ripgrep to search from the root of the project and use .gitignore for faster searching
if executable('rg')
  let g:rg_derive_root='true'
endif
" Search in a pop-up
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
" Show git files on top
let $FZF_DEFAULT_OPTS='--reverse'
"}}}

" Editing ----------------------------------------------------------------------------------------------------------{{{
" Make backspace work in insert mode
set backspace=indent,eol,start
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
" Automatically remove trailing white spaces on save
autocmd BufWritePre * :%s/\s\+$//e
"}}}
