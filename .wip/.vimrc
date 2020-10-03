" Install vim-plug plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins ---------------------------------------------------------------------------------------------------------{{{
call plug#begin('~/.vim/plugged')
" Theme
Plug 'morhetz/gruvbox'
" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" icons
Plug 'ryanoasis/vim-devicons'
" navigation tree:
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
" git integration
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" insert mode addons
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'
" file structure panel
Plug 'majutsushi/tagbar'
" go language support
Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go', { 'for': 'go' }
" JSON syntax highlighting
Plug 'elzr/vim-json', { 'for': 'json' }
" RST support
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'
" Markdown support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'vimwiki'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['markdown', 'vimwiki'] }
Plug 'masukomi/vim-markdown-folding', { 'for': ['markdown', 'vimwiki'] }
" create and manage wiki/todo lists
Plug 'vimwiki/vimwiki'
" fzf integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" tmux integration
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'wellle/tmux-complete.vim'
" code completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make', 'for': 'go'}
Plug 'deoplete-plugins/deoplete-zsh', { 'for': 'zsh'}
Plug 'ujihisa/neco-look'
" code snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()
"}}}

" Theme, status line, UI layout -----------------------------------------------------------------------------------{{{
silent! colorscheme gruvbox										" Set color scheme
set background=dark										" Set color scheme background
let g:airline_theme='gruvbox'							" vim-airline configuration
set encoding=UTF-8
set textwidth=120
set colorcolumn=+1        								" Make it obvious where 120 characters is
set number 												" Show line numbers
set numberwidth=5
set nocompatible										" Make sure VIM is not in VI mode
set ttyfast 											" Faster redraw
set clipboard=unnamedplus 								" Clipboard integration
set mouse=a 											" Mouse support
set showcmd 											" Show command in bottom bar
set wildmenu 											" Enable vim command completion
set showmatch 											" Highlight matching parenthesis and jump to them
set hidden        										" Allow hidden un-saved buffers
set splitbelow    										" vsplit goes below
set splitright    										" hsplit goes to the right
"set diffopt+=vertical 									" Always use vertical diffs
noremap <F7> :tabe 										" Create a new tab
noremap <F8> :tabp<CR> 									" Move to next tab
let NERDTreeShowHidden=1
noremap <F11> :NERDTreeToggle<CR>							" Toggle NERDTree
nnoremap <F12> :TagbarToggle<CR>						" Toggle structure on right side
"}}}

" UX --------------------------------------------------------------------------------------------------------------{{{
let mapleader = " "
let maplocalleader = ","

set laststatus=2  													" Always display the status line
set autowrite     													" Automatically :write before running commands

" Switch between the last two files
nnoremap <leader><leader> <c-^>
nnoremap cp :let @+ = expand("%") <CR>  							" Copy current files path to clipboard
nnoremap <Leader>v :e ~/.vimrc<CR>  								" Open vimrc
nnoremap <Leader>z :e ~/.zshrc<CR>  								" Open zshrc
nnoremap <Leader>e :enew<CR>        								" Load empty buffer
nnoremap <Leader>s :e /tmp/scratch<CR>  							" Scratch tmp file

" Close current window alias
nnoremap <leader>c <C-w>c

" Quick escape from INSERT
inoremap jj <ESC>

" Kill buffers without having to kill the window
nnoremap <leader>bd :bp<CR>:bd#<CR>

" Quickfix navigation shortcuts
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
nnoremap <leader>A :cwindow<CR>

" Rotate number mode
function! RotateNumberMode() abort
  if (&number) && (&relativenumber)
    set norelativenumber
  elseif (&number) && !(&relativenumber)
    set nonumber
  else
    set number relativenumber
  endif
endfunction
nnoremap <leader>n :call RotateNumberMode()<CR>

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Use shell syntax for env files
autocmd BufRead,BufNewFile .env,.env.*,env,env.* set syntax=sh

" Use arrow key to resize window
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Key mappings for terminal mode
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-h> <C-\><C-n><C-w>h
:tnoremap <C-j> <C-\><C-n><C-w>j
:tnoremap <C-k> <C-\><C-n><C-w>k
:tnoremap <C-l> <C-\><C-n><C-w>l

" Moving lines up/down using ALT-J/K
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Unintentional shift annoyances
:command WQ wq
:command Wq wq
:command W w
:command Q q
"}}}

" Syntax ----------------------------------------------------------------------------------------------------------{{{
syntax enable 																" Enable syntax processing
" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1
"}}}

" Tabs, indentation, spacing --------------------------------------------------------------------------------------{{{
set tabstop=2       " 2 space tab
set expandtab									" Use spaces for tabs
set softtabstop=2								" Delete and insert the entire tab
set shiftwidth=2								" Shift the entire tab when using indentation commands in normal mode 
set autoindent 									" Automatically follow indentation of previous line
set smartindent 								" Try to match indentation based on code
set pastetoggle=<F5> 							" Toggle pasting without changing indentation
noremap <F6> gg=G<C-o><C-o> 					" Fix indentation
set backspace=indent,eol,start 					" Make backspace work in insert mode

" Turn filetype detection, and relevant plugin and indent rules files loading
filetype plugin indent on 						

