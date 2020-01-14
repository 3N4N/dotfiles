" Vim color file
" Name  : Fault
" Author: Enan Ajmain
" Email : 3nan.ajmain@gmail.com
" Github: https://github.com/enanajmain


hi clear
set background=dark
if exists("syntax_on")
	syntax reset
endif
let g:colors_name = "fault"


" +------------------------+  +------------------------+  +------------------------+
" |  Color Name  |   Hex   |  |  Color Name  |   Hex   |  |  Color Name  |   Hex   |
" |--------------+---------|  |--------------+---------|  |--------------+---------|
" | Black        | #282c34 |  | Cyan         | #56b6c2 |  | Light Grey   | #5c6370 |
" |--------------+---------|  |--------------+---------|  |--------------+---------|
" | Dark Red     | #be5046 |  | Blue         | #61afef |  | Dark Grey    | #2c323c |
" |--------------+---------|  |--------------+---------|  |--------------+---------|
" | Light Red    | #e06c75 |  | Magenta      | #c678dd |  | Mild Grey    | #3e4452 |
" |--------------+---------|  |--------------+---------|  +------------------------+
" | White        | #abb2bf |  | Green        | #98c379 |  | Dark Yellow  | #d19a66 |
" |--------------+---------|  |--------------+---------|  |--------------+---------|
" | Light White  | #f0f0f0 |  | Gutter Grey  | #5c6d70 |  | Light Yellow | #e5c07b |
" +--------------+---------+  +--------------+---------+  +------------------------+


" -- Editor settings -----------------------------------------------------------

hi  ColorColumn   cterm=none  ctermbg=8     ctermfg=0  gui=none  guibg=#2c323c  guifg=none
hi  CursorColumn  cterm=none  ctermbg=8     ctermfg=0  gui=none  guibg=none     guifg=none
hi  CursorLineNr  cterm=none  ctermbg=none  ctermfg=1  gui=none  guibg=none     guifg=#e06c75
hi  Directory     cterm=none  ctermbg=none  ctermfg=4  GUI=none  guibg=none     guifg=#61afef
hi  Error         cterm=none  ctermbg=1     ctermfg=0  gui=none  guibg=#abb2bf  guifg=#282c34
hi  ErrorMsg      cterm=none  ctermbg=1     ctermfg=0  gui=none  guibg=none     guifg=#e06c75
hi  FoldColumn    cterm=none  ctermbg=none  ctermfg=7  gui=none  guibg=none     guifg=#61afef
hi  Folded        cterm=none  ctermbg=8     ctermfg=7  gui=none  guibg=#3e4452  guifg=none
hi  IncSearch     cterm=none  ctermbg=4     ctermfg=0  gui=none  guibg=#61afef  guifg=#282c34
hi  LineNr        cterm=none  ctermbg=none  ctermfg=8  gui=none  guibg=none     guifg=#d19a66
hi  ModeMsg       cterm=none  ctermbg=2     ctermfg=0  gui=none  guibg=none     guifg=#98c379
hi  MoreMsg       cterm=none  ctermbg=2     ctermfg=0  gui=none  guibg=none     guifg=#98c379
hi  NonText       cterm=none  ctermbg=none  ctermfg=8  gui=none  guibg=none     guifg=#5c6370
hi  Question      cterm=none  ctermbg=none  ctermfg=2  gui=none  guibg=none     guifg=#98c379
hi  Search        cterm=none  ctermbg=3     ctermfg=0  gui=none  guibg=#d19a66  guifg=#282c34
hi  SpecialKey    cterm=none  ctermbg=none  ctermfg=0  gui=none  guibg=none     guifg=#5c6370
hi  Title         cterm=none  ctermbg=none  ctermfg=5  gui=none  guibg=none     guifg=#c678dd
hi  Todo          cterm=none  ctermbg=3     ctermfg=0  gui=none  guibg=none     guifg=#e5c07b
hi  VertSplit     cterm=none  ctermbg=none  ctermfg=7  gui=none  guibg=none     guifg=#abb2bf
hi  Visual        cterm=none  ctermbg=7     ctermfg=0  gui=none  guibg=#abb2bf  guifg=#282c34
hi  WarningMsg    cterm=none  ctermbg=none  ctermfg=3  gui=none  guibg=none     guifg=#e5c07b
hi  WildMenu      cterm=none  ctermbg=2     ctermfg=0  gui=none  guibg=#98c379  guifg=#282c34

hi  CursorLine    cterm=underline  ctermbg=none  ctermfg=none  gui=none       guibg=none  guifg=none
hi  MatchParen    cterm=underline  ctermbg=6     ctermfg=0     gui=underline  guibg=none  guifg=#61afef
hi  QuickFixLine  cterm=underline  ctermbg=none  ctermfg=none  gui=underline  guibg=none  guifg=none

hi  clear  Normal
hi  clear  SignColumn

" -- Statusline and Tabline ----------------------------------------------------

