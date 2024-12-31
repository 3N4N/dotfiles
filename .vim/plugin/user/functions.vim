fu! StartsWith(longer, shorter) abort
  return a:longer[0:len(a:shorter)-1] ==# a:shorter
endfunction

" -- A better gx functionality ---------------------------------------------

" https://youtube.com

function! BetterGX() abort
  if executable('start')
    let cmd = "start"
  elseif g:env == "WIN" || g:env == "WSL"
    " command prompt's 'start' first arg is title
    let cmd = 'cmd.exe /C ' . 'start ""'
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
  if exists('*jobstart')
    call jobstart(fullcmd)
  else
    call system(fullcmd)
  endif
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
  let beauty  = substitute(cmntstr, "%s", " " . repeat("-",cmntlen), "")
  let curline = getline('.')->substitute('^\s\+', "", "")
  let prefix  = &ft == "lua" ? " " : " -- "
  let curline = prefix . curline . " " . repeat("-", cmntlen - strlen(curline) - len(prefix))
  let newline = substitute(cmntstr, "%s", curline, "")
  call setline(".", newline)
  norm! ==
endfunction

function! DocBanner() abort
  let cmntstr = &commentstring
  let cmntlen = &textwidth != 0 ? &textwidth : 80
  let cmntlen = cmntlen - strlen(cmntstr)

  let beauty  = substitute(cmntstr, "%s", " " . repeat("-", cmntlen), "")

  center
  let curline = getline('.')
  let newline = substitute(cmntstr, "%s", curline, "")
  call setline(".", newline)

  let curpos  = getcurpos(0)
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

  call system("tmux send-keys -t " . a:count . " -- \"" . text . "\"")
  call system("tmux send-keys -t " . a:count . "Enter")
endfunction

nnoremap <Leader>p :<C-u>silent call SendToTmux(0, v:count1)<CR>
xnoremap <Leader>p :<C-u>silent call SendToTmux(1, v:count1)<CR>

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

" -- Case-sensitive star/hash/gd with ignorecase ---------------------------
" https://vi.stackexchange.com/a/34553/16280

function! SearchCword(wholeword, direction) abort
  let query = expand('<cword>')
  " Doing * on a nonword character at end of line produces no word
  " characters so wholeword is invalid.
  if a:wholeword && query =~# '\w'
    let query = '\<'.. query ..'\>'
  endif
  let @/ = query ..'\C'
endfunction

function! s:IsCursorAtStartOfWord(query) abort
  let index_in_word = match(getline('.'), '\%' . col('.') ..'c'.. a:query)
  return index_in_word > 0
endfunction

nnoremap  * :let v:hlsearch = 1 <Bar> call SearchCword(1, "n")<CR>
nnoremap  # :let v:hlsearch = 1 <Bar> call SearchCword(1, "N")<CR>
nnoremap g* :let v:hlsearch = 1 <Bar> call SearchCword(0, "n")<CR>
nnoremap g# :let v:hlsearch = 1 <Bar> call SearchCword(0, "N")<CR>

nnoremap <silent> gd
      \ :let _is_ic = &ic<CR>
      \:set noic<CR>
      \:normal! gd<CR>
      \:let @/ = @/ .. '\C'<CR>
      \:let &ic = _is_ic<CR>
      \:unlet _is_ic<CR>

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
  let shells = ['cmd', 'pwsh', 'powershell', 'bash']
  if index(shells, a:shell) == -1
    echohl Error | echom "[SetShell] Shell not found" | echohl None
  endif

  if a:shell ==# 'cmd'
    let &shell = 'C:\\\\Windows\\\\System32\\\\cmd.exe'
    let &shellcmdflag = '/s /c'
    let &shellredir = '>%s 2>&1'
    let &shellpipe = '2>&1| tee'
    let &shellquote = ''
    let &shellxquote = '"'
  elseif a:shell ==# 'pwsh' || a:shell ==# 'powershell'
    let &shell = a:shell
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellcmdflag .= '[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();'
    let &shellcmdflag .= '$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
    let &shellcmdflag .= 'Remove-Alias -Force -ErrorAction SilentlyContinue cat,echo,sleep,sort,tee;'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    let &shellquote = ''
    let &shellxquote = (has('nvim') ? '' : '"')
  elseif a:shell ==# 'bash'
    let &shell = 'bash'
    let &shellcmdflag = '-c'
    let &shellredir = '>%s 2>&1'
    let &shellpipe = '2>&1| tee'
    let &shellquote = ''
    let &shellxquote = (has('nvim') ? '(' : g:env=='CYGWIN' ? '' : '"')
  end
  " let &ssl = 1
  let &csl = 'slash'
