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
    echohl Error | echom "[BetterGX] Can't find proper opener for an URL" | echohl None
    return
  endif

  let path = expand('<cfile>')
  let fullcmd = cmd . ' ' . '"' . path . '"'
  echo fullcmd
  call system(fullcmd)
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
  let cmntlen = cmntlen - strlen(cmntstr) - 1

  let beauty = substitute(cmntstr, "%s", " " . repeat("-",cmntlen), "")

  let curline = getline('.')
  let prefix = &ft == "lua" ? " " : " -- "
  let curline = prefix . curline . " " . repeat("-", cmntlen - strlen(curline) - len(prefix))
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


" -- Switch windows effortlessly -------------------------------------------

function! SwitchWindow(count) abort
  let l:current_buf = winbufnr(0)
  exe "buffer" . winbufnr(a:count)
  exe a:count . "wincmd w"
  exe "buffer" . l:current_buf
  " wincmd p
endfunction

nnoremap <Leader>wx :<C-u>call SwitchWindow(v:count1)<CR>


" -- Copy yanked text to tmux pane -----------------------------------------

function! SendToTmux(visual, count) range abort
  if (a:visual)
    execute "normal! gv\"zy"
  else
    execute "normal! \"zyip"
  endif

  let text = @z
  let text = substitute(text, ';', '\\;', 'g')
  let text = substitute(text, '"', '\\"', 'g')
  let text = substitute(text, '\n', '" Enter "', 'g')
  let text = substitute(text, '!', '\\!', 'g')
  let text = substitute(text, '%', '\\%', 'g')
  let text = substitute(text, '#', '\\#', 'g')

  silent execute "!tmux send-keys -t " . a:count . " -- \"" . text . "\""
  silent execute "!tmux send-keys -t " . a:count . "Enter"
endfunction

nnoremap <Leader>p :<C-u>call SendToTmux(0, v:count1)<CR>
xnoremap <Leader>p :<C-u>call SendToTmux(1, v:count1)<CR>


" -- Use * and # over visual selection -------------------------------------

function! s:VSetSearch(cmdtype) abort
  let t = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let _w = winsaveview()
  let @s = t
  call winrestview(_w)
  unlet _w
  unlet t
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>


" -- Get filenames ignoring `wildignore` -----------------------------------

function! MyCompleteFileName() abort
  " match a (potential) wildcard preceding cursor position
  " NOTE: \f is a filename character, see :h 'isfname'
  let l:pattern = matchstr(strpart(getline('.'), 0, col('.') - 1), '\v(\f|\*|\?)*$')
  let l:file_comp_list = getcompletion(l:pattern, "file")
  " let l:file_comp_list += getcompletion(l:pattern, "file_in_path")
  call complete(col('.') - len(l:pattern), l:file_comp_list)

  " must return an empty string to show the menu
  return ''
endfunction

inoremap <C-F> <C-R>=MyCompleteFileName()<CR>


" -- Center next and prev textblocks ---------------------------------------

function! CenterNextBlock() abort
  let l:cur_line = getline(".")
  if (l:cur_line != '')
    normal! }
    let l:line1 = line(".")
    keepjumps normal! }
  else
    let l:line1 = line(".")
    normal! }
  endif
  let l:line2 = line(".")
  let l:line = l:line1 + ((l:line2 - l:line1) / 2)
  execute "call cursor(" . l:line . ",1)"
  normal! zz
endfunction

