function! BetterGX() abort
  if g:env == "WSL"
    let cmd = 'cmd.exe /C start ""'
  elseif g:env == "WIN"
    let cmd = 'cmd.exe /C start ""'   " start's first arg is title
  elseif executable('xdg-open')
    let cmd = "xdg-open"
  elseif executable('open')
    let cmd = "open"
  else
    echohl Error | echom "[BetterGX] Can't find proper opener for an URL!"
    return
  endif

  let path = expand('<cfile>')
  let fullcmd = cmd . ' ' . '"' . path . '"'
  echo fullcmd
  call jobstart(fullcmd)
endfunction
