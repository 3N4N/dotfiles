setlocal nonumber norelativenumber
setlocal nowrap
setlocal colorcolumn=0
setlocal signcolumn=no
wincmd J

setlocal statusline=%1*%t
            \%0*\ %<%{exists('w:quickfix_title')?w:quickfix_title:''}
            \%=
            \\ %2*\ %l/%L%(\ %)
