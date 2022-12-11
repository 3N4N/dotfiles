" -- Stautsline ----------------------------------------------------------------

function! PathShortenIfLong(path)
  if strlen(a:path) > winwidth(0) - 10
    return pathshorten(a:path)
  endif
  return a:path
endfunction

let &laststatus = 2

let &statusline = " %{&modified?'Δ':&readonly||!&modifiable?'ø':'✓'}"
let &statusline .= " %<%{expand('%:~:.')!=#''?PathShortenIfLong(expand('%:~:.')):'[No Name]'}"
let &statusline .= "%="
let &statusline .= " %l: %v "
let &statusline .= "[%{winnr()},%{tabpagenr()}/%{tabpagenr('$')}]"


" -- Tabline -------------------------------------------------------------------

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

let &showtabline = 0
let &tabline = "%!MyTabLine()"
