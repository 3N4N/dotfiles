setlocal textwidth=70
setlocal spell

setlocal formatoptions=jtcroqln
setlocal comments=fb:*,fb:-,fb:+,n:>

set statusline=%<%{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
			\\ %m%r
			\%=
			\\ %-14.(%l:%3(%v%)\ %)\ %{wordcount()['words']}W
