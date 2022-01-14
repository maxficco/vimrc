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
set backspace=indent,eol,start

" weird mac notifications
set visualbell t_vb=
if has("autocmd") && has("gui")
    au GUIEnter * set t_vb=
endif

" automatically install vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" NERDTree stuff
let NERDTreeMinimalUI=1
let NERDTreeChDirMode = 3
let g:DevIconsEnableFoldersOpenClose = 1
autocmd BufEnter * silent! lcd %:p:h
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 
      \ && winnr('$') == 1 
      \ && exists('b:NERDTree') 
      \ && b:NERDTree.isTabTree()
      \ | quit | endif

" change fzf window colors
let g:fzf_colors= {
      \  'border': ['fg', 'Type' ],
      \  'gutter': ['fg', 'Normal' ] }

" colorsheme settings
colorscheme gruvbox
set background=dark

" for lightline
set laststatus=2
set noshowmode

" key bindings
noremap ,n :NERDTreeToggle<cr>
noremap ,m :NERDTreeFind<cr>
noremap ,f :Files<cr>
noremap ,g :GFiles<cr>
noremap ,b :Buffers<cr>
autocmd filetype python noremap ,; :!python3 %<cr>
autocmd filetype cpp noremap ,; :!g++ % -std=c++11 && ./a.out<cr>
autocmd filetype java noremap ,; :!javac % && java %<cr>
