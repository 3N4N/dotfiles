" Author : Enan Ajmain
" Email  : 3nan.ajmain@gmail.com
" Github : https://github.com/3N4N


if !exists('g:env')
  if has('wsl')
    let g:env = 'WSL'
  elseif has('win32')
    let g:env = 'WIN'
  else
    let g:env = 'UNIX'
  endif
endif

if g:env ==# 'WIN'
  if has('nvim')
    let g:vimconfdir = expand('~/AppData/Local/nvim')
    let g:vimdatadir = expand('~/AppData/Local/nvim-data')
  else
    let g:vimconfdir = expand('~/vimfiles')
    let g:vimdatadir = expand('~/AppData/Local/vim-data')
  endif
else
  if has('nvim')
    let g:vimconfdir = expand('~/.local/share/nvim')
    let g:vimdatadir = expand('~/.local/share/nvim-data')
  else
    let g:vimconfdir = expand('~/.vim')
    let g:vimdatadir = expand('~/.local/share/vim-data')
  endif
endif

let s:vim_plug_dir = expand(g:vimconfdir . '/plugged')


" -- Vim Plug --------------------------------------------------------------

let plug_vim = expand(g:vimconfdir . '/autoload/plug.vim')
if empty(glob(plug_vim))
  call system('curl -fLo ' . plug_vim
        \ . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:plug_url_format = 'git@github.com:%s.git'

call plug#begin(s:vim_plug_dir)

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'

Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'luochen1990/rainbow'
Plug 'junegunn/vim-easy-align'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

Plug 'mcchrish/fountain.vim'
Plug 'benknoble/gitignore-vim'
Plug 'rust-lang/rust.vim'
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()


" -- Load Local Vimrc ------------------------------------------------------

function! LoadLocalVimrc() abort
  let files = ['local.vim', '.local.vim']
  for file in files
    if filereadable(file)
      execute "source " . file
    endif
  endfor
endfunction
call LoadLocalVimrc()


" -- source user plugins --------------------------------------------------

runtime plugin/user/functions.vim
runtime plugin/user/options.vim
runtime plugin/user/statusline.vim
runtime plugin/user/plugins.vim


" -- lua config ------------------------------------------------------------

if has('nvim')
  lua require('user.plugins')
  " lua require('user.lspconfig')
endif


" -- Key Mapping -----------------------------------------------------------

" Reload vimrc
nnoremap <silent> <Leader>r :so $MYVIMRC<CR>

" Camelcase is bullshit
cabbrev cmakefile CMakeLists.txt

" Uppercase word in Insert-mode
inoremap <C-u> <Esc>m0gUiw`0a

if !has('nvim') && g:env ==# 'WIN'
  " in Conhost, <C-x> in visual mode deletes text (documented behaviour)
  xnoremap <C-x> <C-x>
endif

" Consistent movement
noremap gh ^
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
nnoremap <C-w><C-]> <C-w>g<C-]>

" Useful leader mappings
nnoremap <Leader>; :
xnoremap <Leader>; :
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Bslash>f :Grep<Space>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>s :%s:\v
xnoremap <Leader>s :s:\%V\v

" Go in and out of diffmode
nnoremap <Leader>dt :windo diffthis<CR>
nnoremap <Leader>do :windo diffoff<CR>

" Opening files
nnoremap <Leader>e :e **/*
nnoremap <Leader>E :e .*/**/*<Left><Left><Left><Left><Left><Left>
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
nnoremap <Leader>ww :vert res 100<CR>

" Switch tabpages
nnoremap ) gt
nnoremap ( gT

" Handy bracket mappings
let s:pairs = { 'a' : '', 'b' : 'b', 'l' : 'l', 'q' : 'c', 't' : 't' }
for [s:key, s:value] in items(s:pairs)
  execute 'nnoremap <silent> [' . s:key . ' :' . s:value . 'prev<CR>'
  execute 'nnoremap <silent> ]' . s:key . ' :' . s:value . 'next<CR>'
  execute 'nnoremap <silent> [' . toupper(s:key) . ' :' . s:value . 'first<CR>'
  execute 'nnoremap <silent> ]' . toupper(s:key) . ' :' . s:value . 'last<CR>'
endfor

" Toggle
nnoremap <silent> <Leader>tc :let &colorcolumn=(&cc==0)?81:0<CR>
nnoremap <silent> <Leader>te :set expandtab!<Bar>set expandtab?<CR>
nnoremap <silent> <Leader>tg :set termguicolors!<Bar>set termguicolors?<CR>
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
nnoremap <Leader>gs :keepalt Git<CR>
nnoremap <Leader>gd :keepalt Gdiffsplit<CR>
nnoremap <Leader>gc :keepalt Git commit<CR>
nnoremap <Leader>gw :keepalt Gwrite<CR>
nnoremap <Leader>gr :keepalt Gread<CR>
nnoremap <Leader>gb :keepalt Git blame<CR>
nnoremap <Leader>gg :keepalt Git grep ''<Left>

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


" -- Text Objects ----------------------------------------------------------

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


" -- Functions and Commands ------------------------------------------------

" Lua utilities
command! -nargs=1 Inspect lua print(vim.inspect(<args>))

" Send selected text to a pastebin
command! -range=% Paste
      \ execute <line1> . "," . <line2>
      \ . "w !curl -F \"sprunge=<-\" http://sprunge.us | tr -d '\\n' | "
      \ . (g:env=="UNIX" ? "xclip -selection clipboard" : "win32yank.exe -i")

" Redirect the output of a Vim or external command into a scratch buffer
command! -nargs=1 -complete=command Redir
      \ tabnew |
      \ setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile |
      \ call setline(1, split(execute(<q-args>), "\n"))

command! Date put =strftime('%Y-%m-%d')
command! SetMarkdownComments
      \ setlocal comments ^=fb:[],fb:[\ ],fb:[x],fb:[X],fb:*,fb:-,fb:+,fb:o,fb:•,n:>
" setlocal comments=b:[],b:[\ ],b:[x],b:[X],b:*,b:-,b:+,b:o,n:>

command! -nargs=1 -complete=function Echopy
      \ let output = expand(<args>) |
      \ echo output |
      \ let @* = output |
      \ unlet output

command! -nargs=1 SetTabsize
      \ set tabstop=<args> |
      \ set softtabstop=<args> |
      \ set shiftwidth=<args>

command! -nargs=1 -complete=help H tab help <args>

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


" -- Autocommands ----------------------------------------------------------

if exists('##TermOpen')
  augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * setlocal bufhidden=hide signcolumn=no
    " autocmd BufEnter term://* startinsert
  augroup END
endif

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
augroup END

" augroup resize_splits
"     au!
"     au VimResized * wincmd =
" augroup END

if exists('##TextYankPost')
  augroup highlight_yank
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank{on_visual=false}
  augroup END
endif


" -- Title -----------------------------------------------------------------

set title
let &titlestring = (has('nvim') ? "NVIM" : "VIM") . " %{&modified?'•':'-'}
      \ %{getcwd()->fnamemodify(':~')}"


" -- Ctags -----------------------------------------------------------------

nnoremap <Leader>c :!ctags -R --exclude=.git --exclude=build --exclude=venv .<CR>


" -- Uncrustify ------------------------------------------------------------

let g:uncrustifyCfgFile = expand("$HOME/.uncrustify.cfg")

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

if !empty(findfile('src/uncrustify.cfg', ';'))
  let &formatprg = 'uncrustify -q -l C -c src/uncrustify.cfg --no-backup'
endif


" -- Easy Align ------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" -- OSCYank ---------------------------------------------------------------

let g:oscyank_max_length = 0  " maximum length of a selection
let g:oscyank_silent     = 1  " disable message on successful copy
let g:oscyank_trim       = 0  " trim surrounding whitespaces before copy
let g:oscyank_osc52      = "\x1b]52;c;%s\x07"  " the OSC52 format string to use

if !has('nvim') && g:env ==# 'WIN'
  " vim-oscyank plugin doesn't work in Windows
  " Fall back on win32 clipboard
  nnoremap <silent>   <leader>y     "+y
  nnoremap <silent>   <leader>yy    "+yy
  xnoremap <silent>   <C-c>         "+y
else
  nnoremap <silent>   <leader>y     <Plug>OSCYankOperator
  nnoremap <silent>   <leader>yy    <Plug>OSCYankOperator_
  xnoremap <silent>   <C-c>         <Plug>OSCYankVisual
endif

" -- Lua Modules -----------------------------------------------------------

nnoremap <Bslash>P :let g:termutilchan=eval(b:terminal_job_id)<CR>
nnoremap <silent><Bslash>p :lua require("termutil").sendToTerm(0)<CR>
xnoremap <silent><Bslash>p :lua require("termutil").sendToTerm(1)<CR>

call LoadLocalVimrc()