function! CenterPrevBlock() abort
  let l:cur_line = getline(".")
  if (l:cur_line != '')
    execute "normal! {"
    let l:line1 = line(".")
    keepjumps normal! {
    else
      let l:line1 = line(".")
      execute "normal! {"
  endif
  let l:line2 = line(".")
  let l:line = l:line1 - ((l:line1 - l:line2) / 2)
  execute "call cursor(" . l:line . ",1)"
  normal! zz
endfunction

nnoremap - :<C-u>call CenterNextBlock()<CR>
nnoremap _ :<C-u>call CenterPrevBlock()<CR>


" -- Add to syntax keyword Todo --------------------------------------------

function! UpdateTodoKeywords(...) abort
  let newKeywords = join(a:000, " ")
  let synTodo = map(filter(split(execute("syntax list"), '\n'),
        \ { i,v -> match(v, '^\w*Todo\>') == 0}),
        \ {i,v -> substitute(v, ' .*$', '', '')})
  for synGrp in synTodo
    execute "syntax keyword " . synGrp . " contained " . newKeywords
  endfor
endfunction

augroup todo
  autocmd!
  " autocmd Syntax * call UpdateTodoKeywords("NOTE", "NOTES")
  autocmd Syntax * call UpdateTodoKeywords("NOTE")
augroup END


" -- Utility function for setting shell ------------------------------------

function! SetShell(shell) abort
  let shells = ['cmd', 'pwsh', 'powershell']
  if index(shells, a:shell) == -1
    echohl Error | echom "[SetShell] Shell not found" | echohl None
  endif

  if a:shell ==# "cmd"
    let &shell = "C:\\\\Windows\\\\System32\\\\cmd.exe"
    let &shellredir = ">%s 2>&1"
    let &shellpipe = ">%s 2>&1"
    let &shellquote = ""
    let &shellxquote = "\""
    let &ssl = 0
    let &csl = "slash"
  elseif a:shell ==# "pwsh" || a:shell ==# "powershell"
    let &shell = a:shell
    let &shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();"
    let &shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    let &shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    let &shellquote = ""
    let &shellxquote = ""
    let &ssl = 0
    let &csl = "slash"
  end
endfunction

command! -nargs=1 SetShell call SetShell(<q-args>)

" -- Open file in remote git browser ---------------------------------------

function! GitOpenRemote(start, end) abort
  let available_domains = [ 'github', 'sr.ht' ]

  function! System(cmd) abort
    return systemlist(a:cmd)->join('')
  endfunction

  function! UnixifyPath(path) abort
    return substitute(a:path, '\\', '/', 'g')
  endfunction

  function! ParseRemoteURL(url) abort
    let url = a:url
    if match(url, 'github') != -1
      let domain = 'github'
    elseif match(url, 'sr.ht') != -1
      let domain = 'sr.ht'
    else
      let domain = ''
    endif
    let baseurl = substitute(url, ".*@\\(.*\\):", "\\1/", "")
    if domain == "github"
      let baseurl = substitute(baseurl, ".git$", "", "")
    endif
    return [baseurl, domain]
  endfunction

  function! GetFullRemoteURL(remote, branch, filename, lines) abort
    let [start, end] = a:lines
    if start == 0 && end == 0
      let lines = ""
    else
      let lines = "#L" . start
      if start != end
        if a:remote.domain == "github"
          let lines .= "-L" . end
        elseif a:remote.domain == "sr.ht"
          let lines .= "-" . end
        endif
      endif
    endif

    if a:remote.domain == "github"
      let tree = "/tree/" . a:branch . "/" . a:filename . lines
    elseif a:remote.domain == "sr.ht"
      let tree = "/tree/" . a:branch . "/item/" . a:filename . lines
    endif
    let fullurl = a:remote.url . tree
    return fullurl
  endfunction

  let gitroot = UnixifyPath(System("git rev-parse --show-toplevel"))
  if v:shell_error != 0
    echohl Error | echom "[GitOpenRemote] Not in a git repo" | echohl None
    return
  endif
  let filename = substitute(UnixifyPath(expand('%:p')), gitroot.'\/', '', '')

  let headref = System("git symbolic-ref -q HEAD")
  let upbranch = System("git for-each-ref --format=\"%(upstream:short)\" " . headref)
  if upbranch == ""
    echohl Error | echom "[GitOpenRemote] Branch not tracked upstream" | echohl None
    return
  endif

  let remote = {'name' : '', 'url': ''}
  let remote.name = substitute(upbranch, "\\(.\\{-}\\)\\/.*", "\\1", "")
  let upbranch = substitute(upbranch, remote.name . "\\/", "", "")
  let [remote.url, remote.domain] = ParseRemoteURL(System("git config --get remote." . remote.name . ".url"))

  if index(available_domains, remote.domain) == -1
    echohl Error | echom "[GitOpenRemote] " . remote.domain . " not supported" | echohl None
    return
  endif

  let fullurl = GetFullRemoteURL(remote, upbranch, filename, [a:start, a:end])
  echom fullurl
  let @+ = fullurl

  delfunction System
  delfunction ParseRemoteURL
  delfunction GetFullRemoteURL
endfunction

nnoremap <Leader>fo :<C-U>call GitOpenRemote(0,0)<CR>
xnoremap <Leader>fo :<C-U>call GitOpenRemote(getpos("'<")[1], getpos("'>")[1])<CR>


" -- Better mksession ------------------------------------------------------

function! MakeSession(filename, bang) abort
  let filename = a:filename == '' ? 'Session.vim' : a:filename
  let _w = winsaveview()

  let _qflist = getqflist()
  let _qfinfo = getqflist({'title' : 1})
  let _qfopen = !empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") ==# "quickfix"'))

  for entry in _qflist | call setbufvar(entry['bufnr'], '&buflisted', 1) | endfor
  cclose
  execute 'mksession' . (a:bang == 1 ? '! ' : ' ') . filename
  if _qfopen | cwindow | wincmd p | endif

  let _setqflist = 'call setqflist(' . string(_qflist) . ')'
  let _setqfinfo = 'call setqflist(' . '[],"a",' . string(_qfinfo) . ')'
  call writefile([_setqflist, _setqfinfo], filename, 'a')
  if _qfopen | call writefile(['cwindow', 'wincmd p'], filename, 'a') | endif

  call winrestview(_w)
endfunction

command! -nargs=? -bang MakeSession call MakeSession(<q-args>, <bang>0)