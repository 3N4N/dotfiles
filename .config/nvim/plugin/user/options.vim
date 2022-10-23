if !has('nvim') && exists('+termguicolors')
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif

syntax off
set notermguicolors
set background =light
colo dim

" -- visual perks ----------------------------------------------------------
set colorcolumn =0
set conceallevel =0
set fillchars =vert:│
set guicursor =n-v-c-sm:block-blinkon0,i-ci-ve:ver25-blinkon0,r-cr-o:hor20-blinkon0
set hidden
set list
set listchars =tab:┆\ ,trail:▫,nbsp:_,extends:»,precedes:«
set mouse =
set nocursorcolumn
set nocursorline
set nolazyredraw
set nomodeline
set nonumber
set norelativenumber
set noruler
set showmode
set signcolumn =no

" -- line wrapping ---------------------------------------------------------
set nowrap
set breakindent
set linebreak
let &showbreak = '+++ '

" -- folding ---------------------------------------------------------------
set foldcolumn =0
set foldmethod =manual

" -- new split position ----------------------------------------------------
set nosplitbelow
set nosplitright

" -- dictionary / spelling -------------------------------------------------
set dictionary =/usr/share/dict/words,~/AppData/Local/nvim/spell/american-english
set spelllang =en_us

" -- set default shell in win32 --------------------------------------------
if g:env == "WIN"
  let shell = "pwsh"
  call SetShell(shell)
  unlet shell
end

" -- searching -------------------------------------------------------------
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan
noh

" -- vimgrep ---------------------------------------------------------------
if executable('rg')
  " use ripgrep
  set grepprg =rg\ --smart-case\ --vimgrep\ -g\ \"!tags\"\ -g\ \"!build\"\ -g\ \"!release\"\ -g\ \"!po\"
else
  " use plain grep
  if g:env == 'WIN'
    set grepprg =grep\ -IHnri\ --exclude-dir=.git\ --exclude-dir=node_modules\ --exclude=\"tags\"
  else
    set grepprg =grep\ -IHnri\ --exclude-dir={.git,node_modules}\ --exclude=\"tags\"
  end
end

" -- wildmenu settings -----------------------------------------------------
set wildmenu
set wildignorecase
set wildmode =full
set wildoptions =pum
set complete -=t
set wildignore +=*.o,*.obj,*~,*.class
set wildignore +=*/.git
set wildignore +=*.swp,*.tmp
set wildignore +=*.mp3,*.mp4,*mkv
set wildignore +=*.bmp,*.gif,*ico,*.jpg,*.png
set wildignore +=*.pdf,*.doc,*.docx,*.ppt,*.pptx
set wildignore +=*.rar,*.zip,*.tar,*.tar.gz,*.tar.xz

" -- keymap timeout settings -----------------------------------------------
set notimeout
set ttimeout
set ttimeoutlen =10

" -- miscellaneous settings ------------------------------------------------

set autoread
set backspace =indent,eol,start
set cinoptions =g0,l1,i0,t0,(4,N-s
set cpoptions -=aA
set diffopt =internal
set diffopt +=filler
set diffopt +=closeoff
set diffopt +=algorithm:patience
set diffopt +=indent-heuristic
set formatoptions =tcqjro
set nojoinspaces
set shortmess =filmnxrtToO
set synmaxcol =200
set updatetime =250
set viewoptions =folds,cursor
set virtualedit =block

if exists('+pumblend') | set pumblend =0 | endif
if exists('+inccommand') | set inccommand =nosplit | endif

let mapleader = "\<Space>"
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


" -- tabs vs spaces --------------------------------------------------------

set smarttab
set shiftround
set expandtab

for tabstuff in ['tabstop', 'softtabstop', 'shiftwidth']
  execute "set " . tabstuff . "=2"
endfor


" -- make ------------------------------------------------------------------
if isdirectory("build")
  set makeprg =make\ -C\ build
  set makeprg =ninja\ -C\ build
else
  set makeprg =make
end

call LoadLocalVimrc()
