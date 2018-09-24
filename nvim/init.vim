"  _ ____   _(_)_ __ ___
" | '_ \ \ / / | '_ ` _ \
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|


" -- General -------------------------------------------------------------------

set colorcolumn=81            " colorize a column to show long lines
set conceallevel=0            " don't conceal anything
set fillchars=vert:│          " use unicode icon for vertical split
set nocursorline              " cursorline slows down vim
set nolazyredraw              " redraw screen
set noruler                   " ruler removes column position from ctrl-g
set noswapfile                " don't use swap files
set nonumber relativenumber   " show relative line numbers
set shortmess=filmnxrtToO     " shorten some messages
set showmode                  " show current mode at the bottom
set signcolumn=no             " never show gutter column
set spelllang=en_us           " set language for spell checking
set splitbelow                " always split below
set splitright                " always split right
set synmaxcol=200             " don't highlight after 200 columns
set updatetime=250            " update after each 0.25s
set virtualedit=block         " select empty spaces in visual-block mode
set cpo-=aA                   " :read and :write <file> shouldn't set #
set backspace=indent,eol,start

" show useful visual icons
set list
set listchars=tab:┆\ ,trail:▫,nbsp:_,extends:»,precedes:«

" wrap lines visually
set nowrap                " don't wrap long lines
set breakindent           " continue wrapped lines visually indented
set linebreak             " break at 'breakat' rather than last character
set showbreak=↪           " show ↪ before wrapped lines

" keymap timeout settings
set notimeout
set ttimeout
set ttimeoutlen=50

" -- Clipboard -----------------------------------------------------------------

