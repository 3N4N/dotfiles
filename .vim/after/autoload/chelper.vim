function! chelper#SwitchToHeader() abort
  let l:root = expand('%:t:r')
  let l:ext = expand('%:t:e')

  let l:header_exts = ['h', 'hh', 'hpp']
  let l:source_exts = ['c', 'cc', 'cpp']
  let l:header_dirs = ['.', 'inc', 'include']
  let l:source_dirs = ['.', 'src', 'source']

  let l:subdirs = split(expand('%'), '/')

  " VimL's scope is different from C's
  " Vars defined in if block exist after its closing
  if index(l:source_exts, l:ext) >=0
    let l:dirs_in_path = l:source_dirs
    let l:expected_exts = l:header_exts
  elseif index(l:header_exts, l:ext) >=0
    let l:dirs_in_path = l:header_dirs
    let l:expected_exts = l:source_exts
  else
    echohl Error | echom "[chelper#SwitchToHeader] Not a C file" | echohl None
    return
  endif

  for l:dir in l:dirs_in_path
    let l:idx = index(l:subdirs, l:dir)
    if l:idx < 0 && l:dir != '.' | continue | endif
    let l:dirname = l:subdirs[l:idx+1:-2]->join("/")
    let l:dirname .= (l:dirname ==# "" ? "" : "/")
    for l:ext in l:expected_exts
      let l:fullpath = l:dirname . l:root . "." . l:ext
      try
        exe "find " . l:fullpath
      catch /^Vim\%((\a\+)\)\=:E345:/
        continue
      endtry
      break
    endfor
  endfor
endfunction
