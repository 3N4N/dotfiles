setlocal nonumber norelativenumber
setlocal nowrap
setlocal colorcolumn=0
setlocal signcolumn=no
wincmd J

setlocal statusline=%t
            \\ %<%{exists('w:quickfix_title')?w:quickfix_title:''}
            \%=
            \\ %l/%L%(\ %)
