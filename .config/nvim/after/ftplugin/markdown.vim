setlocal textwidth=80
setlocal spell

setlocal formatoptions=tcqjroln
setlocal comments=fb:[],fb:[\ ],fb:[x],fb:[X],fb:*,fb:-,fb:+,n:>

setlocal statusline=[%{winnr()}]
            \\ %<%{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
			\\ %m%r
			\%=
			\\ %-14.(%l:%3(%v%)\ %)\ %{wordcount()['words']}W
