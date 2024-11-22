" Vim color file
" Name   : Fault
" Author : Enan Ajmain
" Email  : 3nan.ajmain@gmail.com
" Github : https://github.com/3N4N

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

hi  ColorColumn   cterm=NONE  ctermbg=8     ctermfg=0  gui=NONE  guibg=#2c323c  guifg=NONE
hi  CursorColumn  cterm=NONE  ctermbg=8     ctermfg=0  gui=NONE  guibg=NONE     guifg=NONE
hi  CursorLineNr  cterm=NONE  ctermbg=NONE  ctermfg=1  gui=NONE  guibg=NONE     guifg=#e06c75
hi  Directory     cterm=NONE  ctermbg=NONE  ctermfg=4  GUI=NONE  guibg=NONE     guifg=#61afef
hi  Error         cterm=NONE  ctermbg=1     ctermfg=0  gui=NONE  guibg=#abb2bf  guifg=#282c34
hi  ErrorMsg      cterm=NONE  ctermbg=1     ctermfg=0  gui=NONE  guibg=NONE     guifg=#e06c75
hi  FoldColumn    cterm=NONE  ctermbg=NONE  ctermfg=7  gui=NONE  guibg=NONE     guifg=#61afef
hi  Folded        cterm=NONE  ctermbg=8     ctermfg=7  gui=NONE  guibg=#3e4452  guifg=NONE
hi  IncSearch     cterm=NONE  ctermbg=4     ctermfg=0  gui=NONE  guibg=#61afef  guifg=#282c34
hi  LineNr        cterm=NONE  ctermbg=NONE  ctermfg=8  gui=NONE  guibg=NONE     guifg=#d19a66
hi  ModeMsg       cterm=NONE  ctermbg=2     ctermfg=0  gui=NONE  guibg=NONE     guifg=#98c379
hi  MoreMsg       cterm=NONE  ctermbg=2     ctermfg=0  gui=NONE  guibg=NONE     guifg=#98c379
hi  NonText       cterm=NONE  ctermbg=NONE  ctermfg=8  gui=NONE  guibg=NONE     guifg=#5c6370
hi  Question      cterm=NONE  ctermbg=NONE  ctermfg=2  gui=NONE  guibg=NONE     guifg=#98c379
hi  Search        cterm=NONE  ctermbg=3     ctermfg=0  gui=NONE  guibg=#d19a66  guifg=#282c34
hi  SpecialKey    cterm=NONE  ctermbg=NONE  ctermfg=0  gui=NONE  guibg=NONE     guifg=#5c6370
hi  Title         cterm=NONE  ctermbg=NONE  ctermfg=5  gui=NONE  guibg=NONE     guifg=#c678dd
hi  Todo          cterm=NONE  ctermbg=3     ctermfg=0  gui=NONE  guibg=NONE     guifg=#e5c07b
hi  VertSplit     cterm=NONE  ctermbg=NONE  ctermfg=7  gui=NONE  guibg=NONE     guifg=#abb2bf
hi  Visual        cterm=NONE  ctermbg=7     ctermfg=0  gui=NONE  guibg=#abb2bf  guifg=#282c34
hi  WarningMsg    cterm=NONE  ctermbg=NONE  ctermfg=3  gui=NONE  guibg=NONE     guifg=#e5c07b
hi  WildMenu      cterm=NONE  ctermbg=2     ctermfg=0  gui=NONE  guibg=#98c379  guifg=#282c34

hi  CursorLine    cterm=underline  ctermbg=NONE  ctermfg=NONE  gui=NONE       guibg=NONE  guifg=NONE
hi  MatchParen    cterm=underline  ctermbg=6     ctermfg=0     gui=underline  guibg=NONE  guifg=#61afef
hi  QuickFixLine  cterm=underline  ctermbg=NONE  ctermfg=NONE  gui=underline  guibg=NONE  guifg=NONE

