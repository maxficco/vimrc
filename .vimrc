syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set number
augroup numbertoggle "relative line numbers only in normal/visual mode
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
set noswapfile
set smartcase
set incsearch
set cursorline
set backspace=indent,eol,start
set fillchars+=vert:│

" Automatically install vim plug
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
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " run :CocInstall coc-tabnine
Plug 'tmsvg/pear-tree'
call plug#end()

" NERDTree stuff
let NERDTreeMinimalUI=1
let NERDTreeChDirMode = 3
let g:DevIconsEnableFoldersOpenClose = 1
autocmd BufEnter * if tabpagenr('$') == 1 " Exit Vim if NERDTree is the only window remaining in the only tab.
      \ && winnr('$') == 1 
      \ && exists('b:NERDTree') 
      \ && b:NERDTree.isTabTree()
      \ | quit | endif

" custom window colors (and syntax highlighting with bat) for fzf
let $FZF_DEFAULT_OPTS="--color=dark,fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f,info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

" colorsheme settings
colorscheme gruvbox
set background=dark

" for lightline
set laststatus=2
set noshowmode
set ttimeoutlen=1

" key bindings
noremap ,n :NERDTreeToggle<cr>
noremap ,m :NERDTreeFind<cr>
noremap ,f :Files<cr>
noremap ,g :GFiles<cr>
noremap ,b :Buffers<cr>
nnoremap <space> za
autocmd filetype python noremap ,; :!python3 %<cr>
autocmd filetype python noremap ,: :below term++rows=15 python3 %<cr>
autocmd filetype java noremap ,; :!javac % && java %<cr>
autocmd filetype java noremap ,: :!javac %<cr> :below term++rows=15 java %<cr>
autocmd filetype cpp noremap ,; :!g++ % -std=c++11 && ./a.out<cr>
autocmd filetype cpp noremap ,: :!g++ % -std=c++11<cr> :below term++rows=15 ./a.out<cr>
autocmd filetype rust noremap ,; :!rustc % && ./%:r<cr>
autocmd filetype rust noremap ,: :!rustc %<cr> :below term++rows=15 ./%:r<cr>
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exec 'noremap' key '<Nop>'
    exec 'inoremap' key '<Nop>'
    exec 'cnoremap' key '<Nop>'
endfor
" autocomplete - replace Ctrl n & y
inoremap <expr> <Tab> pumvisible() ? "<C-n>" :"<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" :"<S-Tab>"
inoremap <expr> <space> pumvisible() ? "<C-y>" :"<space>"

" custom functions
function Go()
    execute "below term++rows=11"
    execute "NERDTreeToggle"
    execute "wincmd l"
endfunction
command! Go call Go()
