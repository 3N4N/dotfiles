" -- Netrw -----------------------------------------------------------------

let g:netrw_altv = 1
let g:netrw_banner = 1
let g:netrw_browse_split = 0
let g:netrw_cursor = 0
let g:netrw_hide = 1
" let g:netrw_list_hide = "^\./$,^\../$,^\.git/$"
let g:netrw_list_hide = "^.git$"
let g:netrw_liststyle = 1
let g:netrw_sort_by = "name"
let g:netrw_sort_direction = "normal"
" let g:netrw_winsize = 25

" -- Closetag --------------------------------------------------------------

let g:closetag_filetypes = "html,xhtml,phtml,javascript"
let g:closetag_xhtml_filetypes = "xhtml,jsx,javascript"
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = ">"
let g:closetag_close_shortcut = ""

" -- Rainbow Parentheses ---------------------------------------------------

let g:lisp_rainbow = 0
let g:rainbow_active = 1

" -- Bullets ---------------------------------------------------------------

let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text',
      \ 'gitcommit',
      \ 'scratch'
      \]

let g:bullets_enable_in_empty_buffers = 0 " default = 1
let g:bullets_set_mappings = 1 " default = 1
let g:bullets_outline_levels = ['num', 'abc', 'std-']
