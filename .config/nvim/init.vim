" Author : Enan Ajmain
" Email  : 3nan.ajmain@gmail.com
" Github : https://github.com/3N4N


if !exists("g:env")
    if has('windows')
        let g:env = "WIN"
    elseif system('uname') =~? "msys"
        let g:env = "MSYS2"
    else
        let g:env = "LINUX"
    endif
endif

if g:env ==# "WIN"
    let s:cmd_mkdir = "md"
    let s:vim_plug_dir = "~/AppData/Local/nvim-data/plugged"
else
    let s:cmd_mkdir = "mkdir -p"
    let s:vim_plug_dir = "~/.config/nvim/plugged"
endif

" -- Vim Plug ------------------------------------------------------------------


if g:env !=# "WIN"
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif


let g:plug_url_format = 'git@github.com:%s.git'

call plug#begin(s:vim_plug_dir)

" Plug 'romainl/flattened'
" Plug 'ashfinal/vim-colors-violet'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-ragtag'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'ludovicchabant/vim-gutentags'


Plug 'jalvesaq/Nvim-R'
" Plug 'vim-pandoc/vim-pandoc-syntax'

" Plug 'alvan/vim-closetag'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'prettier/vim-prettier', {
"             \ 'do': 'yarn install',
"             \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json',
"             \         'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()

" -- General -------------------------------------------------------------------

" Visual perks
set conceallevel=0
set nocursorcolumn
set nocursorline
set nolazyredraw
set nomodeline
set nonumber
set norelativenumber
set noruler
set showmode
set signcolumn=no
" let &colorcolumn=join(range(81,999),",")
let &colorcolumn=0
let &fillchars="vert:│"
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
            \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175
set guicursor=

" New split position
set nosplitbelow
set nosplitright

" Dictionary and spelling
set dictionary=/usr/share/dict/words
set spelllang=en_us

" Set powershell default terminal in windows
if g:env !=# "WIN"
    let &shell = 'pwsh'
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote= shellxquote=
endif

" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan
nohlsearch

" if executable('ag')
"   let &grepprg="ag --vimgrep --hidden --ignore={.git,dictionary.txt}"
" else
"   let &grepprg="grep -Hnri --exclude-dir=\".git\" --exclude-from=\"dictionary.txt\""
" endif

if g:env ==# "WIN"
    let &grepprg="grep -IHnri --exclude-dir=.git --exclude=\"tags\""
else
    let &grepprg="grep -IHnri --exclude-dir={.git,node_modules} --exclude=\"tags\""
endif

" Wildmenu settings
set wildmenu
set wildignorecase
let &wildmode="full"
let &wildoptions="pum"
set pumblend=0
set complete-=t
set wildignore=*.o,*.obj,*~,*.class
set wildignore+=*/.git
set wildignore+=*.swp,*.tmp
set wildignore+=*.mp3,*.mp4,*mkv
set wildignore+=*.bmp,*.gif,*ico,*.jpg,*.png
set wildignore+=*.pdf,*.doc,*.docx,*.ppt,*.pptx
set wildignore+=*.rar,*.zip,*.tar,*.tar.gz,*.tar.xz

" Show useful visual icons
set list
let &listchars="tab:┆\ ,trail:▫,nbsp:_,extends:»,precedes:«"

" Wrap lines visually
set nowrap
set breakindent
set linebreak
let &showbreak = "↪ "
set breakindentopt=shift:2

" Folding
set foldcolumn=0
set foldmethod=manual

" Keymap timeout settings
set notimeout
set ttimeout
set ttimeoutlen=10

