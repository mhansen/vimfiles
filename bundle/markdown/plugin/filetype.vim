"markdown filetype file
"

augroup markdown
    au! BufRead,BufNewFile *.mkd setfiletype mkd
    au! BufRead,BufNewFile *.markdown setfiletype mkd
augroup END
