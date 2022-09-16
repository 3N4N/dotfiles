setl tabstop=2
setl softtabstop=2
setl shiftwidth=2
setl et
if executable('tidy')
  setl fp=tidy\ -q\ -i
else
  echohl Error | echom "[html] tidy executable not found" | echohl None
endif
