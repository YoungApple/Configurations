
set nocompatible
set nu
source /usr/share/vim/google/google.vim
filetype plugin indent on
syntax on

set expandtab
set shiftwidth=2
set softtabstop=2
set synmaxcol=0

Glug youcompleteme-google
Glug gtimporter

let g:ycm_filetype_specific_completion_to_disable = {'cpp': 1, 'c': 1}

:nmap <C-N><C-N> :set invnumber<CR>

