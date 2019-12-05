" Colors
    " Enable syntax processing
syntax enable
colorscheme gruvbox
set background=dark

" Custom key mapping
    " Toggle pasting without changing indentation
set pastetoggle=<F5>
    " Fix indentation
map <F6> gg=G<C-o><C-o>
    " Create a new tab
map <F7> :tabe 
    " Move to next tab
map <F8> :tabp<CR>

" Misc
    " Faster redraw
set ttyfast
    " Make backspace work in insert mode
set backspace=indent,eol,start
    " Turn filetype detection, and relevant plugin and indent rules files
    " loading
filetype plugin indent on

" Tabs and indentation
    " 2 space tab
set tabstop=2
    " Use spaces for tabs
set expandtab
    " Delete and insert the entire tab
set softtabstop=2
    " Shift the entire tab when using indentation commands in noraml mode 
set shiftwidth=2
    " Automatically follow indentation of previous line
set autoindent
    " Try to match indentation based on code
set smartindent

" UI Layout
    " Show line numbers
set number
    " Show command in buttom bar
set showcmd
"set nocursorline        " highlight current line
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline          " highlight current line number 
set wildmenu
set showmatch           " higlight matching parenthesis

" Searching
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches

" Remove highlighted searches by hitting Enter
nnoremap <CR> :noh<CR><CR>

