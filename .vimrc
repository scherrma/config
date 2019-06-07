set nocompatible
"Colors
:set t_Co=256
"Pathogen - manage plugins
call pathogen#infect()
syntax enable
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
"De-clutter
:set nobackup
:set noswapfile
"Smart filetypes and syntax
:filetype plugin indent on
"Syntax highlighting
"Tabs, indents, etc
:set tabstop=2
:set shiftwidth=2
:set expandtab
:set autoindent
:set smarttab
:set hlsearch
:set incsearch
" <Ctrl-L> redraws the screen and removes any search highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>
"Line numbers
:set number
:set numberwidth=3
"Code folding
:set foldenable
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
