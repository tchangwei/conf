highlight Comment ctermfg=green guifg=green
set shiftwidth=4
set softtabstop=4

#pig support
augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END
