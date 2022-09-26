" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax on
set termguicolors
set background =light
colo violet


" -- visual perks ----------------------------------------------------------
set conceallevel =0
set nocursorcolumn
set nocursorline
set nolazyredraw
set nomodeline
set nonumber
set norelativenumber
set noruler
set showmode
set showcmd
set signcolumn =no
set colorcolumn =0
set fillchars =vert:│
set list
set listchars =tab:┆\ ,trail:▫,nbsp:_,extends:»,precedes:«
set guicursor =
set mouse =

" -- line wrapping ---------------------------------------------------------
set nowrap
set breakindent
set linebreak
let &showbreak = '↪ '

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
  set grepprg =rg\ --smart-case\ --vimgrep\ -g\ \"!tags\"
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
" set pumblend =0
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
set cpoptions -=aA
set nojoinspaces
" set inccommand =nosplit
set backspace =indent,eol,start
set cinoptions =g0,l1,i0,t0,(4,N-s
set shortmess =filmnxrtToO
set synmaxcol =200
set updatetime =250
set virtualedit =block
set viewoptions =folds,cursor
set formatoptions =tcqjro
set diffopt =internal
set diffopt +=internal
set diffopt +=filler
set diffopt +=closeoff
set diffopt +=algorithm:patience
set diffopt +=indent-heuristic
set clipboard ^=unnamedplus

let g:R_assign = 2
let g:tex_flavor = "latex"

" -- backup / swap / undo --------------------------------------------------

set nobackup
set noswapfile
set undofile

if g:env == "WIN"
  let &backupdir = expand("~/AppData/Local/vim/backup/")
  let &directory = expand("~/AppData/Local/vim/swap/")
  let &undodir = expand("~/AppData/Local/vim/undo/")
else
  let &backupdir = expand("~/.local/share/vim/backup//")
  let &directory = expand("~/.local/share/vim/swap//")
  let &undodir = expand("~/.local/share/vim/undo//")
end


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
