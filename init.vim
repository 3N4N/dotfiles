"             _
"  _ ____   _(_)_ __ ___
" | '_ \ \ / / | '_ ` _ \
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|
"

" ---- Vim Plug ------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'enanajmain/vim-fault'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'

call plug#end()

" ---- General -------------------------

set colorcolumn=81        " colorize a column to show long lines
set conceallevel=0        " don't conceal anything
set fillchars=vert:│      " use unicode icon for vertical split
set nocursorline          " cursorline slows down vim
set nolazyredraw          " redraw screen
set noruler               " ruler removes column position from ctrl-g
set noswapfile            " don't use swap files
set number relativenumber " show hybrid line numbers
set shortmess=filmnxrtToO " shorten some messages
set showmode              " show current mode at the bottom
set signcolumn=yes        " always show sign column
set spelllang=en_us       " set language for spell checking
set splitbelow            " always split below
set splitright            " always split right
set synmaxcol=200         " don't highlight after 200 columns
set updatetime=250        " update after each 0.25s
set virtualedit=block     " select empty spaces in visual-block mode

" show useful visual icons
set list
set listchars=tab:▸\ ,trail:▫,nbsp:_,extends:»,precedes:«

" wrap lines visually
set nowrap
set linebreak
set showbreak=↳

" keymap timeout settings
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
let mapleader = "\<Space>"

" reload vimrc
nnoremap <silent> <leader>r :so $MYVIMRC<cr>

" escape with double tapping j in insert mode
inoremap jj <esc>

" sensible yank til last character
nnoremap Y y$

" undo with <S-u>
nnoremap U <c-r>

" goto buffer
nnoremap gb :ls<cr>:b<space>

" strip trailing whitespaces
nnoremap <silent> gs :let _w=winsaveview() <bar>
      \:let _s=@/ <bar>
      \:%s/\s\+$//e <bar>
      \:let @/=_s<bar>
      \:unlet _s <bar>
      \:call winrestview(_w) <bar>
      \:unlet _w <cr>

" don't move cursor while joining lines
nnoremap J m0J`0

" don't move cursor while changing case
nnoremap gUiw m0gUiw`0
nnoremap guiw m0guiw`0

" very magic mode
nnoremap / /\v
xnoremap / /\v
nnoremap ? ?\v

" better window management
nnoremap <leader>wt :tab split<cr>
nnoremap <leader>wa :b#<cr>
nnoremap <leader>wb <c-w>s
nnoremap <leader>ws <nop>
nnoremap <leader>w <c-w>
nnoremap <c-w> <nop>

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

" toggle
nnoremap <silent> <leader>th :set hlsearch!<bar>set hlsearch?<cr>
nnoremap <silent> <leader>tp :set paste!<bar>set paste?<cr>
nnoremap <silent> <leader>ts :setlocal spell!<bar>setlocal spell?<cr>
nnoremap <silent> <leader>tw :set wrap!<bar>set wrap?<cr>
nnoremap <silent> <leader>tm :let &mouse=(&mouse==#""?"a":"")<bar>
      \echo "mouse ".(&mouse==#""?"off":"on")<cr>

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

" Navigate seamlessly between vim and tmux
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
  tnoremap <silent> <c-h> <c-\><c-n>:call TmuxOrSplitSwitch('h', 'L')<cr>
  tnoremap <silent> <c-j> <c-\><c-n>:call TmuxOrSplitSwitch('j', 'D')<cr>
  tnoremap <silent> <c-k> <c-\><c-n>:call TmuxOrSplitSwitch('k', 'U')<cr>
  tnoremap <silent> <c-l> <c-\><c-n>:call TmuxOrSplitSwitch('l', 'R')<cr>
else
  nnoremap <c-h> <c-w>h
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
  nnoremap <c-l> <c-w>l
  tnoremap <c-h> <c-\><c-n><c-w>h
  tnoremap <c-j> <c-\><c-n><c-w>j
  tnoremap <c-k> <c-\><c-n><c-w>k
  tnoremap <c-l> <c-\><c-n><c-w>l
endif

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

set ignorecase
set smartcase

" use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ---- Colorscheme ---------------------

syntax on
set termguicolors
colo fault
let g:lisp_rainbow = 1

" ---- Statusline ----------------------

set laststatus=2
set statusline=
      \\ %{&filetype!=#''?&filetype:'none'}
      \\ %{&readonly\|\|!&modifiable?&modified?'%*':'%%':&modified?'**':'--'}
      \\ %{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
      \%=
      \%<\ C%v%3(%)L%l/%L%2(%)
      \%6(%p%%\ %)


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
let g:UltiSnipsSnippetsDir = "~/projects/vim-snippets"
let g:UltiSnipsSnippetDirectories=[$HOME.'/projects/vim-snippets']

" ---- Gitgutter -----------------------

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='┃'
let g:gitgutter_sign_removed_first_line='┃'
let g:gitgutter_sign_modified_removed='┃'
