" Pathogen
execute pathogen#infect()

" Syntax and colors
syntax on
set background=dark
set t_Co=256
colorscheme solarized
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Custom settings
set nocompatible	" remove vi compability mode
set number			" show line numbers
set ruler			" always show bottom ruler / info
set autoindent		" autoindent on
set tabstop=4		" define tab length
set nobackup		" no need for ~ files
set showmatch		" show matching brackets
set hlsearch		" highlight search results
set cursorline		" use a line instead of cursor indicator

" remap jj to escape in insert mode
inoremap jj <Esc>

" swapping : and ; save a lot of unneeded shifting:
noremap ; :
noremap : ;

" The wish that grants more wishes (edit vimrc with \ev)
nnoremap <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>
