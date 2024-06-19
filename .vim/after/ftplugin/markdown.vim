setlocal textwidth=80
setlocal nospell
setlocal wrap
setlocal formatoptions=tcqjroln

" Using ':h comments' for lists is unidiomatic
" Use bullets plugin instead
" setlocal comments=
" SetMarkdownComments

xnoremap <buffer> <Leader><Bslash> :EasyAlign*<Bar><Enter>
