" op8867555's `.vimrc`
" requirements:
"     * stack
"     * ghc-mod
"     * stylish-haskell
"     * hasktags
"     * par
" reference:
"     * https://github.com/begriffs/haskell-vim-now
"     * http://www.stephendiehl.com/posts/vim_2016.html

" Plugins {{{
call plug#begin('~/.vim/bundle')


Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neocomplete.vim'

Plug 'congma/vim-fakeclip'

Plug 'editorconfig/editorconfig-vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'int3/vim-extradite'

" Bars, panels, and files
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

" Text manipulation
Plug 'vim-scripts/Align'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'michaeljsmith/vim-indent-object'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

" Theme
Plug 'vim-scripts/tir_black'

Plug 'scrooloose/syntastic'

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" Python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'


Plug 'vim-scripts/VOoM'

call plug#end()

" }}}

set clipboard=unnamed

try
  colorscheme tir_black
catch
endtry

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu
" Tab-complete files up to longest unambiguous prefix
set wildmode=list:longest,full

" Always show current position
set ruler
set relativenumber
set number
set cursorline
autocmd InsertEnter * set rnu
autocmd InsertLeave * set nu

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:_,extends:>,precedes:<,nbsp:+
endif

" Use par for prettier line formatting
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w72"

" Use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

augroup vimrcFold
  " fold vimrc itself by categories
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd FileType vim set foldlevel=0
augroup END

set nocompatible
syntax on
filetype plugin indent on

" speedup marcos
set lazyredraw
"
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" modern search
set incsearch

" Kill the damned Ex mode.
nnoremap Q <nop>

" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

" Show undo tree
nmap <silent> <leader>u :MundoToggle<CR>

" don't close buffers when you aren't displaying them
set hidden

" ctrlp {{{

nnoremap <silent> <Leader><space> :CtrlP<CR>
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|.cabal-sandbox|.stack-work)$' }

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

" }}}

" Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" }}}


" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

" Status line {{{

" Always show the status line
set laststatus=2

" }}}

set t_Co=256

set mouse=a

let g:neocomplete#enable_at_startup = 1

set completeopt+=longest

inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Python {{{
autocmd FileType python setlocal ts=4 sts=4 sw=4 ex
"let g:jedi#use_splits_not_buffers = "left"
let g:jedi#completions_command = "<C-N>"
let g:syntastic_python_checkers = ['flake8']
" }}}

" Ruby {{{
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 ex
" }}}

" Make {{{
autocmd FileType make setlocal ts=4 sts=4 sw=4 noex
" }}}

" Cpp/Java {{{
autocmd FileType cpp,c,java setlocal ts=4 sts=4 sw=4 ex
" }}}

" Haskell {{{

autocmd FileType haskell setlocal ts=4 sts=4 sw=4 ex
autocmd FileType haskell map <F5> :GhcModType<CR>
autocmd FileType haskell map <F6> :GhcModTypeClear<CR>
autocmd FileType haskell map <F7> :GhcModCheck<CR>


" Turn off *Pretty unicode haskell symbols*
let g:haskell_conceal = 0
let g:haskell_conceal_wide = 0
let g:haskell_conceal_enumerations = 0
let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻w"

"
" Use stylish haskell instead of par for haskell buffers
autocmd FileType haskell let &formatprg="stylish-haskell"

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" show type in necoghc
let g:necoghc_enable_detailed_browse = 1

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

" Type of expression under cursor
nmap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" GHC errors and warnings
nmap <silent> <leader>hc :Neomake ghcmod<CR>

let g:haskell_indent_if = 0
let g:haskell_indent_do = 4
let g:haskell_indent_in = 0
let g:haskell_indent_let = 4


let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1

let g:ghcmod_hlint_options = ['--ignore=Reduce duplication']

  "{{{
  let g:tagbar_type_haskell = {
      \ 'ctagsbin'  : 'hasktags',
      \ 'ctagsargs' : '-x -c -o-',
      \ 'kinds'     : [
          \  'm:modules:0:1',
          \  'd:data: 0:1',
          \  'd_gadt: data gadt:0:1',
          \  't:type names:0:1',
          \  'nt:new types:0:1',
          \  'c:classes:0:1',
          \  'cons:constructors:1:1',
          \  'c_gadt:constructor gadt:1:1',
          \  'c_a:constructor accessors:1:1',
          \  'ft:function types:1:1',
          \  'fi:function implementations:0:1',
          \  'o:others:0:1'
      \ ],
      \ 'sro'        : '.',
      \ 'kind2scope' : {
          \ 'm' : 'module',
          \ 'c' : 'class',
          \ 'd' : 'data',
          \ 't' : 'type'
      \ },
      \ 'scope2kind' : {
          \ 'module' : 'm',
          \ 'class'  : 'c',
          \ 'data'   : 'd',
          \ 'type'   : 't'
      \ }
  \ }
  "}}}

  " Conversion {{{

  function! Pointfree()
    call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
    endfunction
  vnoremap <silent> <leader>h. :call Pointfree()<CR>

  function! Pointful()
    call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
  endfunction
  vnoremap <silent> <leader>h> :call Pointful()<CR>
  " }}}

"}}}

" Airline {{{
let g:airline_left_sep=''
let g:airline_right_sep=''
" }}}

" Pandoc {{{
" add CJK to spell langs
let g:pandoc#spell#default_langs=['en_us', 'cjk']
" }}}

" Alignment {{{

" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align

" }}}
