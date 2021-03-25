" Plugins using Plug ---------------------------------------------------------------------------{{{
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
" git integration
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" ripgrep integration
Plug 'jremmen/vim-ripgrep'
" fzf integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" tmux integration
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
" Whitespaces - better highlighting and auto removal
Plug 'ntpeters/vim-better-whitespace'
" Markdown - syntax
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Markdown - live preview with local nodejs server
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Go programming
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Icons (load last)
Plug 'ryanoasis/vim-devicons'
call plug#end()
"}}}

" Key mappings ---------------------------------------------------------------------------------{{{
" Change leader key to space
let mapleader = " "
" Open a new empty buffer
nmap <leader>t :enew<cr>
" Move to the next buffer
nmap <leader><Right> :bnext<CR>
" Move to the previous buffer
nmap <leader><Left> :bprevious<CR>
" Close the current buffer and move to the previous one
nmap <leader><Down> :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader><Up> :ls<CR>
" Toggle paste mode to prevent auto indentation and comments
set pastetoggle=<F3>
" Toggle highlighting on/off for current search matches
noremap <F4> :set hlsearch! hlsearch?<CR>
" Toggle spell check
map <F5> :setlocal spell!<CR>
" Toggle relative line numbers and regular line numbers
nmap <F6> :set invrelativenumber<CR>
" Toggle visually showing all white space characters
noremap <F7> :set list!<CR>
inoremap <F7> <C-o>:set list!<CR>
cnoremap <F7> <C-c>:set list!<CR>
" Toggle navigation tree
noremap <F10> :NERDTreeToggle<CR>
"}}}

" Color ----------------------------------------------------------------------------------------{{{
" Enable syntax processing
syntax on
" Set color scheme
silent! colorscheme gruvbox
" Set color scheme background
set background=dark
" Set color scheme for status bar
let g:airline_theme='gruvbox'
"}}}

" Tabs -----------------------------------------------------------------------------------------{{{
" Set tab to be 2 characters (2 spaces)
set tabstop=2 softtabstop=2
" Use spaces for tabs
set expandtab
" Shift tab length is 2 spaces
set shiftwidth=2
" Try to match indentation based on code
set smartindent
"}}}

" Layout ---------------------------------------------------------------------------------------{{{
" Show line numbers
set nu
" Don't wrap lines when too long
set nowrap
" Draw a wrapping column for 100 characters
set colorcolumn=100
" Make navigation tree show hidden files
let NERDTreeShowHidden=1
" Show buffer list
let g:airline#extensions#tabline#enabled = 1
"}}}

" System ---------------------------------------------------------------------------------------{{{
" Set encoding to UTF-8
set encoding=UTF-8
" Disable bell sound
set noerrorbells
" Disable temp files
set noswapfile
set nobackup
" Define undo directory
set undodir =~/.vim/undodir
set undofile
" Allow switching between buffers without writing
set hidden
" Integrate system clipboard
set clipboard=unnamedplus
" Mouse support
set mouse=a
" Devicons and airline race condition fix: https://github.com/ryanoasis/vim-devicons/issues/266
set t_RV=
"}}}

" Spell checks ---------------------------------------------------------------------------------{{{
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

" Search ---------------------------------------------------------------------------------------{{{
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

" Editing --------------------------------------------------------------------------------------{{{
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

" NERDTree customization -----------------------------------------------------------------------{{{
" Make sure vim does not open files and other buffers on NerdTree window
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let g:plug_window = 'noautocmd vertical topleft new'
" Close NERDTree after opening a file in it
let g:NERDTreeQuitOnOpen = 1
" Close vim if the only window left is NERDTree
autocmd BufEnter
      \ * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"}}}

" vim-better-whitespace ------------------------------------------------------------------------{{{
let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=1
let g:strip_whitespace_on_save=1
"}}}

" Markdown plugins -----------------------------------------------------------------------------{{{
" markdown-preview - refresh slower for less CPU load
let g:mkdp_refresh_slow=1
" markdown-preview - custom CSS for github preview
let g:mkdp_markdown_css='~/.dotfiles/.local/github-markdown-css/gh-md.css'
"}}}
