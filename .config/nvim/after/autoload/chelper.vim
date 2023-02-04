function! chelper#SwitchToHeader() abort
  let l:root = expand('%:t:r')
  let l:ext = expand('%:t:e')

  let l:header_exts = ['h', 'hh', 'hpp']
  let l:source_exts = ['c', 'cc', 'cpp']

  if index(l:source_exts, l:ext) >=0
    for ext in l:header_exts
      silent! exe "find " . l:root . "." . ext
    endfor
  elseif index(l:header_exts, l:ext) >=0
    for ext in l:source_exts
      silent! exe "find " . l:root . "." . ext
    endfor
  endif
endfunction
