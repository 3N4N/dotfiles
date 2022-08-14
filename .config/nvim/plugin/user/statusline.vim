" -- Stautsline ----------------------------------------------------------------

function! MyStatusLine() abort
  let filename = expand('%:~:.')
  if filename !=# ''
    if strlen(filename) > winwidth(0) - 10
      let filename = pathshorten(filename)
    endif
  else
    let filename = '[No Name]'
  endif

  let status = " %{&modified?'Δ':&readonly||!&modifiable?'ø':'✓'}"
  let status .= " %<" . filename
  let status .= "%="
  let status .= " %l: %v "
  return status
endfunction

let &laststatus = 2
let &statusline = '%!MyStatusLine()'


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

let &showtabline = 1
let &tabline = "%!MyTabLine()"