let g:clipboard = {
            \   'name': 'xclip-xfce4-clipman',
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

" -- Indentation ---------------------------------------------------------------

set cinoptions=g0,l1,i0

" -- Tab settings --------------------------------------------------------------

set tabstop=4         " number of spaces that a <Tab> in the file counts for
set softtabstop=4     " number of spaces a <Tab> accounts for while editing
set shiftwidth=4      " number of spaces to use for each step of (auto)indent
set smarttab          " use 'shiftwidth' when press <Tab> in front of a line
set shiftround        " round indent to multiple of 'shiftwidth'
set expandtab         " use spaces instead of tabs

command! -nargs=1 Spaces execute "setlocal tabstop=" . <args> . " shiftwidth="
            \ . <args> . " softtabstop=" . <args> . " expandtab" |
            \ echo "tabstop = shiftwidth = softtabstop = " . &tabstop
            \ . " -> ".(&expandtab ? "spaces" : "tabs")
command! -nargs=1 Tabs   execute "setlocal tabstop=" . <args> . " shiftwidth="
            \ . <args> . " softtabstop=" . <args> . " noexpandtab" |
            \ echo "tabstop = shiftwidth = softtabstop = " . &tabstop
            \ . " -> ".(&expandtab ? "spaces" : "tabs")

" -- Key Mapping ---------------------------------------------------------------

" map leader
let mapleader = "\<Space>"

" reload vimrc
nnoremap <silent> <Leader>r :so $MYVIMRC<CR>

" Uppercase word mapping.
inoremap <C-u> <esc>m0gUiw`0a

" escape with double tapping j in insert mode
inoremap jj <Esc>

" sensible yank til last character
nnoremap Y y$

" goto buffer
nnoremap gb :ls<CR>:b<Space>

" undo with <S-u>
nnoremap U <C-r>

" strip trailing whitespaces
nnoremap <silent> gs :StripTrailingWhiteSpaces<CR>
command! -nargs=0 StripTrailingWhiteSpaces
            \ let _w=winsaveview() <Bar>
            \ let _s=@/ |
            \ %s/\s\+$//e |
            \ let @/=_s|
            \ unlet _s |
            \ call winrestview(_w) |
            \ unlet _w

" turn off highlighting until next search
nnoremap <Leader>h :nohlsearch<CR>

" don't move cursor while joining lines
nnoremap J m0J`0

" don't move cursor while changing case
nnoremap gUiw m0gUiw`0
nnoremap guiw m0guiw`0

" better window management
nnoremap <Leader>wt :tab split<CR>
nnoremap <Leader>wa :b#<CR>
nnoremap <Leader>wb <C-w>s
nnoremap <Leader>ws <Nop>
nnoremap <Leader>w <C-w>
nnoremap <C-w> <Nop>

" handy bracket mappings
let s:pairs = { 'a' : '', 'b' : 'b', 'l' : 'l', 'q' : 'c', 't' : 't' }
for [s:key, s:value] in items(s:pairs)
    execute 'nnoremap <silent> [' . s:key . ' :' . s:value . 'prev<CR>'
    execute 'nnoremap <silent> ]' . s:key . ' :' . s:value . 'next<CR>'
    execute 'nnoremap <silent> [' . toupper(s:key) . ' :' . s:value . 'first<CR>'
    execute 'nnoremap <silent> ]' . toupper(s:key) . ' :' . s:value . 'last<CR>'
endfor

" toggle
nnoremap <silent> <Leader>th :set hlsearch!<Bar>set hlsearch?<CR>
nnoremap <silent> <Leader>tp :set paste!<Bar>set paste?<CR>
nnoremap <silent> <Leader>ts :setlocal spell!<Bar>setlocal spell?<CR>
nnoremap <silent> <Leader>tw :set wrap!<Bar>set wrap?<CR>
nnoremap <silent> <Leader>tl :set nu!<Bar>set rnu!<Cr>
nnoremap <silent> <Leader>tm :let &mouse=(&mouse==#""?"a":"")<Bar>
            \ echo "mouse ".(&mouse==#""?"off":"on")<CR>

" git
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>

" Navigate seamlessly between vim and tmux
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        silent! execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
            call system("tmux select-pane -" . a:tmuxdir)
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
    tnoremap <C-l> <C-\><C-n><C-w>l
endif
tnoremap <Esc> <C-\><C-n>

" disable arrow keys
noremap  <Up>    <Nop>
noremap  <Down>  <Nop>
noremap  <Left>  <Nop>
noremap  <Right> <Nop>

" -- Functions -----------------------------------------------------------------

" redirect the output of a Vim or external command into a scratch buffer
function! Redir(cmd)
    if a:cmd =~ '^!'
        execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
    else
        redir => output
        execute a:cmd
        redir END
    endif
    tabnew
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(output, "\n"))
    put! = a:cmd
    put = '----'
endfunction
command! -nargs=1 Redir silent call Redir(<f-args>)

" -- Autocommand ---------------------------------------------------------------

augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

augroup gitcommit
  autocmd!
  autocmd FileType gitcommit setlocal colorcolumn=72
  autocmd FileType gitcommit setlocal spell
augroup END

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal number norelativenumber colorcolumn=0
    autocmd BufWinEnter quickfix setlocal statusline=%t
                \\ %{exists('w:quickfix_title')?w:quickfix_title:''}%=%l/%L
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup END

" -- Wildmenu ------------------------------------------------------------------

set wildmenu
set wildignorecase
set wildmode=full
set wildignore=*.o,*.obj,*~
set wildignore+=*.swp,*.tmp
set wildignore+=*.mp3,*.mp4,*mkv
set wildignore+=*.bmp,*.gif,*ico,*.jpg,*.png
set wildignore+=*.pdf,*.doc,*.docx,*.ppt,*.pptx
set wildignore+=*.rar,*.zip,*.tar,*.tar.gz,*.tar.xz

" -- Text Objects --------------------------------------------------------------

" simple text-objects
for s:char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . s:char . ' :<C-u>normal! T' . s:char . 'vt' . s:char . '<CR>'
    execute 'onoremap i' . s:char . ' :normal vi' . s:char . '<CR>'
    execute 'xnoremap a' . s:char . ' :<C-u>normal! F' . s:char . 'vf' . s:char . '<CR>'
    execute 'onoremap a' . s:char . ' :normal va' . s:char . '<CR>'
endfor

" line text-objects
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o0
onoremap al :normal val<CR>

" buffer text-objects
xnoremap aa GoggV
onoremap aa :normal vaa<CR>

" -- Search --------------------------------------------------------------------

set ignorecase
set smartcase

" use ag over grep
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ .git
endif

" -- Colorscheme ---------------------------------------------------------------

syntax on
set termguicolors
colorscheme fault
let g:lisp_rainbow = 1

" -- Statusline ----------------------------------------------------------------

set laststatus=2
set statusline=
            \%{&filetype!=#''?&filetype:'none'}
            \\ \ %{&fileformat==#'unix'?'U':&fileformat==#'dos'?'D':'N'}
            \:%{&readonly\|\|!&modifiable?&modified?'%*':'%%':&modified?'**':'--'}
            \\ \ %{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
            \%=%<\ %-14(%l,%v%)\ %4(%p%%%)

" -- Tabline -------------------------------------------------------------------

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        let tabnr = i + 1
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
set showtabline=1
set tabline=%!MyTabLine()

" -- Netrw ---------------------------------------------------------------------

let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_liststyle=0
let g:netrw_sort_by='name'
let g:netrw_sort_direction='normal'
let g:netrw_winsize=25
let g:netrw_list_hide = '^\./$,^\../$,^\.git/$'
let g:netrw_hide = 1
let g:netrw_cursor=0
