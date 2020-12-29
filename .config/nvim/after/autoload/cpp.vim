
function! SwitchToHeader() abort
    let l:root = expand('%:t:r')
    let l:ext = expand('%:t:e')

    if l:ext ==# 'cpp'
        " exe "e inc/" . l:root . ".h"
        exe "find " . l:root . ".h"
    elseif l:ext ==# 'h' && filereadable('src/'.l:root.'.cpp')
        " exe "e src/" . l:root . ".cpp"
        exe "find " . l:root . ".cpp"
    endif
endfunction
nnoremap <Leader>wh :<C-u>call SwitchToHeader()<CR>

