" -- A better gx functionality ---------------------------------------------

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

nnoremap <silent>gx :call BetterGX()<CR>


" -- Repeatable window resize ----------------------------------------------

function! RepeatResize(first) abort
  let l:command = a:first
  while stridx('+-><', l:command) != -1
    execute "normal! \<C-w>" . l:command
    redraw
    let l:command = nr2char(getchar())
  endwhile
endfunction

nnoremap <Leader>w- :call RepeatResize('-')<CR>
nnoremap <Leader>w+ :call RepeatResize('+')<CR>
nnoremap <Leader>w< :call RepeatResize('<')<CR>
nnoremap <Leader>w> :call RepeatResize('>')<CR>


" -- Commenting utitlities -------------------------------------------------

function! DocInfo() abort
  let cmntstr = &commentstring
  let curpos = getcurpos(0)
  call append(curpos[1]-1, substitute(cmntstr, "%s", " Author: Enan Ajmain", ""))
  call append(curpos[1]+0, substitute(cmntstr, "%s", " Email : 3nan.ajmain@gmail.com", ""))
  call append(curpos[1]+1, substitute(cmntstr, "%s", " Github: 3N4N", ""))
endfunction

function! DocFormat() abort
  let cmntstr = &commentstring
  let cmntlen = &textwidth != 0 ? &textwidth : 80
  let cmntlen = cmntlen - strlen(cmntstr)

  let beauty = substitute(cmntstr, "%s", " " . repeat("-",cmntlen), "")

  let curline = getline('.')
  let curline = " -- " . curline . " " . repeat("-", cmntlen - strlen(curline) - 5)
  let newline = substitute(cmntstr, "%s", curline, "")
  call setline(".", newline)
endfunction

function! DocBanner() abort
  let cmntstr = &commentstring
  let cmntlen = &textwidth != 0 ? &textwidth : 80
  let cmntlen = cmntlen - strlen(cmntstr)

  let beauty = substitute(cmntstr, "%s", " " . repeat("-", cmntlen), "")

  center
  let curline = getline('.')
  let newline = substitute(cmntstr, "%s", curline, "")
  call setline(".", newline)

  let curpos = getcurpos(0)
  call append(curpos[1]-1, beauty)
  call append(curpos[1]+1, beauty)
endfunction

nnoremap <silent><Bslash>ci :call DocInfo()<CR>
nnoremap <silent><Bslash>cc :call DocFormat()<CR>
nnoremap <silent><Bslash>cb :call DocBanner()<CR>