endfunction

command! -nargs=1 SetShell call SetShell(<q-args>)

" -- Open file in remote git browser ---------------------------------------

function! GitOpenRemote(start, end) abort
  let available_domains = [ 'github', 'sr.ht' , 'gitlab']

  function! UnixifyPath(path) abort
    return substitute(a:path, '\\', '/', 'g')
  endfunction

  function! ParseRemoteURL(url) abort
    let url = a:url
    if match(url, 'github') != -1
      let domain = 'github'
    elseif match(url, 'sr.ht') != -1
      let domain = 'sr.ht'
    elseif match(url, 'gitlab') != -1
      let domain = 'gitlab'
    else
      let domain = url
    endif
    let baseurl = substitute(url, 'ssh\:\/\/', '', '')
    let baseurl = substitute(baseurl, 'git@\(.*\)', '\1', '')
    let baseurl = substitute(baseurl, "https:\/\/", "", "")
    let baseurl = substitute(baseurl, ".git$", "", "")
    let baseurl = substitute(baseurl, ":", "\/", "")
    return [baseurl, domain]
  endfunction

  function! GetFullRemoteURL(remote, hashref, filename, lines) abort
    let [start, end] = a:lines
    if start == 0 && end == 0
      let lines = ""
    else
      let lines = "#L" . start
      if start != end
        if a:remote.domain == "github"
          let lines .= "-L" . end
        elseif a:remote.domain == "sr.ht" || a:remote.domain == "gitlab"
          let lines .= "-" . end
        endif
      endif
    endif

    if a:remote.domain == "github"
      let tree = "/blob/" . a:hashref . "/" . a:filename . lines
    elseif a:remote.domain == "sr.ht"
      let tree = "/tree/" . a:hashref . "/" . a:filename . lines
    elseif a:remote.domain == "gitlab"
      let tree = "/-/blob/" . a:hashref . "/" . a:filename . lines
    endif
    let fullurl = "http://" . a:remote.url . tree
    return fullurl
  endfunction

  let gitroot = FugitiveWorkTree()
  if gitroot == ''
    echohl Error | echom "[GitOpenRemote] Not in a git repo" | echohl None
    return
  endif
  let filename = substitute(UnixifyPath(expand('%:p')), gitroot.'\/', '', '')

  function! GetHead(gitdir) abort
    return split(readfile(a:gitdir .. '/HEAD')[0])
  endfunction
  function! GetBranch(gitdir, head) abort
    if a:head[0] != 'ref:'
      return ''
    endif
    if a:head[1] =~ 'refs/heads/'
      return substitute(a:head[1], 'refs\/heads\/', '', '')
    endif
  endfunction

  function! GetHash(gitdir, head) abort
    if a:head[0] != 'ref:'
      return a:head
    endif
    let reffile = a:gitdir .. '/' .. a:head[1]
    if filereadable(reffile)
      return readfile(reffile)[0]
    endif
    let packed_refs = readfile(a:gitdir .. '/packed-refs')
    for line in packed_refs
      if stridx(line, a:head[1]) != -1
        return split(line)[0]
      endif
    endfor
  endfunction

  let gitdir = FugitiveCommonDir()
  let head = GetHead(FugitiveGitDir())
  let branch = GetBranch(gitdir, head)
  let hashref = GetHash(gitdir, head)

  " echom [gitroot,gitdir,head,branch,hashref]
  let remote = {}
  let [remote.url, remote.domain] = ParseRemoteURL(FugitiveRemoteUrl())

  if index(available_domains, remote.domain) == -1
    echohl Error | echom "[GitOpenRemote] " . remote.domain . " not supported" | echohl None
    return
  endif

  let fullurl = GetFullRemoteURL(remote, hashref, filename, [a:start, a:end])
  echom fullurl

  if has('clipboard')
    let @* = fullurl
  elseif exists('g:loaded_oscyank')
    call OSCYank(fullurl)
  endif

  delfunction ParseRemoteURL
  delfunction GetFullRemoteURL
endfunction

