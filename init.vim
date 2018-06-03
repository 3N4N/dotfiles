"             _
"  _ ____   _(_)_ __ ___
" | '_ \ \ / / | '_ ` _ \
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|
"

" ---- Vim Plug ------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'enanajmain/vim-fault'
Plug 'junegunn/vim-easy-align'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'

call plug#end()

" ---- Functions -----------------------

function! ToggleMouse() abort
  if &mouse==#""
    set mouse=n
    echo "mouse on"
  else
    set mouse=
    echo "mouse off"
  endif
endfunction

" customize the status report of <c-g>
function! Stats() abort
  let l:f = ''
  if expand('%:~:.')!=''
    let l:f = '"'.expand('%:~:.').'"'
  else
    let l:f = '[No Name]'
  endif
  let l:ft = ''
  if &filetype!=''
    let l:ft = ' -- ['.&filetype.']'
  else
    let l:ft = ' -- [none]'
  endif
  let l:l = ' -- Ln:'.line(".")
  let l:c = ' -- Col:'.col(".")
  let l:t = line('$')
  let l:m = ''
  let l:r = ''
  if &modified
    let l:m = ' -- [+]'
  endif
  if &readonly || !&modifiable
    let l:r = ' -- [RO]'
  endif
  if l:m!=#'' && l:r!=#''
    let l:m = ' -- [RO] [+]'
    let l:r = ''
  endif
  let l:g = ''
  if exists('g:loaded_fugitive') && fugitive#head()!=#''
    let l:g = ' @ '.fugitive#head()
  endif
  let l:p = ' -- '.line('.')*100/line('$').'%'
  return l:f.l:g.l:ft.l:m.l:r.l:p.l:l.'/'.l:t.l:c
endfunction
nnoremap <c-g> :echo Stats()<cr>

" strip the trailing whitespaces
function! StripTrailing() abort
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction
nnoremap <silent> <leader>as :call StripTrailing()<cr>

" search with visual mode
function! VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
xnoremap # :<C-u>call VSetSearch()<CR>??<CR><c-o>
xnoremap * :<C-u>call VSetSearch()<CR>//<CR><c-o>

" show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <C-S-P> :call <SID>SynStack()<CR>

" ---- General -------------------------

set colorcolumn=0         " colorize a column to show long lines
set conceallevel=0        " don't conceal anything
set fillchars=vert:│      " use unicode icon for vertical split
set nocursorline          " cursorline slows down vim
set noruler               " ruler removes column position from ctrl-g
set noswapfile            " don't use swap files
set number relativenumber " show hybrid line numbers
set shortmess=filmnxrtToO " shorten some messages
set signcolumn=yes        " always show sign column
set synmaxcol=200         " don't highlight after 200 columns
set updatetime=1000       " update after each 1s
set spelllang=en_us       " set language for spell checking
set splitbelow            " always split below
set splitright            " always split right
set showmode
set virtualedit+=block

" show useful visual icons
set list
set listchars=tab:▸\ ,trail:▫,nbsp:_,extends:»,precedes:«

" wrap lines visually
set nowrap
set linebreak
set showbreak=↳

set notimeout
set ttimeout
set ttimeoutlen=50

" ---- Clipboard -----------------------

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

" ---- Indentation ---------------------

set cinoptions=g0,l1,i0
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" ---- Autocommand ---------------------

augroup custom_term
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" ---- Wildmenu ------------------------

set wildmenu
set wildignorecase
set wildmode=full
set wildignore=*.o,*.obj,*~
set wildignore+=*.swp,*.tmp
set wildignore+=*.mp3,*.mp4,*mkv
set wildignore+=*.bmp,*.gif,*ico,*.jpg,*.png
set wildignore+=*.pdf,*.doc,*.docx,*.ppt,*.pptx
set wildignore+=*.rar,*.zip,*.tar,*.tar.gz,*.tar.xz

" ---- Key Mapping ---------------------

" map leader
let mapleader=" "

" reload vimrc
nnoremap <silent> <leader>r :so $MYVIMRC<cr>

