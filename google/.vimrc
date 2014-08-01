
set nocompatible
set nu
source /usr/share/vim/google/google.vim
filetype plugin indent on
syntax on

Glug youcompleteme-google
Glug gtimporter

let g:ycm_filetype_specific_completion_to_disable = {'cpp': 1, 'c': 1}

:nmap <C-N><C-N> :set invnumber<CR>