nnoremap <Leader>go :<C-U>call GitOpenRemote(0,0)<CR>
xnoremap <Leader>go :<C-U>call GitOpenRemote(getpos("'<")[1], getpos("'>")[1])<CR>

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

command! -nargs=? -bang -complete=file MakeSession
      \ call MakeSession(<q-args>, <bang>0)

" -- Keep cursor position while executing command --------------------------

command! -nargs=1 KC
      \ let _w=winsaveview() |
      \ execute <q-args> |
      \ call winrestview(_w)

" -- Recursive :highlight --------------------------------------------------

function! HiThere(group) abort
  let out = trim(execute('hi ' .. a:group))
  let splits = split(out, ' \+')
  echon splits[0] .. ' '
  execute 'echohl' splits[0]
  echon splits[1] .. ' '
  echohl None
  echon join(splits[2:])
  if out =~ 'links to'
    echon "\n"
    call HiThere(split(out, ' \+')[-1])
  endif
endfunction
command! -nargs=1 -complete=highlight HiThere call HiThere(<q-args>)

" -- Toggle :Git window ----------------------------------------------------

function! ToggleGstatus() abort
  for l:winnr in range(1, winnr('$'))
    if !empty(getwinvar(l:winnr, 'fugitive_status'))
      exe l:winnr 'close'
      return
    endif
  endfor
  keepalt Git
endfunction
nnoremap <Leader>gs :call ToggleGstatus()<CR>

" -- List files to then gf on it -------------------------------------------

function! ListFiles(arg) abort
  enew
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
  call append(0, systemlist(a:arg))
  call cursor(1,0)
endfunction

function! SplitIfNvim(arg) abort
  if has('nvim') | return a:arg->split() | else | return a:arg | endif
endfunction
nnoremap <silent> <Space>ff
      \ :call ListFiles('find -maxdepth 3 -type f -printf %P\\n'->SplitIfNvim())<CR>/
nnoremap <silent> <Space>fg
      \ :call ListFiles('git ls-files'->SplitIfNvim())<CR>/

" -- Better GREP -----------------------------------------------------------

" Ref: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! Grep(grepprg, ...) abort
  let l:saved_errorformat = &errorformat
  let &errorformat = &grepformat

  " backslash in f-args are confusing; see ':h <f-args>'
  let l:args = join(a:000, ' ')->substitute('\\', '\\\\', 'g')

  let l:grepcmd = a:grepprg->substitute('\$\*', l:args, ' ')
  let l:grepout = system(l:grepcmd)->split('\n')
  cgetexpr l:grepout
  call setqflist([], 'a', {'title' : l:grepcmd})

  let &errorformat = l:saved_errorformat
endfunction

command! -nargs=+ -complete=file_in_path -bar   Grep
      \ call Grep(&gp,<f-args>)
