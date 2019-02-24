"
"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝


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

" backup and persistent undo
set nobackup
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
if has('persistent_undo')
    set undofile
    set undodir=~/.local/share/nvim/undo//
endif

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

set cinoptions=g0,l1,i0,t0

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
command! -nargs=1 Tabs execute "setlocal tabstop=" . <args> . " shiftwidth="
            \ . <args> . " softtabstop=" . <args> . " noexpandtab" |
            \ echo "tabstop = shiftwidth = softtabstop = " . &tabstop
            \ . " -> ".(&expandtab ? "spaces" : "tabs")

" -- Key Mapping ---------------------------------------------------------------

" map leader
let mapleader = "\<Space>"

" reload vimrc
nnoremap <silent> <Leader>r :so $MYVIMRC<CR>

" Uppercase word mapping
inoremap <C-u> <esc>m0gUiw`0a

" escape with double tapping j in insert mode
inoremap jj <Esc>

" sensible yank til last character
nnoremap Y y$

" undo with <S-u>
nnoremap U <C-r>

" useful leader mappings
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>e :e **/
nnoremap <Leader>f :grep<space>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>s :%s/\v
xnoremap <Leader>s :s/\%V\v

" strip trailing whitespaces
nnoremap <silent> gs :StripTrailingWhiteSpaces<CR>
command! -nargs=0 StripTrailingWhiteSpaces
            \ let _w=winsaveview() <Bar>
            \ let _s=@/ |
            \ %s/\s\+$//e |
            \ let @/=_s|
            \ unlet _s |
            \ call winrestview(_w) |
            \ unlet _w |
            \ noh

" don't move cursor while joining lines
nnoremap J m0J`0

" don't move cursor while changing case
nnoremap gUiw m0gUiw`0
nnoremap guiw m0guiw`0

" don't move cursor when searching with * or #
nnoremap <silent> * :let _w = winsaveview()<CR>
			\:normal! *<CR>
			\:call winrestview(_w)<CR>
			\:unlet _w<CR>
nnoremap <silent> # :let _w = winsaveview()<CR>
			\:normal! #<CR>
			\:call winrestview(_w)<CR>
			\:unlet _w<CR>

" use n and N to always go forward and backward
nnoremap <expr> n (v:searchforward ? 'n' : 'N')
nnoremap <expr> N (v:searchforward ? 'N' : 'n')

" better window management
nnoremap <Leader>w <C-w>
nnoremap <C-w> <Nop>
nnoremap <Leader>wt :tab split<CR>
nnoremap <Leader>wa :b#<CR>
nnoremap <Leader>wb <C-w>s
nnoremap <Leader>ws <Nop>

" vim-fugitive mappings
" https://github.com/tpope/vim-fugitive.git
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>

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
nnoremap <silent> <Leader>te :set expandtab!<Bar>set expandtab?<CR>
nnoremap <silent> <Leader>tp :set paste!<Bar>set paste?<CR>
nnoremap <silent> <Leader>ts :setlocal spell!<Bar>setlocal spell?<CR>
nnoremap <silent> <Leader>tw :set wrap!<Bar>set wrap?<CR>
nnoremap <silent> <Leader>tl :set nu!<Bar>set rnu!<Cr>
nnoremap <silent> <Leader>tm :let &mouse=(&mouse==#""?"a":"")<Bar>
            \ echo "mouse ".(&mouse==#""?"off":"on")<CR>

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
	tnoremap <C-l> <C-\><C-n><C-w>l
endif
tnoremap <Esc> <C-\><C-n>

" disable arrow keys
noremap  <Up>    <Nop>
noremap  <Down>  <Nop>
noremap  <Left>  <Nop>
noremap  <Right> <Nop>

" command mode history search
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" -- Functions -----------------------------------------------------------------

" switch windows effortlessly
function! SwitchWindow(count)
	let l:current_buf = winbufnr(0)
	exe "buffer" . winbufnr(a:count)
	exe a:count . "wincmd w"
	exe "buffer" . l:current_buf
endfunction
nnoremap <Leader>wx :<C-u>call SwitchWindow(v:count1)<CR>

" redirect the output of a Vim or external command into a scratch buffer
function! Redir(cmd) abort
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

" create a temporary buffer with the output of the command `tree`
function! ViewTree() abort
	vertical topleft 30new
	setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
	0read !tree
	goto 1
endfunction
nnoremap <Leader>n :call ViewTree()<CR>

" copy yanked text to tmux pane
function! Send_to_tmux()
    let text = @z
    let text = substitute(text, ';', '\\;', 'g')
    let text = substitute(text, '"', '\\"', 'g')
    let text = substitute(text, '\n', '" Enter "', 'g')
    let text = substitute(text, '!', '\\!', 'g')
    let text = substitute(text, '%', '\\"', 'g')
    let text = substitute(text, '#', '\\#', 'g')
    execute "!tmux send-keys -t 1 " . "\"" . text . "\""
    execute "!tmux send-keys -t 1 Enter"
endfunction
nnoremap <silent> <leader>cc "zyip:call Send_to_tmux()<cr>
xnoremap <silent> <leader>cc "zy:call Send_to_tmux()<cr>

" use * and # over visual selection
function! s:VSetSearch(cmdtype)
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

" -- Autocommand ---------------------------------------------------------------

augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

augroup quickfix
    autocmd!
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
