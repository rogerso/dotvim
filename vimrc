call pathogen#infect()
call pathogen#helptags()

syntax on
set background=dark
if has('terminfo') && (&term == 'xterm-256color' || &term == 'xterm' || &term == 'screen-256color')
    " term has 256 colors
    set t_Co=256
    let g:solarized_termcolors=256
    let s:use_solarized = 1
endif
if has('gui_running')
    set guioptions-=T
    set lines=999 columns=200
endif
if has('gui_macvim')
    set guifont=Monaco:h10
    let s:use_solarized = 1
endif
if has('gui_gtk2')
    set guifont=Liberation\ Mono\ Medium\ 9
    let s:use_solarized = 1
endif
if exists('s:use_solarized')
    let g:solarized_hitrail=1
    colorscheme solarized

    let g:airline_theme='dark'
    let g:airline_symbols = {}
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.whitespace = 'Ξ'
endif
unlet! s:use_solarized

" make trailing whitespace obvious
"highlight TrailWhitespace ctermbg=red guibg=red
"match TrailWhitespace /\s\+$\| \+\ze\t/
"
" stupid OS X doesn't have exuberate-ctags as /usr/bin/ctags
if has('unix')
    let s:uname = system('echo -n "$(uname)"')
    if !v:shell_error && s:uname == 'Darwin'
        let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
    endif
endif

" required for powerline
set nocompatible
set laststatus=2
set encoding=utf-8

set ignorecase  " case-insensitive matching
set smartcase   " smart case matching
set incsearch   " incremental search

set number      " show linenumbers
set showcmd     " show partial command in status line
set showmode    " show current mode
set title       " change xterm titlebar as well
set wildmenu    " let me know what I am matching

set noswapfile  " don't create swapfile
set nobackup    " don't create backups

set autoindent
set smartindent

" I like my tabs like this
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" start scrolling near margins
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

set modeline    " I know this is a security hole, but what the hell

if has('autocmd')
    filetype plugin on
    filetype indent on
    autocmd Filetype c,cpp,java,objc,cuda set cin
    autocmd Filetype go set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
endif
if has('eval')
    let c_gnu=1
    let c_space_errors=1
endif

let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['java'] }

" convienient function for toggling both
" stolen from http://stackoverflow.com/questions/6624043/
function! ToggleNERDTreeAndTagbar()
    let w:jumpbacktohere = 1

    " Detect which plugins are open
    if exists('t:NERDTreeBufName')
        let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
    else
        let nerdtree_open = 0
    endif
    let tagbar_open = bufwinnr('__Tagbar__') != -1

    " Perform the appropriate action
    if nerdtree_open && tagbar_open
        NERDTreeClose
        TagbarClose
    elseif nerdtree_open
        TagbarOpen
    elseif tagbar_open
        NERDTree
    else
        NERDTree
        TagbarOpen
    endif

    " Jump back to the original window
    for window in range(1, winnr('$'))
        execute window . 'wincmd w'
        if exists('w:jumpbacktohere')
            unlet w:jumpbacktohere
            break
        endif
    endfor
endfunction
nmap <leader>\ :call ToggleNERDTreeAndTagbar()<CR>

" Added by android-vim:
set tags+=/home/spacehunt/.vim/tags
autocmd Filetype java setlocal omnifunc=javacomplete#Complete
let g:SuperTabDefaultCompletionType = 'context'

" for Golang
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