hi  clear  Normal
hi  clear  SignColumn

" -- Statusline and Tabline ----------------------------------------------------

hi  StatusLine    cterm=NONE  ctermbg=8     ctermfg=15  gui=NONE  guibg=#5c6370  guifg=#f0f0f0
hi  StatusLineNC  cterm=NONE  ctermbg=8     ctermfg=7   gui=NONE  guibg=#3e4452  guifg=#abb2bf
hi  TabLine       cterm=NONE  ctermbg=8     ctermfg=7   gui=NONE  guibg=#3e4452  guifg=#abb2bf
hi  TabLineFill   cterm=NONE  ctermbg=8     ctermfg=7   gui=NONE  guibg=#3e4452  guifg=#abb2bf
hi  TabLineSel    cterm=NONE  ctermbg=8     ctermfg=15  gui=NONE  guibg=#98c379  guifg=#282c34

" -- Language constructs -------------------------------------------------------

hi  Comment     cterm=NONE       ctermbg=NONE  ctermfg=8     gui=NONE       guibg=NONE  guifg=#56b6c2
hi  Underlined  cterm=underline  ctermbg=NONE  ctermfg=NONE  gui=underline  guibg=NONE  guifg=NONE

hi  clear  Constant
hi  clear  Function
hi  clear  Identifier
hi  clear  PreProc
hi  clear  Special
hi  clear  Statement
hi  clear  Type

" -- Completion menu -----------------------------------------------------------

hi  Pmenu       cterm=NONE  ctermbg=4  ctermfg=0  gui=NONE  guibg=#3e4452  guifg=NONE
hi  PmenuSbar   cterm=NONE  ctermbg=4  ctermfg=0  gui=NONE  guibg=#5c6d70  guifg=NONE
hi  PmenuSel    cterm=NONE  ctermbg=3  ctermfg=0  gui=NONE  guibg=#61afef  guifg=#282c34
hi  PmenuThumb  cterm=NONE  ctermbg=8  ctermfg=0  gui=NONE  guibg=#abb2bf  guifg=NONE

" -- Spelling ------------------------------------------------------------------

hi  SpellBad    cterm=underline  ctermbg=NONE  ctermfg=1  gui=underline  guibg=NONE  guifg=#e06c75
hi  SpellCap    cterm=underline  ctermbg=NONE  ctermfg=3  gui=underline  guibg=NONE  guifg=#e5c07b
hi  SpellLocal  cterm=underline  ctermbg=NONE  ctermfg=7  gui=underline  guibg=NONE  guifg=NONE
hi  SpellRare   cterm=underline  ctermbg=NONE  ctermfg=4  gui=underline  guibg=NONE  guifg=#61afef

" -- Diff ----------------------------------------------------------------------

hi  DiffAdd     cterm=NONE  ctermbg=NONE  ctermfg=2  gui=NONE  guibg=#282c34  guifg=#98c379
hi  DiffChange  cterm=NONE  ctermbg=NONE  ctermfg=3  gui=NONE  guibg=#282c34  guifg=#e5c07b
hi  DiffDelete  cterm=NONE  ctermbg=NONE  ctermfg=1  gui=NONE  guibg=#282c34  guifg=#e06c75
hi  DiffText    cterm=NONE  ctermbg=NONE  ctermfg=6  gui=NONE  guibg=#282c34  guifg=#61afef

" -- Gitgutter signs -----------------------------------------------------------

hi  GitGutterAdd     cterm=NONE  ctermbg=NONE  ctermfg=2  gui=NONE  guibg=NONE  guifg=#98c379
hi  GitGutterChange  cterm=NONE  ctermbg=NONE  ctermfg=3  gui=NONE  guibg=NONE  guifg=#e5c07b
hi  GitGutterDelete  cterm=NONE  ctermbg=NONE  ctermfg=1  gui=NONE  guibg=NONE  guifg=#e06c75

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