hi  StatusLine    cterm=none  ctermbg=8     ctermfg=15  gui=none  guibg=#5c6370  guifg=#f0f0f0
hi  StatusLineNC  cterm=none  ctermbg=8     ctermfg=7   gui=none  guibg=#3e4452  guifg=#abb2bf
hi  TabLine       cterm=none  ctermbg=none  ctermfg=7   gui=none  guibg=#3e4452  guifg=#abb2bf
hi  TabLineFill   cterm=none  ctermbg=none  ctermfg=0   gui=none  guibg=#3e4452  guifg=#abb2bf
hi  TabLineSel    cterm=none  ctermbg=8     ctermfg=15  gui=none  guibg=#98c379  guifg=#282c34

" -- Language constructs -------------------------------------------------------

hi  Comment     cterm=none       ctermbg=none  ctermfg=8     gui=none       guibg=none  guifg=#56b6c2
hi  Underlined  cterm=underline  ctermbg=none  ctermfg=none  gui=underline  guibg=none  guifg=none

hi  clear  Constant
hi  clear  Function
hi  clear  Identifier
hi  clear  PreProc
hi  clear  Special
hi  clear  Statement
hi  clear  Type

" -- Completion menu -----------------------------------------------------------

hi  Pmenu       cterm=none  ctermbg=4  ctermfg=0  gui=none  guibg=#3e4452  guifg=none
hi  PmenuSbar   cterm=none  ctermbg=4  ctermfg=0  gui=none  guibg=#5c6d70  guifg=none
hi  PmenuSel    cterm=none  ctermbg=3  ctermfg=0  gui=none  guibg=#61afef  guifg=#282c34
hi  PmenuThumb  cterm=none  ctermbg=8  ctermfg=0  gui=none  guibg=#abb2bf  guifg=none

" -- Spelling ------------------------------------------------------------------

hi  SpellBad    cterm=underline  ctermbg=none  ctermfg=1  gui=underline  guibg=none  guifg=#e06c75
hi  SpellCap    cterm=underline  ctermbg=none  ctermfg=3  gui=underline  guibg=none  guifg=#e5c07b
hi  SpellLocal  cterm=underline  ctermbg=none  ctermfg=7  gui=underline  guibg=none  guifg=none
hi  SpellRare   cterm=underline  ctermbg=none  ctermfg=4  gui=underline  guibg=none  guifg=#61afef

" -- Diff ----------------------------------------------------------------------

hi  DiffAdd     cterm=none  ctermbg=none  ctermfg=2  gui=none  guibg=#282c34  guifg=#98c379
hi  DiffChange  cterm=none  ctermbg=none  ctermfg=3  gui=none  guibg=#282c34  guifg=#e5c07b
hi  DiffDelete  cterm=none  ctermbg=none  ctermfg=1  gui=none  guibg=#282c34  guifg=#e06c75
hi  DiffText    cterm=none  ctermbg=none  ctermfg=6  gui=none  guibg=#282c34  guifg=#61afef

" -- Gitgutter signs -----------------------------------------------------------

hi  GitGutterAdd     cterm=none  ctermbg=none  ctermfg=2  gui=none  guibg=none  guifg=#98c379
hi  GitGutterChange  cterm=none  ctermbg=none  ctermfg=3  gui=none  guibg=none  guifg=#e5c07b
hi  GitGutterDelete  cterm=none  ctermbg=none  ctermfg=1  gui=none  guibg=none  guifg=#e06c75

hi link GitGutterChangeDelete GitGutterChange

" -- lisp_rainbow highlight ----------------------------------------------------

hi  def  hlLevel0  ctermfg=1  guifg=#e06c75
hi  def  hlLevel1  ctermfg=2  guifg=#e5c07b
hi  def  hlLevel2  ctermfg=3  guifg=#98c379
hi  def  hlLevel3  ctermfg=4  guifg=#61afef
hi  def  hlLevel4  ctermfg=5  guifg=#c678dd
hi  def  hlLevel5  ctermfg=1  guifg=#e06c75
hi  def  hlLevel6  ctermfg=2  guifg=#e5c07b
hi  def  hlLevel7  ctermfg=3  guifg=#98c379
hi  def  hlLevel8  ctermfg=4  guifg=#61afef
hi  def  hlLevel9  ctermfg=5  guifg=#c678dd

" -- Terminal colors -----------------------------------------------------------

" copied from https://github.com/joshdick/onedark.vim
" need to keep track of main terminal colorschemes

if has("nvim")
	let g:terminal_color_0 =  '#282c34'
	let g:terminal_color_1 =  '#e06c75'
	let g:terminal_color_2 =  '#98c379'
	let g:terminal_color_3 =  '#e5c07b'
	let g:terminal_color_4 =  '#61afef'
	let g:terminal_color_5 =  '#c678dd'
	let g:terminal_color_6 =  '#56b6c2'
	let g:terminal_color_7 =  '#abb2bf'
	let g:terminal_color_8 =  '#3e4452'
	let g:terminal_color_9 =  '#be5046'
	let g:terminal_color_10 = '#98c379' " No dark version
	let g:terminal_color_11 = '#d19a66'
	let g:terminal_color_12 = '#61afef' " No dark version
	let g:terminal_color_13 = '#c678dd' " No dark version
	let g:terminal_color_14 = '#56b6c2' " No dark version
	let g:terminal_color_15 = '#5c6370'
	let g:terminal_color_background = g:terminal_color_0
	let g:terminal_color_foreground = g:terminal_color_7
endif