" general
inoremap jj <esc>
nnoremap Y y$
nnoremap U <c-r>
nnoremap Q m0J`0

" don't move cursor while changing case
nnoremap gUiw m0gUiw`0
nnoremap guiw m0guiw`0

" very magic mode
nnoremap / /\v
xnoremap / /\v
nnoremap ? ?\v

" window management
nnoremap <leader>wz :tab split<cr>
nnoremap <leader>wp :pclose<cr>
nnoremap <leader>wa :b#<cr>
nnoremap <leader>wl :ls<cr>:b<space>

nnoremap <leader>wb <c-w>s
nnoremap <leader>wv <c-w>v
nnoremap <leader>wo <c-w>o
nnoremap <leader>wc <c-w>c
nnoremap <c-w>s <nop>
nnoremap <c-w>v <nop>
nnoremap <c-w>o <nop>
nnoremap <c-w>c <nop>

nnoremap <leader>w= <c-w>=
nnoremap <leader>w_ <c-w>_
nnoremap <leader>w<bar> <c-w><bar>
nnoremap <c-w>= <nop>
nnoremap <c-w>_ <nop>
nnoremap <c-w><bar> <nop>

nnoremap <leader>wH <c-w>H
nnoremap <leader>wJ <c-w>J
nnoremap <leader>wK <c-w>K
nnoremap <leader>wL <c-w>L
nnoremap <c-w>H <nop>
nnoremap <c-w>J <nop>
nnoremap <c-w>K <nop>
nnoremap <c-w>L <nop>

" better movement
nnoremap H ^
nnoremap L g_
nnoremap J L
nnoremap K H
xnoremap H ^
xnoremap L g_
xnoremap J L
xnoremap K H

" cycle argument files
nnoremap [a :prev<cr>
nnoremap ]a :next<cr>
nnoremap [A :first<cr>
nnoremap ]A :last<cr>

" cycle buffers
nnoremap [b :bprev<cr>
nnoremap ]b :bnext<cr>
nnoremap [B :bfirst<cr>
nnoremap ]B :blast<cr>

" cycle location list
nnoremap [l :lprev<cr>
nnoremap ]l :lnext<cr>
nnoremap [L :lfirst<cr>
nnoremap ]L :llast<cr>

" cycle quickfix list
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>

" cycle taglist
nnoremap [t :tprev<cr>
nnoremap ]t :tnext<cr>
nnoremap [T :tfirst<cr>
nnoremap ]T :tlast<cr>

" split resize
nnoremap <silent> <s-left> :vertical resize -3<CR>
nnoremap <silent> <s-right> :vertical resize +3<CR>
nnoremap <silent> <s-down> :resize -3<CR>
nnoremap <silent> <s-up> :resize +3<CR>

" toggle
nnoremap <silent> <leader>th :set hlsearch!<bar>set hlsearch?<cr>
nnoremap <silent> <leader>tm :call ToggleMouse()<cr>
nnoremap <silent> <leader>tp :set paste!<cr>
nnoremap <silent> <leader>ts :setlocal spell!<bar>setlocal spell?<cr>
nnoremap <silent> <leader>tt :term<cr>i<c-\><c-n>i
nnoremap <silent> <leader>tw :set wrap!<bar>set wrap?<cr>

" fzf
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>fg :GFiles<cr>
nnoremap <silent> <leader>fl :Buffers<cr>
nnoremap <silent> <leader>fc :Commands<cr>
nnoremap <silent> <leader>fa :Ag<cr>

" git
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gc :Gcommit<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>
nnoremap <silent> <leader>gr :Gread<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>hs :GitGutterStageHunk<cr>
nnoremap <silent> <leader>hu :GitGutterUndoHunk<cr>
nnoremap <silent> <leader>hp :GitGutterPreviewHunk<cr>

" terminal window navigation
tnoremap <esc> <c-\><c-n>
tnoremap <silent> <c-h> <c-\><c-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <c-j> <c-\><c-n>:TmuxNavigateDown<cr>
tnoremap <silent> <c-k> <c-\><c-n>:TmuxNavigateUp<cr>
tnoremap <silent> <c-l> <c-\><c-n>:TmuxNavigateRight<cr>

" easy-align
xmap ga <Plug>(EasyAlign)

" disable arrow keys
noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  <nop>
noremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" ---- text objects --------------------

let s:separators = exists('g:loaded_targets') ? [ '`', '%']
      \ : [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
for char in s:separators
  execute 'xnoremap i' . char . ' :<c-u>normal! T' . char . 'vt' . char . '<cr>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<cr>'
  execute 'xnoremap a' . char . ' :<c-u>normal! F' . char . 'vf' . char . '<cr>'
  execute 'onoremap a' . char . ' :normal va' . char . '<cr>'
endfor

" ---- Search --------------------------

set nohlsearch
set ignorecase
set smartcase

" ---- Colorscheme ---------------------

syntax on
colo fault
let g:lisp_rainbow = 1

" ---- Tabline -------------------------

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')
    let s .= '%' . tabnr . 'T'
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tabnr . ' '
    let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '
    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified | let s .= '✚ ' | endif
  endfor
  let s .= '%#TabLineFill#%=%999X'.' Tabs '
  return s
endfunction
set showtabline=1
set tabline=%!MyTabLine()

" ---- Statusline ----------------------
"

set laststatus=2
set statusline=%{&paste?'\ \ paste\ ':''}
      \\ %{&filetype!=#''?&filetype:'none'}\ 
      \\ %{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
      \%{&readonly?'\ \ ':!&modifiable?'\ \ ':''}
      \%{&modified?'\ \ ✚':''}
      \%=
      \%<\ %l/%L\ :\ %4(%c\ %)
      \%6(%p%%\ %)

" ---- Netrw ---------------------------

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

" ---- Ultisnips -----------------------

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir = "~/Git-repos/vim-snippets"
let g:UltiSnipsSnippetDirectories=[$HOME.'/Git-repos/vim-snippets']

" ---- Gitgutter -----------------------

set updatetime=250
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='┃'
let g:gitgutter_sign_removed_first_line='┃'
let g:gitgutter_sign_modified_removed='┃'
