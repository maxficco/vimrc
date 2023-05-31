" basic settings
syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set number
set noswapfile
set smartcase
set incsearch
set cursorline
set backspace=indent,eol,start
set fillchars+=vert:│
augroup numbertoggle "relative line numbers only in normal/visual mode
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

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
Plug 'junegunn/seoul256.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'psliwka/vim-smoothie'
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

" custom window colors (and syntax highlighting with bat(install in term first)) for fzf
let $FZF_DEFAULT_OPTS="--color=dark,fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f,info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

" colorsheme settings
let g:seoul256_background = 235
colorscheme gruvbox 
set background=dark

" for lightline
set laststatus=2
set noshowmode
set ttimeoutlen=1

" coc
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-clangd',
  \ 'coc-pyright',
  \ 'coc-tsserver',
  \ 'coc-java',
  \ 'coc-html',
  \ 'coc-rust-analyzer'
  \ ]
" pear tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" key bindings
let mapleader=","
noremap <leader>n :NERDTreeToggle<cr>
noremap <leader>m :NERDTreeFind<cr>
noremap <leader>f :FZF<cr>
noremap <leader>F :FZF!<cr>
nnoremap <space> za
autocmd filetype python noremap <leader>; :!python3 %<cr>
autocmd filetype java noremap <leader>; :!javac % && java %<cr>
autocmd filetype cpp noremap <leader>; :!g++ % -std=c++11 && ./a.out<cr>
autocmd filetype rust noremap <leader>; :!rustc % && ./%:r<cr>
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exec 'noremap' key '<Nop>'
    exec 'inoremap' key '<Nop>'
    exec 'cnoremap' key '<Nop>'
endfor
" use <Tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <space> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<space>"
" show documentation in preview window with K
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
inoremap <c-l> <plug>(coc-snippets-expand)

" (for later:ben awad has some good keymaps for goto def and renaming with coc)



" custom functions
function Go()
    execute "below term++rows=11"
    execute "NERDTreeToggle"
    execute "wincmd l"
endfunction
command! Go call Go()