command! -nargs=+ -complete=file_in_path -bar   GitGrep
      \ call Grep("git grep --recurse-submodules -In $*
      \ :!tags :!node_modules", <f-args>)

nnoremap <Leader>gg   :GitGrep<Space>
nnoremap <Bslash>f    :Grep<Space>

cab <expr> ii (StartsWith(&gp,'grep') && getcmdtype()==':' && StartsWith(getcmdline()->trim(), 'Grep')) ? '--include':'ii'
cab <expr> xx (StartsWith(&gp,'grep') && getcmdtype()==':' && StartsWith(getcmdline()->trim(), 'Grep')) ? '--exclude':'xx'
cab <expr> xd (StartsWith(&gp,'grep') && getcmdtype()==':' && StartsWith(getcmdline()->trim(), 'Grep')) ? '--exclude-dir':'xd'

" -- Ctags -----------------------------------------------------------------

nnoremap <Leader>c :!ctags -R --exclude=.git --exclude=build --exclude=venv .<CR>

function! Ctags() abort
  let l:cmd_find = 'find'
  if g:env == 'WIN'
    let l:cmd_find = '"'
          \ . fnamemodify(system('where git'), ':h:h')
          \ . '\usr\bin\find.exe"'
    " echom l:cmd_find
  endif
  let l:ignores = ''
  for l:dir in g:ignoredirs
    let l:ignores .= ' -not -path "./' . l:dir . '/*"'
  endfor
  " echom l:ignores

  let l:ext = expand('%:e')
  let l:cppexts = ['cpp', 'h', 'hpp', 'c', 'cc']
  if index(l:cppexts, l:ext)
    for l:e in l:cppexts
      let l:exts = ' -name "*."' . l:e
    endfor
  endif

  echom system(l:cmd_find . ' -name "*."' . expand('%:e')
        \ . l:ignores . ' -exec ctags {} +')
endfunction

command! RunCtags call Ctags()
nnoremap <Leader>c :RunCtags<CR>:redraw<CR>

" -- cycle colorscheme  ----------------------------------------------------

let g:colorschemes = getcompletion('', 'color')

function! CycleColorschemes(dir) abort
  let cur = execute('colo')->trim()
  let idx = index(g:colorschemes, cur)
  let idx = a:dir < 0 ? idx - 1 : idx + 1
  if idx >= 0 && idx < len(g:colorschemes)
    execute 'colo' g:colorschemes[idx]
  endif
endfunction

command! ColoNext call CycleColorschemes(1)
command! ColoPrev call CycleColorschemes(-1)

" -- Indentation guides ----------------------------------------------------

" Copyright 2022 Igor Burago. Distributed under the ISC License terms.

" Simple emulation of indentation guides.
"
" For tab-based indentation, using the 'listchars' option works fine.
" For space-based indentation, one can either:
" • use the match highlighting feature (see ':help match-highlight'),
"   as shown in ToggleMatchHighlightIndentGuides(); or
" • use the 'leadmultispace' setting of the 'listchars' option (added
"   in Vim 9.0), as shown in ToggleListCharsIndentGuides().
"
" The mapping for toggling indentation guides will look like
"   nnoremap <silent> <leader><bar> :call ToggleMatchHighlightIndentGuides()<cr>
" or
"   nnoremap <silent> <leader><bar> :call ToggleListCharsIndentGuides()<cr>
" respectively.

func! ToggleMatchHighlightIndentGuides()
  if !exists('b:indent_guides_enabled')
    if !&expandtab && &tabstop == &shiftwidth
      let b:indent_guides_enabled = 'tabs'
      let b:indent_guides_list_opt = &l:list
      let b:indent_guides_listchars_opt = &l:listchars
      exe 'setl listchars'..'+'[!&l:list]..'=tab:˙\  list'
    else
      let b:indent_guides_enabled = 'spaces'
      let pos = range(1, &textwidth > 0 ? &textwidth : 80, &shiftwidth)
      call map(pos, '"\\%"..v:val.."v"')
      let pat = '\%(\_^ *\)\@<=\%('..join(pos, '\|')..'\) '
      let b:indent_guides_match = matchadd('ColorColumn', pat)
    endif
  else
    if b:indent_guides_enabled == 'tabs'
      let &l:list = b:indent_guides_list_opt
      let &l:listchars = b:indent_guides_listchars_opt
      unlet b:indent_guides_list_opt
      unlet b:indent_guides_listchars_opt
    else
      call matchdelete(b:indent_guides_match)
      unlet b:indent_guides_match
    endif
    unlet b:indent_guides_enabled
  endif
endfunc

func! ToggleListCharsIndentGuides()
  if !exists('b:indent_guides_enabled')
    let b:indent_guides_enabled = 1
    let b:indent_guides_list_opt = &l:list
    let b:indent_guides_listchars_opt = &l:listchars
    let lcs = &l:list ? [&listchars] : []
    if !&expandtab
      let lcs += ['tab:> ']
    endif
    if &ts!= 0 " && &tabstop != &shiftwidth
      if has("patch-8.2.5066")
        let lcs += ['leadmultispace:┆'..repeat(' ', &ts-1)]
      else
        let lcs += ['multispace:┆'..repeat(' ', &ts-1)]
      endif
    endif
    let &l:listchars = join(lcs, ',')
    setl list
  else
    let &l:list = b:indent_guides_list_opt
    let &l:listchars = b:indent_guides_listchars_opt
    unlet b:indent_guides_list_opt
    unlet b:indent_guides_listchars_opt
    unlet b:indent_guides_enabled
  endif
endfunc

if has("patch-8.2.3424")
  command! -nargs=0 ToggleIndentGuides call ToggleListCharsIndentGuides()
else
  command! -nargs=0 ToggleIndentGuides call ToggleMatchHighlightIndentGuides()
endif

nnoremap <silent> <leader><bar> :ToggleIndentGuides<CR>
