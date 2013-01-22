call pathogen#infect()
call pathogen#helptags()

let g:pathogen_disabled = []

" add any disabled plugins here, format:
" call add(g:pathogen_disabled, 'plugin_name')
"call add(g:pathogen_disabled, 'nerdcommenter')

" function to trim trailing spaces on multiple lines
" can alternatlive use <leader>s as detailed below for single lines
fun! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" filetype settings
filetype on
filetype plugin on
filetype indent on

" detect filetype fix
au BufRead,BufNewFile *.exp set filetype=tcl

" syntax and colorscheme specifics
syntax enable
colorscheme mustang
"let g:molokai_original = 1
"set background=dark

" indent guides settings
set ts=4
set sw=4
set et
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey 

" auto cmd stuff
"autocmd vimenter * NERDTree
autocmd vimenter * TagbarOpen
au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" set mapleader
let mapleader=","

" tab settings
set expandtab
set shiftwidth=4
set tabstop=4

" indent settings
set autoindent

" search settings
set ignorecase
set incsearch

" status line stuff
set ls=2

" other misc sets
set cursorline
set modelines=0
set nocompatible
set nobackup
set noswapfile
set number
set pastetoggle=<F2>
"setlocal spell spelllang=en_gb
set tags=./tags

" key remaps
nmap <F4> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

" Home key
imap <esc>OH <esc>0i
cmap <esc>OH <home>
nmap <esc>OH 0

" End key
nmap <esc>OF $
imap <esc>OF <esc>$a
cmap <esc>OF <end>

" training to not use arrow keys wooooo
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" F1 is bad
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" lazy mode
"nnoremap ; :

" remap hjkl to be less annoying
noremap ; l
noremap l k
noremap k j
noremap j h

" remap "jj" to <ESC> for easy switching
inoremap jj <ESC>
" remap ";;" to <ESC> for easy switching
inoremap ;; <ESC>

" easy window split
"nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>

" trim trailing spaces
nnoremap <leader>s :s/\s\+$//e<CR>
vnoremap <leader>S :call StripTrailingWhitespaces()<CR>

" easy window switching
noremap <C-j> <C-w>w
" todo: find a way to switch to previous pane
" <C-W>w switches to next pane

" get rid of hightlighting after a search
nnoremap <leader><space> :noh<cr>

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
