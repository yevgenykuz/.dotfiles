" Colors {{{
syntax enable           " enable syntax processing
colorscheme gruvbox
set background=dark
" }}}

" Misc {{{
set ttyfast                     " faster redraw
set backspace=indent,eol,start
" }}}

" Spaces & Tabs {{{
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
" }}}

" UI Layout {{{
set number              " show line numbers
set showcmd             " show command in bottom bar
"set nocursorline        " highlight current line
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline          " highlight current line number 
set wildmenu
set showmatch           " higlight matching parenthesis
" }}}

" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}

" Remove highlighted searches by hitting Enter {{{
nnoremap <CR> :noh<CR><CR>
" }}}

" Tab Mapping {{{
map <F7> :tabe 
map <F8> :tabp<CR>
" }}}

" Paste without destroying indentation {{{
set pastetoggle=<F2>
" }}}
