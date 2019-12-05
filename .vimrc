" Global colors 
" Enable syntax processing
syntax enable
" Set color scheme
colorscheme gruvbox
" Set color scheme background
set background=dark

" Misc
" Faster redraw
set ttyfast
" Make backspace work in insert mode
set backspace=indent,eol,start
" Turn filetype detection, and relevant plugin and indent rules files loading
filetype plugin indent on
" Enable spell checking
set spell spelllang=en

" UI Layout
" Show line numbers
set number
" Show command in bottom bar
set showcmd
" Highlight current line and line number
set cursorline 
" Highlight spelling errors:
hi clear SpellBad
hi SpellBad cterm=underline
hi SpellBad gui=undercurl
" Enable vim command completion
set wildmenu
" Highlight matching parenthesis and jump to them
set showmatch

" Tabs and indentation
" 2 space tab
set tabstop=2
" Use spaces for tabs
set expandtab
" Delete and insert the entire tab
set softtabstop=2
" Shift the entire tab when using indentation commands in normal mode 
set shiftwidth=2
" Automatically follow indentation of previous line
set autoindent
" Try to match indentation based on code
set smartindent

" Search
" Ignore case
set ignorecase
" Show match as characters are entered
set incsearch
" Highlight all matches
set hlsearch

" Custom keys
" Toggle highlighting on/off for current search matches
noremap <F4> :set hlsearch! hlsearch?<CR>
" Toggle pasting without changing indentation
set pastetoggle=<F5>
" Fix indentation
map <F6> gg=G<C-o><C-o>
" Create a new tab
map <F7> :tabe 
" Move to next tab
map <F8> :tabp<CR>
