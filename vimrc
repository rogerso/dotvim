call pathogen#infect()
call pathogen#helptags()

syntax on
set background=dark
if has('terminfo') && (&term == 'xterm-256color' || &term == 'xterm')
    " term has 256 colors
    set t_Co=256
    let g:solarized_termcolors=256
    let g:Powerline_symbols='unicode'
    colorscheme solarized
endif

set nocompatible
set laststatus=2
set encoding=utf-8

set number
set showcmd
set showmode
set title

set noswapfile
set nobackup
set nowb

set autoindent
set smartindent

set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

filetype plugin on
filetype indent on

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

if has('autocmd')
    autocmd Filetype c,cpp,java,objc,cuda set cin
endif
if has('eval')
    let c_gnu=1
    let c_space_errors=1
endif

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