" Miscellaneous settings
let &inccommand="nosplit"
set backspace=indent,eol,start
set cinoptions=g0,l1,i0,t0,(0
set cpoptions-=aA
set nojoinspaces
set shortmess=filmnxrtToO
set synmaxcol=200
set updatetime=250
set virtualedit=block
let &viewoptions="folds,cursor"
let g:tex_flavor='latex'
let R_assign = 2
" let r_indent_align_args = 0

" Backup and swap

set nobackup
set noswapfile

if g:env ==# "WIN"
	set backupdir=~\AppData\Local\nvim-data\backup\
	set directory=~\AppData\Local\nvim-data\swap\
	if !isdirectory(&backupdir)
		call system("md " . &backupdir)
	endif
	if !isdirectory(&directory)
		call system("md " . &directory)
	endif
else
	set backupdir=~/.local/share/nvim/backup//
	set directory=~/.local/share/nvim/swap//
	if !isdirectory(&backupdir)
		call system("mkdir -p " . &backupdir)
	endif
	if !isdirectory(&directory)
		call system("mkdir -p " . &directory)
	endif
endif

" Persistent Undo
if has('persistent_undo')
    set undofile
    if g:env ==# "WIN"
	    set undodir=~\AppData\Local\nvim-data\undo\
    else
	    set undodir=~/.local/share/nvim/undo//
    endif
endif

" Colorscheme
syntax on
let g:lisp_rainbow = 1
set termguicolors
set bg=light
colo violet

" gui settings
set guifont=Iosevka\ Term:h14
let g:neovide_cursor_animation_length=0

" -- Clipboard -----------------------------------------------------------------

if g:env !=# "WIN"
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
endif
set clipboard+=unnamed

" -- Tab settings --------------------------------------------------------------

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set shiftround
set expandtab

" -- Make ----------------------------------------------------------------------

if isdirectory("build")
    set makeprg=make\ -C\ build
else
    set makeprg=make
endif

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

" Useful leader mappings
nnoremap <Leader>; :
xnoremap <Leader>; :
nnoremap <Leader>b :ls<CR>:b<Space>
" nnoremap <Leader>f :grep<Space>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>s :%s:\v
xnoremap <Leader>s :s:\%V\v

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

" Switch tabpages
nnoremap <Leader>] gt
nnoremap <Leader>[ gT

" Handy bracket mappings
let s:pairs = { 'a' : '', 'b' : 'b', 'l' : 'l', 'q' : 'c', 't' : 't' }
for [s:key, s:value] in items(s:pairs)
    execute 'nnoremap <silent> [' . s:key . ' :' . s:value . 'prev<CR>'
    execute 'nnoremap <silent> ]' . s:key . ' :' . s:value . 'next<CR>'
    execute 'nnoremap <silent> [' . toupper(s:key) . ' :' . s:value . 'first<CR>'
    execute 'nnoremap <silent> ]' . toupper(s:key) . ' :' . s:value . 'last<CR>'
endfor

" Toggle key bindings
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
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gg :Git grep ''<Left>

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

" Send selected text to a pastebin
command! -range=% Paste silent execute <line1> . "," . <line2>
            \ . "w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\\n'
            \ | xclip -selection clipboard"

" Redirect the output of a Vim or external command into a scratch buffer
command! -nargs=1 Redir
            \ tabnew |
            \ setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile |
            \ call setline(1, split(execute(<q-args>), "\n"))

command! Date put =strftime('%B %d, %Y')

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

if has('nvim')
    set titlestring=NVIM\ %{&modified?'•':':'}\ %t
else
    set titlestring=VIM\ %{&modified?'•':':'}\ %t
endif

" -- Statusline ----------------------------------------------------------------

set laststatus=2
set statusline=[%{winnr()}]
            \\ %<%{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
            \\ %m%r
            \%=
            \\ %-14.(%l:%3(%v%)\ %)\ %P

" -- Tabline -------------------------------------------------------------------

function! MyTabLine() abort
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
let g:netrw_banner=1
let g:netrw_browse_split=0
let g:netrw_cursor=0
let g:netrw_hide = 1
" let g:netrw_list_hide = '^\./$,^\../$,^\.git/$'
let g:netrw_list_hide = '^\.git/$'
let g:netrw_liststyle=1
let g:netrw_sort_by='name'
let g:netrw_sort_direction='normal'
let g:netrw_winsize=25

" -- FZF -----------------------------------------------------------------------

let g:fzf_preview_window=''

nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fg :GFiles<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fa :Ag<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>fc :Commands<CR>


" -- Closetag ------------------------------------------------------------------

" let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js'
" let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb'
let g:closetag_filetypes = 'html,xhtml,phtml,javascript'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,javascript'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = ''

" -- Ctags ---------------------------------------------------------------------

nnoremap <Leader>c :!ctags -R .<CR>

" -- Uncrustify ----------------------------------------------------------------

let g:uncrustifyCfgFile = '~/.uncrustify.cfg'

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

" -- Prettier ------------------------------------------------------------------

let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

" -- Load Local Vimrc ----------------------------------------------------------

if filereadable("local.vim")
    source local.vim
endif

if filereadable(".local.vim")
    source .local.vim
endif
