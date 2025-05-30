" -- Windows Stuff ---------------------------------------------------------

if g:env == "CYGWIN"
  se ffs =dos,unix
  se enc =utf-8
endif

if g:env == "CYGWIN" || g:env == "WIN"
  nnoremap <silent>  <C-n>  :!start wt -d .<CR><CR>
  nnoremap <C-BS> <C-w>h
  call SetShell("cmd")
endif

if stridx(&shell,'cmd') > 0
  nnoremap <Leader>\ :term ++curwin ++close cmd /K C:/apps/clink/clink_x64.exe inject && C:/Users/enan/projects/dotfiles/cmd/profile.cmd<CR>
else
  nnoremap <Leader>\ :term ++curwin ++close<CR>
endif

" -- color scheme ----------------------------------------------------------

" Required by Vim to support 24-bit colors
if !has('nvim') && exists('+termguicolors')
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif

syntax off
set termguicolors
set background =light
colo dim

" -- cursor ----------------------------------------------------------------

" Required by Vim to change cursor shape according to the mode
" Needs to be defined /after/ termguicolors, bc that resets t_SI
if !has('nvim') && exists('+guicursor')
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[0 q"
endif

" -- register focus event --------------------------------------------------

if exists('+autoread')
  " 'autoread' depends on FocusGained autocmd event
  " Vim sets it only when &term=xterm
  " Gotta manually enable it for "st" and "tmux"
  " see ":h xterm-focus-event"
  if &term =~ '^st' || &term =~ '\v^(screen|tmux)'
    let &t_fe = "\<Esc>[?1004h"
    let &t_fd = "\<Esc>[?1004l"
  endif
endif

" -- bracketed paste  ------------------------------------------------------

if &term =~ '^st' || &term =~ '\v^(screen|tmux)'
  let &t_BE = "\e[?2004h"
  let &t_BD = "\e[?2004l"
  exec "set t_PS=\e[200~"
  exec "set t_PE=\e[201~"
endif

" -- visual perks ----------------------------------------------------------

set enc=utf-8
set colorcolumn =0
set conceallevel =0
set equalalways
set fillchars =vert:│
set hidden
set list
set listchars =tab:┆\ ,nbsp:_,extends:»,precedes:«
" set listchars+=leadmultispace:┆\ ,
set mouse =
set nocursorcolumn
set nocursorline
set nolazyredraw
set nomodeline
set nonumber
set norelativenumber
set noruler
set scrolloff =0
set showcmd
set showmode
set signcolumn =no

" -- line wrapping ---------------------------------------------------------

set nowrap
set breakindent
set linebreak
let &showbreak = '+++'

" -- folding ---------------------------------------------------------------

set foldcolumn =0
set foldmethod =manual

" -- new split position ----------------------------------------------------

set nosplitbelow
set nosplitright

" -- dictionary / spelling -------------------------------------------------

set dictionary =/usr/share/dict/words,~/AppData/Local/nvim/spell/american-english
set spelllang =en_us

" -- searching -------------------------------------------------------------

set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan
noh

" -- indenting -------------------------------------------------------------

set autoindent

" -- vimgrep ---------------------------------------------------------------

if executable('rg')
  " Use ripgrep
  " Must have $* in &gp for custom :Grep (see in plugin/user/functions.vim)
  " Even if it's unnecessary at the end for :grep
  let &grepprg = 'rg --smart-case --no-heading -Hn $*'
else
  " Use plain grep
  " Substitute args at $* before --exclude bc --exclude overrides --include
  let &grepprg = 'grep -IHnr $*
        \ --exclude-dir=.git
        \ --exclude-dir=node_modules
        \ --exclude-dir=.venv
        \ --exclude=tags'
end

" -- wildmenu settings -----------------------------------------------------

set wildmenu
set wildignorecase
set wildmode =full
set complete -=t
set wildignore +=*.o,*.obj,*~,*.class
set wildignore +=*/.git
set wildignore +=*/.env*,*/venv*,*/.venv*,*/*.egg-info,*/__pycache__/*
set wildignore +=*/node_modules/*
set wildignore +=*.swp,*.tmp
set wildignore +=*.mp3,*.mp4,*mkv
set wildignore +=*.bmp,*.gif,*ico,*.jpg,*.png
set wildignore +=*.pdf,*.doc,*.docx,*.ppt,*.pptx
set wildignore +=*.rar,*.zip,*.tar,*.tar.gz,*.tar.xz

" Relatively new features
silent! set wildoptions=pum

" -- keymap timeout settings -----------------------------------------------

set notimeout
set ttimeout
set ttimeoutlen =10

" -- diff options ----------------------------------------------------------

if has('mac') && $VIM == '/usr/share/vim'
  set diffopt-=internal
elseif has('patch-8.1.0360')
  set diffopt+=algorithm:patience
  set diffopt +=indent-heuristic
endif

" -- miscellaneous settings ------------------------------------------------

set autoread
set backspace =indent,eol,start
set belloff =all
set cinoptions =g0,l1,i0,t0,(4,N-s
set cpoptions -=aA
set formatoptions =tcqjro
set nojoinspaces
set shortmess =filmnxrtToO
set synmaxcol =200
set updatetime =250
set viewoptions =folds,cursor
set virtualedit =block

if exists('+pumblend') | set pumblend =0 | endif
if exists('+inccommand') | set inccommand =nosplit | endif

let g:R_assign = 2
let g:tex_flavor = "latex"
let html_my_rendering = 1

" -- backup / swap / undo --------------------------------------------------

set nobackup
set noswapfile
set undofile

let &backupdir = expand(g:vimdatadir . "/backup/")
let &directory = expand(g:vimdatadir . "/swap/")
let &undodir = expand(g:vimdatadir . "/undo/")

for d in [&backupdir, &directory, &undodir]
  if !isdirectory(d)
    call mkdir(&backupdir, 'p')
  endif
endfor

" -- tabs vs spaces --------------------------------------------------------

set smarttab
set shiftround
set expandtab

for tabstuff in ['tabstop', 'softtabstop', 'shiftwidth']
  execute "set " . tabstuff . "=2"
endfor

" -- Build -----------------------------------------------------------------

if g:env == 'WIN' || g:env == 'CYGWIN'
  if exists('$MSYSTEM') && stridx($MSYSTEM, 'MINGW') >= 0 || stridx($MSYSTEM,'UCRT') >= 0
    let &mp = 'mingw32-make'
  endif
endif

let g:cargo_makeprg_params = ''

" '%f:%l:%m' causes `make: *** [Makefile:23: a.out] Error 1' to be treated as error
" Remove it from 'errorformat'
let &efm = '%f(%l) \=: %t%*\D%n: %m,%*[^"]"%f"%*\D%l: %m,%f(%l) \=: %m,%*[^ ] %f %l: %m,%f:%l:%c:%m,%f(%l):%m,%f|%l| %m'

call LoadLocalVimrc()