" Whitespace handling
set nojoinspaces          						" Use one space, not two, after punctuation
autocmd BufWritePre * :%s/\s\+$//e 				" Auto-remove trailing whitespaces on save
set list listchars=tab:»·,trail:·,nbsp:·
set nolist
nnoremap <F5> :set list!<CR>
nnoremap <F6> :StripWhitespace<CR>
"}}}

" Folding ---------------------------------------------------------------------------------------------------------{{{
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0
autocmd FileType go setlocal foldmethod=indent
autocmd FileType javascript,typescript,css,scss,json setlocal foldmethod=marker
autocmd FileType javascript,typescript,css,scss,json setlocal foldmarker={,}
set foldlevel=99
"}}}

" Completion and snippets -----------------------------------------------------------------------------------------{{{
silent! let g:deoplete#enable_at_startup = 1
silent! call deoplete#custom#source('ultisnips', 'rank', 9999) 								" Snippets first

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<C-j>'

" Snippets dirs
let g:UltiSnipsSnippetDirectories=['mysnippets', 'UltiSnips']
"}}}

" Spelling --------------------------------------------------------------------------------------------------------{{{
set spell spelllang=en 													" Enable spell checking
hi clear SpellBad 														" Highlight spelling errors
hi SpellBad cterm=underline
hi SpellBad gui=undercurl

" Spell check git commits
autocmd FileType gitcommit setlocal spell

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Toggle spellchecking
" function! ToggleSpellCheck()
"   set spell!
"   if &spell
"     echo "Spellcheck ON"
"   else
"     echo "Spellcheck OFF"
"   endif
" endfunction
" 
" nnoremap <silent> <Leader>S :call ToggleSpellCheck()<CR>"
"}}}

" Search ----------------------------------------------------------------------------------------------------------{{{
set ignorecase 											" Ignore case (except smartcase)
set smartcase     										" Do not ignore case if there is a capital letter
set incsearch 											" Show match as characters are entered
set hlsearch 											" Highlight all matches
noremap <F4> :set hlsearch! hlsearch?<CR> 				" Toggle highlighting on/off for current search matches

" :Cd - autocomplete directory and cd to it
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'fdfind --follow --hidden --type d --exclude .git .* $HOME',
  \  'sink': 'cd'}))

" Key mappings
nnoremap q: :History:<CR>
nnoremap q/ :History/<CR>
nnoremap <Leader>' :History<CR>
nnoremap <leader>, :Files<CR>
nnoremap <leader>h :Helptags<CR>
nnoremap <leader>; :Buffers<CR>
nnoremap <leader>cd :Cd ~<CR>
nnoremap <leader>/ :BLines<CR>
nnoremap <ESC> :nohls<CR>

" Override some terminal mode mappings for expected behavior
augroup fzf
  au!
  au FileType fzf tnoremap <nowait><buffer> <esc> <C-g>
  au FileType fzf tnoremap <nowait><buffer> <C-j> <Down>
  au FileType fzf tnoremap <nowait><buffer> <C-k> <Up>
augroup END

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%:hidden', '?')
  \                         : fzf#vim#with_preview('right:50%'),
  \                 <bang>0)

nnoremap \ :Ag<CR>
let g:fzf_files_options =
      \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Silver Searcher integration
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --follow

  " :Agr for raw grep using 'ag' with command line args
  if !exists(":Agr")
    command -nargs=+ -complete=file -bar Agr silent! grep! <args>|cwindow|redraw!
  endif
endif

" Disable CtrlP key binding. Keeping plugin only as vim-go dependency
autocmd VimEnter * nnoremap <C-P> :echo "Use FZF!"<CR>
"}}}

" Go support ------------------------------------------------------------------------------------------------------{{{
augroup goMappings
  au!
  au FileType go nmap <leader>r <Plug>(go-run-vertical)
  au FileType go nmap <leader>rs <Plug>(go-run-split)
  au FileType go nmap <leader>t :GoTest -v<CR>
  au FileType go nmap <leader>i :GoInstall<CR>
  au FileType go nmap <leader>b :GoBuild<CR>
  au FileType go nmap <leader>d :GoDoc<CR>
  au FileType go nmap <leader>D :GoDocBrowser<CR>
  au FileType go nmap <leader>I :GoInfo<CR>
  au FileType go nmap <leader>l :GoDecls<CR>
  au FileType go nmap <leader>L :GoDeclsDir<CR>
  au FileType go nmap <leader>R :GoReferrers<CR>
  au FileType go nmap <leader>rr :GoRename<CR>
augroup END

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:syntastic_check_on_open=1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"let g:go_snippet_engine = "neosnippet"
let g:go_snippet_engine = "automatic"
let g:go_term_enabled = 1
"let g:go_auto_sameids = 1
"}}}






" TODO: Add a comment for every command
" TODO: Go vher the following to see it they're needed
"if (has("termguicolors"))
"  set termguicolors " true color support
"endif
"set noshowmode    " let lightline tell the mode
"set noruler       " let lightline show cursor lpcation
"set inccommand=split  " incremental substitution
"set undofile
"set undodir="$HOME/.VIM_UNDO_FILES"
"set guicursor+=c-n-v:blinkon200
