" Author : Enan Ajmain
" Email  : 3nan.ajmain@gmail.com
" Github : https://github.com/3N4N


if !exists('g:env')
    if has('wsl')
        let g:env = 'WSL'
    elseif has('win32')
        let g:env = 'WIN'
    else
        let g:env = 'UNIX'
    endif
endif

if g:env ==# 'WIN'
    let s:vim_plug_dir = expand('~/AppData/Local/nvim-data/plugged')
else
    let s:vim_plug_dir = expand('~/.config/nvim/plugged')
endif


" -- Vim Plug ------------------------------------------------------------------

if g:env ==# 'UNIX' || g:env ==# 'WSL'
    if empty(glob(expand('~/.local/share/nvim/site/autoload/plug.vim')))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
elseif g:env ==# 'WIN'
    if empty(glob(expand('~/AppData/Local/nvim-data/site/autoload/plug.vim')))
        call system('curl -fLo '
                    \ . expand('~/AppData/Local/nvim-data/site/autoload/plug.vim')
                    \ . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    endif
endif

let g:plug_url_format = 'git@github.com:%s.git'

call plug#begin(s:vim_plug_dir)

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'mcchrish/fountain.vim'
Plug 'benknoble/gitignore-vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'luochen1990/rainbow'
Plug 'junegunn/vim-easy-align'

Plug 'neovim/nvim-lspconfig'

call plug#end()



" -- lua config ----------------------------------------------------------------

lua require('plenary.reload').reload_module('user', true)

lua require('user.options')
lua require('user.clipboard')
lua require('user.plugins')
lua require('user.lspconfig')
lua require('user.functions')


" -- Key Mapping ---------------------------------------------------------------

" Map leader
let mapleader = "\<Space>"

" Reload vimrc
nnoremap <silent> <Leader>r :so $MYVIMRC<CR>

" Uppercase word in Insert-mode
inoremap <C-u> <Esc>m0gUiw`0a

" Consistent movement
noremap gh _
noremap gl $
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Folding
nnoremap za zA
nnoremap zA za

" Break undo sequence, start new change
inoremap <C-h> <C-g>u<C-h>
inoremap <CR> <C-]><C-g>u<CR>

" Sensible yank till last character
nnoremap Y y$

" Undo with <S-u>
nnoremap U <C-r>

" Recall older/newer command-line from history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Move to next and previous matches
" without exiting command-line-mode
" `incsearch` needs to be set
cnoremap <C-j> <C-g>
cnoremap <C-k> <C-t>
cnoremap <C-g> <C-k>
cnoremap <C-t> <Nop>

" Use `:tjump` instead of `:tag`
nnoremap <C-]> g<C-]>
nnoremap <C-w><C-]> <C-w>g]

" Useful leader mappings
nnoremap <Leader>; :
xnoremap <Leader>; :
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Bslash>f :grep<Space>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>s :%s:\v
xnoremap <Leader>s :s:\%V\v

" Go in and out of diffmode
nnoremap <Leader>dt :windo diffthis<CR>
nnoremap <Leader>do :windo diffoff<CR>

" Opening files
nnoremap <Leader>e :e **/*
nnoremap <Leader>o :e `find . -path '**/.git' -prune -o -type f -iname '**' -print`
            \<S-left><Left><Left><Left>

" Show name of syntax element below cursor
command! SynName  echo synIDattr(synID(line("."), col("."), 1), "name")
nnoremap <F12> :SynName<CR>

" Strip trailing whitespace
nnoremap <silent> gs :StripTrailingWhiteSpace<CR>
command! -nargs=0 StripTrailingWhiteSpace
            \ let _w=winsaveview() <Bar>
            \ let _s=@/ |
            \ %s/\s\+$//e |
            \ let @/=_s|
            \ unlet _s |
            \ call winrestview(_w) |
            \ unlet _w |
            \ noh

" Don't jump to the next result when searching with * or #
nnoremap <silent> * :let _w = winsaveview()<CR>
            \:normal! *<CR>
            \:call winrestview(_w)<CR>
            \:unlet _w<CR>
nnoremap <silent> # :let _w = winsaveview()<CR>
            \:normal! #<CR>
            \:call winrestview(_w)<CR>
            \:unlet _w<CR>

" direction-unaware search and jump
nnoremap <expr> n (v:searchforward ? 'n' : 'N')
nnoremap <expr> N (v:searchforward ? 'N' : 'n')
nnoremap <expr> ; getcharsearch().forward ? ';':','
nnoremap <expr> , getcharsearch().forward ? ',':';'

" Better window management
nnoremap <Leader>w <C-w>
nnoremap <Leader>wq ZZ
nnoremap <Leader>wt :tab split<CR>
nnoremap <Leader>wa :b#<CR>
nnoremap <Leader>wb <C-w>s
nnoremap <Leader>ws <Nop>
nnoremap <Leader>ww :vert res 85<CR>

" Switch tabpages
nnoremap ) gt
nnoremap ( gT

" Handy bracket mappings
let s:pairs = { 'a' : '', 'b' : 'b', 'l' : 'l', 'q' : 'c', 't' : 't' }
for [s:key, s:value] in items(s:pairs)
    execute 'nnoremap <silent> [' . s:key . ' :' . s:value . 'prev<CR>'
    execute 'nnoremap <silent> ]' . s:key . ' :' . s:value . 'next<CR>'
    execute 'nnoremap <silent> [' . toupper(s:key) . ' :' . s:value . 'first<CR>'
    execute 'nnoremap <silent> ]' . toupper(s:key) . ' :' . s:value . 'last<CR>'
endfor

" Toggle
nnoremap <silent> <Leader>tc :let &colorcolumn=(&cc==0)?81:0<CR>
nnoremap <silent> <Leader>te :set expandtab!<Bar>set expandtab?<CR>
nnoremap <silent> <Leader>th :set hlsearch!<Bar>set hlsearch?<CR>
nnoremap <silent> <Leader>tl :set nu!<Cr>
nnoremap <silent> <Leader>tp :set paste!<Bar>set paste?<CR>
nnoremap <silent> <Leader>ts :setlocal spell!<Bar>setlocal spell?<CR>
nnoremap <silent> <Leader>tw :set wrap!<Bar>set wrap?<CR>
nnoremap <silent> <Leader>tm :let &mouse=(&mouse==#""?"a":"")<Bar>
            \ echo "mouse ".(&mouse==#""?"off":"on")<CR>

" CTRL-X submode
inoremap <C-]> <C-x><C-]>
inoremap <C-l> <C-x><C-l>
inoremap <C-o> <C-x><C-o>

" Git
nnoremap <Leader>gs :keepalt Git<CR>
nnoremap <Leader>gd :keepalt Gvdiffsplit<CR>
nnoremap <Leader>gc :keepalt Git commit<CR>
nnoremap <Leader>gw :keepalt Gwrite<CR>
nnoremap <Leader>gr :keepalt Gread<CR>
nnoremap <Leader>gb :keepalt Git blame<CR>
nnoremap <Leader>gg :keepalt Git grep ''<Left>

" Navigate seamlessly between vim and tmux
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir) abort
        let previous_winnr = winnr()
        silent! execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
            call system("tmux list-panes -F '#F' | grep -q Z
                        \|| tmux select-pane -" . a:tmuxdir)
        endif
    endfunction

    let previous_title = substitute(system("tmux display-message -p
                \ '#{pane_title}'"), '\n', '', '')
    let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
    let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

    nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
    nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
    nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
    nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
    tnoremap <silent> <C-h> <C-\><C-n>:call TmuxOrSplitSwitch('h', 'L')<CR>
    tnoremap <silent> <C-j> <C-\><C-n>:call TmuxOrSplitSwitch('j', 'D')<CR>
    tnoremap <silent> <C-k> <C-\><C-n>:call TmuxOrSplitSwitch('k', 'U')<CR>
    tnoremap <silent> <C-l> <C-\><C-n>:call TmuxOrSplitSwitch('l', 'R')<CR>
else
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    " tnoremap <C-l> <C-\><C-n><C-w>l
endif
tnoremap <Esc> <C-\><C-n>
nnoremap <C-A-l> <C-l>


cabbrev cmakefile CMakeLists.txt



" -- Text Objects --------------------------------------------------------------

" Simple text-objects
for s:char in [ '_', '.', ':', ',', ';', '<Bar>', '/', '<Bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . s:char . ' :<C-u>normal! T' . s:char . 'vt' . s:char . '<CR>'
    execute 'onoremap i' . s:char . ' :normal vi' . s:char . '<CR>'
    execute 'xnoremap a' . s:char . ' :<C-u>normal! F' . s:char . 'vf' . s:char . '<CR>'
    execute 'onoremap a' . s:char . ' :normal va' . s:char . '<CR>'
endfor

" Line text-objects
xnoremap il ^og_
onoremap il :normal vil<CR>
xnoremap al 0o$
onoremap al :normal val<CR>

" Buffer text-objects
xnoremap aa GoggV
onoremap aa :normal vaa<CR>


" -- Functions and Commands ----------------------------------------------------

command! -nargs=1 Inspect lua print(vim.inspect(<args>))

" Send selected text to a pastebin
command! -range=% Paste execute <line1> . "," . <line2>
      \ . "w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\\n' | "
      \ . (has('unix') ? "xclip -selection clipboard" : "win32yank.exe -i")

" Redirect the output of a Vim or external command into a scratch buffer
command! -nargs=1 -complete=command Redir
            \ tabnew |
            \ setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile |
            \ call setline(1, split(execute(<q-args>), "\n"))

command! Date put =strftime('%Y-%m-%d')

command! ReloadLua lua require('plenary.reload').reload_module('user', true)

command! -nargs=1 -complete=function Echopy
            \ let output = expand(<args>) |
            \ echo output |
            \ let @* = output |
            \ unlet output

" Use tabs for indentation and spaces for alignment
function! SpecialTab() abort
    if (col('.') == 1) || (matchstr(getline('.'), '\%'.(col('.') - 1).'c.') =~ '\t')
        return "\<Tab>"
    else
        return repeat("\<Space>", (&tabstop - (virtcol('.') % &tabstop)) + 1)
    endif
endfunction
if !&et
    inoremap <Tab> <C-R>=SpecialTab()<CR>
endif

" Repeatable window resize
function! RepeatResize(first) abort
    let l:command = a:first
    while stridx('+-><', l:command) != -1
        execute "normal! \<C-w>" . l:command
        redraw
        let l:command = nr2char(getchar())
    endwhile
endfunction
nnoremap <Leader>w- :call RepeatResize('-')<CR>
nnoremap <Leader>w+ :call RepeatResize('+')<CR>
nnoremap <Leader>w< :call RepeatResize('<')<CR>
nnoremap <Leader>w> :call RepeatResize('>')<CR>

" Switch windows effortlessly
function! SwitchWindow(count) abort
    let l:current_buf = winbufnr(0)
    exe "buffer" . winbufnr(a:count)
    exe a:count . "wincmd w"
    exe "buffer" . l:current_buf
    " wincmd p
endfunction
nnoremap <Leader>wx :<C-u>call SwitchWindow(v:count1)<CR>

" Copy yanked text to tmux pane
function! SendToTmux(visual, count) range abort
    if (a:visual)
        execute "normal! gv\"zy"
    else
        execute "normal! \"zyip"
    endif
    let text = @z
    let text = substitute(text, ';', '\\;', 'g')
    let text = substitute(text, '"', '\\"', 'g')
    let text = substitute(text, '\n', '" Enter "', 'g')
    let text = substitute(text, '!', '\\!', 'g')
    let text = substitute(text, '%', '\\%', 'g')
    let text = substitute(text, '#', '\\#', 'g')
    silent execute "!tmux send-keys -t " . a:count . " -- \"" . text . "\""
    silent execute "!tmux send-keys -t " . a:count . "Enter"
endfunction
nnoremap <Leader>p :<C-u>call SendToTmux(0, v:count1)<CR>
xnoremap <Leader>p :<C-u>call SendToTmux(1, v:count1)<CR>

" Use * and # over visual selection
function! s:VSetSearch(cmdtype) abort
    let t = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let _w = winsaveview()
    let @s = t
    call winrestview(_w)
    unlet _w
    unlet t
endfunction
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>

" Get filenames ignoring `wildignore`
function! MyCompleteFileName() abort
    " match a (potential) wildcard preceding cursor position
    " note: \f is a filename character, see :h 'isfname'
    let l:pattern = matchstr(strpart(getline('.'), 0, col('.') - 1), '\v(\f|\*|\?)*$')
    let l:file_comp_list = getcompletion(l:pattern, "file")
    " let l:file_comp_list += getcompletion(l:pattern, "file_in_path")
    " set the matches
    call complete(col('.') - len(l:pattern), l:file_comp_list)
    " must return an empty string to show the menu
    return ''
endfunction
inoremap <C-F> <C-R>=MyCompleteFileName()<CR>

" Center the next block of text
function! CenterNextBlock() abort
    let l:cur_line = getline(".")
    if (l:cur_line != '')
        normal! }
        let l:line1 = line(".")
        keepjumps normal! }
    else
        let l:line1 = line(".")
        normal! }
    endif
    let l:line2 = line(".")
    let l:line = l:line1 + ((l:line2 - l:line1) / 2)
    execute "call cursor(" . l:line . ",1)"
    normal! zz
endfunction
nnoremap - :<C-u>call CenterNextBlock()<CR>

" Center the previous block of text
function! CenterPrevBlock() abort
    let l:cur_line = getline(".")
    if (l:cur_line != '')
        normal! {
        let l:line1 = line(".")
        keepjumps normal! {
    else
        let l:line1 = line(".")
        normal! {
    endif
    let l:line2 = line(".")
    let l:line = l:line1 - ((l:line1 - l:line2) / 2)
    execute "call cursor(" . l:line . ",1)"
    normal! zz
endfunction
nnoremap _ :<C-u>call CenterPrevBlock()<CR>

function! UpdateTodoKeywords(...) abort
    let newKeywords = join(a:000, " ")
    let synTodo = map(filter(split(execute("syntax list"), '\n'),
                \ { i,v -> match(v, '^\w*Todo\>') == 0}),
                \ {i,v -> substitute(v, ' .*$', '', '')})
    for synGrp in synTodo
        execute "syntax keyword " . synGrp . " contained " . newKeywords
    endfor
endfunction

augroup todo
    autocmd!
    " autocmd Syntax * call UpdateTodoKeywords("NOTE", "NOTES")
    autocmd Syntax * call UpdateTodoKeywords("NOTE")
augroup END



" -- Autocommands --------------------------------------------------------------

augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * setlocal bufhidden=hide signcolumn=no
    " autocmd BufEnter term://* startinsert
augroup END

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup END

" augroup resize_splits
"     au!
"     au VimResized * wincmd =
" augroup END


" -- Title ---------------------------------------------------------------------

set title
let &titlestring = (has('nvim') ? "NVIM" : "VIM") . " %{&modified?'•':':'} %t"


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


" -- Ctags ---------------------------------------------------------------------

nnoremap <Leader>c :!ctags -R --exclude=.git --exclude=build --exclude=venv .<CR>


" -- Uncrustify ----------------------------------------------------------------

let g:uncrustifyCfgFile = expand("$HOME/.uncrustify.cfg")

function! UncrustifyFunc(options) range
    exec a:firstline.','.a:lastline.'!uncrustify '.a:options
                \.' -c '.g:uncrustifyCfgFile.' -q -l '.&filetype
endfunction

command! -range=% UncrustifyRange <line1>,<line2>call UncrustifyFunc('--frag')
command! Uncrustify  let s:save_cursor = getcurpos()
                  \| %call UncrustifyFunc('')
                  \| call setpos('.', s:save_cursor)

nnoremap <Leader>u :Uncrustify<CR>
xnoremap <Leader>u :UncrustifyRange<CR>

if !empty(findfile('src/uncrustify.cfg', ';'))
  let &formatprg = 'uncrustify -q -l C -c src/uncrustify.cfg --no-backup'
endif


" -- Telescope -----------------------------------------------------------------

lua require('user.telescope')

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files({show_untracked = false})<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fa <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').tags()<cr>
nnoremap <leader><C-]> <cmd>execute "Telescope tags default_text='" . expand("<cword>")<cr>


" -- Easy Align ----------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" -- Lua Modules ---------------------------------------------------------------

nnoremap <Bslash>P :let g:termutilchan=eval(b:terminal_job_id)<CR>
nnoremap <silent><Bslash>p :lua require("termutil").sendToTerm(0)<CR>
xnoremap <silent><Bslash>p :lua require("termutil").sendToTerm(1)<CR>

nnoremap <silent><Bslash>cc :lua require("docommenter").docformat_text()<CR>
nnoremap <silent><Bslash>ci :lua require("docommenter").docinfo()<CR>

nnoremap <silent>gx :lua require("user.functions").betterGX()<CR>


" -- Load Local Vimrc ----------------------------------------------------------

if filereadable('local.vim')
    source local.vim
endif

if filereadable('.local.vim')
    source .local.vim
endif
