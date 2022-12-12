if g:env == "UNIX"
  let g:clipboard = {
        \   'name': 'xclip_nvim',
        \   'copy': {
        \      '+': 'xclip -selection clipboard',
        \      '*': 'xclip -selection clipboard',
        \    },
        \   'paste': {
        \      '+': 'xclip -selection clipboard -o',
        \      '*': 'xclip -selection clipboard -o',
        \   },
        \   'cache_enabled': 1,
        \ }
elseif g:env == "WSL"
  let g:clipboard = {
        \   'name': 'wslyank_nvim',
        \   'copy': {
        \      '+': 'wslyank -i',
        \      '*': 'wslyank -i',
        \    },
        \   'paste': {
        \      '+': 'wslyank -o',
        \      '*': 'wslyank -o',
        \   },
        \   'cache_enabled': 0,
        \ }
endif

set clipboard +=unnamed
