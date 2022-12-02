setlocal textwidth=80
setlocal nospell
setlocal wrap
setlocal formatoptions=tcqjroln
setlocal comments=
SetMarkdownComments

xnoremap <buffer> <Leader><Bslash> :EasyAlign*<Bar><Enter>



function! s:end_list()
  let l:preceding_line = getline(line(".") - 1)
  if l:preceding_line =~ '\v^\s*\d+\.\s*$'
      call setline(line(".") - 1, "")
      call setline(line("."), " ")
  elseif l:preceding_line =~ '\v^\s*-\s*$'
      call setline(line(".") - 1, "")
      call setline(line("."), " ")
  endif
endfunction

" inoremap <buffer> <CR> <CR><Esc>:call <SID>end_list()<CR>A
