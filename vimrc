" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

"""""""""""""""""""""""""""""""
" 最後のカーソル位置の復元
"""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
endif
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

"構文チェック
syntax enable

set number
set title
set ambiwidth=double
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set nrformats-=octal
set hidden
set history=50
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set clipboard=unnamedplus
set laststatus=2

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

if &compatible
    set nocompatible
endif

set runtimepath^=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
"NERDTree
NeoBundle 'scrooloose/nerdtree'
"Unite.vim + neomaru.vim + unite-outline
NeoBundle 'Shougo/unite.vim'
NeoBundle "Shougo/unite-outline"
NeoBundle 'Shougo/neomru.vim'
"lightline
NeoBundle 'itchyny/lightline.vim'
"monokai
NeoBundle 'tomasr/molokai'
"Sneippest
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'pocke/neco-gh-issues'
NeoBundle 'Shougo/neco-syntax'

" 補完 -C言語
NeoBundle 'justmao945/vim-clang'
" Compile
NeoBundle 'vim-scripts/SingleCompile'
" 特定箇所のハイライト
NeoBundle "t9md/vim-quickhl"
"
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
"カラースキーム - hybrid
NeoBundle 'w0ng/vim-hybrid'
"スペースの可視化
NeoBundle 'bronson/vim-trailing-whitespace'
call neobundle#end()

filetype plugin indent on
NeoBundleCheck

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" molokai
let g:molokai_original = 1

"
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ }
" color-scheme
"colorscheme hybrid
"

""""""""""""""""""""""""""""""""""
" lightline設定 
" https://github.com/itchyny/lightline.vim
""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

""""""""""""""""""""""""""""""""""
" snippest設定 
" https://github.com/Shougo/neosnippet.vim
" https://github.com/Shougo/neosnippet-snippets
" https://github.com/Shougo/neocomplete.vim
""""""""""""""""""""""""""""""""""
"if neobundle#tap('neocomplete')
"    call neobundle#config({
"    \   'depends': ['Shougo/context_filetype.vim', 'ujihisa/neco-look', 'pocke/neco-gh-issues', 'Shougo/neco-syntax'],
"    \   })
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_underbar_completion = 1
    let g:neocomplete#enable_camel_case_completion = 1
    let g:neocomplete#max_list = 20
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#enable_auto_close_preview = 0
"    AutoCmd InsertLeave * silent! pclose!
    let g:neocomplete#max_keyword_width = 10000
    if !exists('g:neocomplete#delimiter_patterns')
        let g:neocomplete#delimiter_patterns= {}
    endif
    let g:neocomplete#delimiter_patterns.ruby = ['::']
    if !exists('g:neocomplete#same_filetypes')
        let g:neocomplete#same_filetypes = {}
    endif
    let g:neocomplete#same_filetypes.ruby = 'eruby'
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#force_omni_input_patterns.typescript = '[^. \t]\.\%(\h\w*\)\?' " Same as JavaScript
    let g:neocomplete#force_omni_input_patterns.go = '[^. \t]\.\%(\h\w*\)\?'         " Same as JavaScript
    let s:neco_dicts_dir = $HOME . '/dicts'
    if isdirectory(s:neco_dicts_dir)
        let g:neocomplete#sources#dictionary#dictionaries = {
        \   'ruby': s:neco_dicts_dir . '/ruby.dict',
        \   'javascript': s:neco_dicts_dir . '/jquery.dict',
        \ }
    endif
    let g:neocomplete#data_directory = $HOME . '/.vim/cache/neocomplete'
    call neocomplete#custom#source('look', 'min_pattern_length', 1)
"    call neobundle#untap()
"endif

""""""""""""""""""""""""""""""""""
" C言語: 今度設定
" https://github.com/Shougo/neosnippet-snippets
" https://github.com/Shougo/neocomplete.vim
"""""""""""""""""""""""""""""""""" 
let g:clang_periodic_quickfix = 1
let g:clang_complete_copen = 1
let g:clang_use_library = 1
