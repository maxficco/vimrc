syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set smartcase
set incsearch
set cursorline

set visualbell t_vb=
if has("autocmd") && has("gui")
    au GUIEnter * set t_vb=
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
call plug#end()

colorscheme gruvbox
set background=dark

noremap ,n :NERDTreeToggle<cr>
noremap ,py :!python3 %<cr>
noremap ,cpp :!g++ % && ./a.out<cr>
