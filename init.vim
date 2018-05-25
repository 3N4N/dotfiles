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
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

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

function! StripTrailingWhitespaces() abort
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '': printf(
        \   ' %d  %d',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <silent> <C-S-P> :call SynStack()<CR>

" search with visual mode
function! VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
xnoremap # :<C-u>call VSetSearch()<CR>??<CR><c-o>
xnoremap * :<C-u>call VSetSearch()<CR>//<CR><c-o>

" ---- General -------------------------

"set secure
set colorcolumn=0
set completeopt=longest,menuone
set conceallevel=0
set encoding=utf-8
set fillchars+=vert:│
set linebreak
set list
set listchars=tab:>-,trail:▫,nbsp:_,extends:»,precedes:«
set nocursorline
set noswapfile
set nowrap
set number relativenumber
set path=**
set showbreak=↳
set showmode
set signcolumn=yes
set spelllang=en_us
set splitbelow
set splitright
set synmaxcol=200
set updatetime=1000
set virtualedit+=block

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

" ---- Completion ----------------------

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

" general
inoremap jj <esc>
nnoremap Y y$
nnoremap U <c-r>
nnoremap J m0J`0
nnoremap gUiw mzgUiw`z
nnoremap guiw mzguiw`z
nnoremap G Gzz
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <silent> <leader>r :so $MYVIMRC<cr>
nnoremap <silent> <f12> :call StripTrailingWhitespaces()<cr>

" very magic mode
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v

" window management
nnoremap <c-w>z :tab split<cr>
nnoremap <c-w>p :pclose<cr>
nnoremap <c-w>b <c-w>s
nnoremap <c-w>s <nop>

noremap <silent> <s-left> :vertical resize -3<CR>
noremap <silent> <s-right> :vertical resize +3<CR>
noremap <silent> <s-down> :resize -3<CR>
noremap <silent> <s-up> :resize +3<CR>

" toggle
nnoremap <silent> <leader>th :set hlsearch!<bar>set hlsearch?<cr>
nnoremap <silent> <leader>tm :call ToggleMouse()<cr>
nnoremap <silent> <leader>tp :set paste!<cr>
nnoremap <silent> <leader>ts :setlocal spell!<cr>
nnoremap <silent> <leader>tt :10split<bar>:term<cr>
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
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" vim-surround
let g:surround_no_mappings=1
nmap <leader>sc  <Plug>Csurround
nmap <leader>sd  <Plug>Dsurround
xmap <leader>ss  <Plug>VSurround

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
    if bufmodified | let s .= '[+] ' | endif
  endfor
  let s .= '%#TabLineFill#%=%999X'.' Tabs '
  return s
endfunction
set showtabline=1
set tabline=%!MyTabLine()

" ---- Statusline ----------------------
"

set laststatus=2
set statusline=%{&paste?'\ \ paste\ ':''}
set statusline+=\ %{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
set statusline+=%{&readonly?'\ \ ':!&modifiable?'\ \ ':''}\ 
set statusline+=%{exists('g:loaded_fugitive')?(fugitive#head()!=#''?'\ \ '.fugitive#head().'\ ':''):''}
set statusline+=%=
set statusline+=%{&modified?'\ \ [+]':''}
set statusline+=%=
set statusline+=%{exists('g:loaded_ale')?(LinterStatus()!=#''?'\ '.LinterStatus().'\ ':''):''}
set statusline+=%<\ %{&filetype!=#''?&filetype:'none'}
set statusline+=\ %6(\ %p%%\ %)

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
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = "~/Git-repos/vim-snippets"
let g:UltiSnipsSnippetDirectories=[$HOME.'/Git-repos/vim-snippets']

" ---- Gitgutter -----------------------

set updatetime=250
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='┃'
let g:gitgutter_sign_removed_first_line='┃'
let g:gitgutter_sign_modified_removed='┃'

hi GitGutterAdd       cterm=NONE    ctermbg=NONE    ctermfg=green       gui=NONE    guibg=NONE    guifg=lightgreen
hi GitGutterChange    cterm=NONE    ctermbg=NONE    ctermfg=yellow      gui=NONE    guibg=NONE    guifg=yellow
hi GitGutterDelete    cterm=NONE    ctermbg=NONE    ctermfg=red         gui=NONE    guibg=NONE    guifg=#df5f5f

" ---- Ale Linter ----------------------

let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_highlights = 0
let g:ale_sign_warning = ''
let g:ale_sign_error = ''
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 8
exec 'hi ALEErrorSign guifg=#EC5f67 ctermfg=red guibg=none ctermbg=none'
exec 'hi ALEWarningSign guifg=yellow ctermfg=yellow guibg=none ctermbg=none'
