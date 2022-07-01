setlocal textwidth=70
setlocal nospell
setlocal wrap

setlocal formatoptions=tcqjroln
setlocal comments=b:[],b:[\ ],b:[x],b:[X],b:*,b:-,b:+,n:>
" setlocal comments=fb:[],fb:[\ ],fb:[x],fb:[X],fb:*,fb:-,fb:+,n:>

setlocal statusline=[%{winnr()}]
            \\ %<%{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
			\\ %m%r
			\%=
			\\ %-14.(%l:%3(%v%)\ %)\ %{wordcount()['words']}W


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
