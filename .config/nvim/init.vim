" Author: Enan Ajmain
" Email : 3nan.ajmain@gmail.com
" Github: https://github.com/enanajmain

" -- Vim Plug ------------------------------------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

call plug#end()

" -- General -------------------------------------------------------------------

" Visual perks
set colorcolumn=81
set conceallevel=0
let &fillchars="vert:│"
set nocursorline
set nolazyredraw
set nomodeline
set nonumber
set norelativenumber
set noruler
set showmode
set signcolumn=no

" New split position
set nosplitbelow
set nosplitright

" Dictionary and spelling
set dictionary=/usr/share/dict/words
set spelllang=en_us

" Searching
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan
if executable('ag')
	let &grepprg="ag --nogroup --nocolor --hidden --ignore .git"
endif

" Wildmenu settings
set wildmenu
set wildignorecase
let &wildmode="full"
set wildignore=*.o,*.obj,*~
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
set wrap
set breakindent
set linebreak
let &showbreak = "↪ "
set breakindentopt=shift:2

" Keymap timeout settings
set notimeout
set ttimeout
set ttimeoutlen=10

" Miscellaneous settings
let &inccommand="nosplit"
set backspace=indent,eol,start
set cinoptions=g0,l1,i0,t0,(0
set cpoptions-=aA
set shortmess=filmnxrtToO
set synmaxcol=200
set updatetime=250
set virtualedit=block
let &viewoptions="folds,cursor"
let g:tex_flavor='latex'

" Backup and Persistent Undo
set nobackup
set noswapfile
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
if has('persistent_undo')
	set undofile
	set undodir=~/.local/share/nvim/undo//
endif

" Colorscheme
syntax on
set termguicolors
colorscheme fault
let g:lisp_rainbow = 1

" -- Clipboard -----------------------------------------------------------------

let g:clipboard = {
			\   'name': 'xclip_neovim_clipboard',
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

" -- Tab settings --------------------------------------------------------------

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set shiftround
set expandtab

" -- Key Mapping ---------------------------------------------------------------

" Map leader
let mapleader = "\<Space>"

" Reload vimrc
nnoremap <silent> <Leader>r :so $MYVIMRC<CR>

" Don't change the registers for x
noremap x "_x

" Uppercase word in Insert-mode
inoremap <C-u> <Esc>m0gUiw`0a

" Consistent movement
noremap gh _
noremap gl $
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Don't move cursor when searching with * or #
nnoremap <silent> * :let _w = winsaveview()<CR>
			\:normal! *<CR>
			\:call winrestview(_w)<CR>
			\:unlet _w<CR>
nnoremap <silent> # :let _w = winsaveview()<CR>
			\:normal! #<CR>
			\:call winrestview(_w)<CR>
			\:unlet _w<CR>

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

" Useful leader mappings
nnoremap <Leader>; :
xnoremap <Leader>; :
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>f :grep<Space>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>s :%s/\v
xnoremap <Leader>s :s/\%V\v

" Opening files
nnoremap <Leader>e :e **/
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

" Don't move cursor when searching with * or #
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
command! -range=% Paste silent execute <line1> . "," . <line2> . "w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\\n' | xclip -selection clipboard"

" Repeatable window resize
function! RepeatResize(first)
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
	wincmd p
endfunction
nnoremap <Leader>wx :<C-u>call SwitchWindow(v:count1)<CR>

" Redirect the output of a Vim or external command into a scratch buffer
command! -nargs=1 Redir
            \ tabnew |
            \ setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile |
            \ call setline(1, split(execute(<q-args>), "\n"))

" Copy yanked text to tmux pane
function! Send_to_tmux(visual, count) range abort
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
nnoremap <Leader>p :<C-u>call Send_to_tmux(0, v:count1)<CR>
xnoremap <Leader>p :<C-u>call Send_to_tmux(1, v:count1)<CR>

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

" -- Autocommands --------------------------------------------------------------

augroup custom_term
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber
	autocmd TermOpen * setlocal bufhidden=hide signcolumn=no
	autocmd TermOpen,BufEnter term://* startinsert
augroup END

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost [^l]* nested cwindow
	autocmd QuickFixCmdPost    l* nested lwindow
augroup END

" -- Statusline ----------------------------------------------------------------

set laststatus=2
set statusline=%1*\ %{winnr()}
			\\ %2*\ %{&fileformat==#'unix'?'U':&fileformat==#'dos'?'D':'N'}
			\:%{&readonly\|\|!&modifiable?&modified?'%*':'%%':&modified?'**':'--'}
			\\ %0*\ %<%{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
			\%=
			\\ %2*\ %{&filetype!=#''?&filetype:'none'}
			\\ %1*\ %l:%4(%v\ %)

" Highlight commands need to be used with autocommands
" Otherwise, when manually changing colorschemes or syntax
" these highlight commands will fail to load
augroup statusline
	autocmd!
	autocmd VimEnter,ColorScheme * hi User1 guibg=#98c379 guifg=#282c34
	autocmd VimEnter,ColorScheme * hi User2 guibg=#c678dd guifg=#282c34
augroup END

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
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_cursor=0
let g:netrw_hide = 1
let g:netrw_list_hide = '^\./$,^\../$,^\.git/$'
let g:netrw_liststyle=0
let g:netrw_sort_by='name'
let g:netrw_sort_direction='normal'
let g:netrw_winsize=25
