" -- Title -----------------------------------------------------------------

set title
let &titlestring = (has('nvim') ? 'Nvim' : 'Vim')
      \ . " %{&modified?'•':':'} %{getcwd()->fnamemodify(':~')}"

" -- Stautsline ------------------------------------------------------------

function! PathShortenIfLong(path)
  if strlen(a:path) > winwidth(0) - 10
    return pathshorten(a:path)
  endif
  return a:path
endfunction

let &laststatus = 2

let &statusline = " %{&modified?'Δ':&readonly||!&modifiable?'ø':'✓'}|%{winnr()}"
let &statusline .= " %<%{expand('%:~:.')!=#''?PathShortenIfLong(expand('%:~:.')):'[No Name]'}"
let &statusline .= "%="
let &statusline .= " %l,%v "

" -- Tabline ---------------------------------------------------------------

function! MyTabLine() abort
  let s = ''
  for tabnr in range(1, tabpagenr('$'))
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')
    let s .= '%' . tabnr . 'T'
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tabnr
    let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '
  endfor
  let s .= '%#TabLineFill#'
  return s
endfunction

let &showtabline = 1
let &tabline = "%!MyTabLine()"
