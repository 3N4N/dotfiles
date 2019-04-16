" Vim color file
" Name  : Fault
" Author: Enan Ajmain
" Email : 3nan.ajmain@gmail.com
" Github: https://github.com/enanajmain


hi clear
set background=light
if exists("syntax_on")
	syntax reset
endif
let g:colors_name = "fault"


" +------------------------+  +------------------------+
" |  Color Name  |   Hex   |  |  Color Name  |   Hex   |
" |--------------+---------|  |--------------+---------|
" | Black        | #282c34 |  | Cyan         | #56b6c2 |
" |--------------+---------|  |--------------+---------|
" | Green        | #98c379 |  | Blue         | #61afef |
" |--------------+---------|  |--------------+---------|
" | White        | #abb2bf |  | Magenta      | #c678dd |
" |--------------+---------|  |--------------+---------|
" | LightWhite   | #f0f0f0 |  | Green        | #98c379 |
" |--------------+---------|  |--------------+---------|
" | Light Red    | #e06c75 |  | Gutter Grey  | #5c6d70 |
" |--------------+---------|  |--------------+---------|
" | Dark Red     | #be5046 |  | Light Grey   | #5c6370 |
" |--------------+---------|  |--------------+---------|
" | Light Yellow | #e5c07b |  | Dark Grey    | #2c323c |
" |--------------+---------|  |--------------+---------|
" | Dark Yellow  | #d19a66 |  | Mild Grey    | #3e4452 |
" +------------------------+  +------------------------+


" -- Editor settings -----------------------------------------------------------

hi ColorColumn    gui=NONE          guibg=#2c323c       guifg=NONE
hi CursorColumn   gui=NONE          guibg=NONE          guifg=NONE
hi CursorLine     gui=NONE          guibg=NONE          guifg=NONE
hi CursorLineNr   gui=NONE          guibg=NONE          guifg=#e06c75
hi Directory      gui=NONE          guibg=NONE          guifg=#61afef
hi Error          gui=NONE          guibg=#abb2bf       guifg=#282c34
hi ErrorMsg       gui=NONE          guibg=NONE          guifg=#e06c75
hi FoldColumn     gui=NONE          guibg=NONE          guifg=#61afef
hi Folded         gui=NONE          guibg=#3e4452       guifg=NONE
hi IncSearch      gui=NONE          guibg=#61afef       guifg=#282c34
hi LineNr         gui=NONE          guibg=NONE          guifg=#d19a66
hi MatchParen     gui=underline     guibg=NONE          guifg=#61afef
hi ModeMsg        gui=NONE          guibg=NONE          guifg=#98c379
hi MoreMsg        gui=NONE          guibg=NONE          guifg=#98c379
hi NonText        gui=NONE          guibg=NONE          guifg=#5c6370
hi Question       gui=NONE          guibg=NONE          guifg=#98c379
hi QuickFixLine   gui=underline     guibg=NONE          guifg=NONE
hi Search         gui=NONE          guibg=#d19a66       guifg=#282c34
hi SpecialKey     gui=NONE          guibg=NONE          guifg=#5c6370
hi StatusLine     gui=NONE          guibg=#5c6370       guifg=#f0f0f0
hi StatusLineNC   gui=NONE          guibg=#3e4452       guifg=#abb2bf
hi TabLine        gui=NONE          guibg=#3e4452       guifg=#abb2bf
hi TabLineFill    gui=NONE          guibg=#3e4452       guifg=#abb2bf
hi TabLineSel     gui=NONE          guibg=#98c379       guifg=#282c34
hi Title          gui=NONE          guibg=NONE          guifg=#c678dd
hi Todo           gui=NONE          guibg=NONE          guifg=#e5c07b
hi VertSplit      gui=NONE          guibg=NONE          guifg=#abb2bf
hi Visual         gui=NONE          guibg=#abb2bf       guifg=#282c34
hi WarningMsg     gui=NONE          guibg=NONE          guifg=#e5c07b
hi WildMenu       gui=NONE          guibg=#98c379       guifg=#282c34

hi clear Normal
hi clear SignColumn

" -- Language constructs -------------------------------------------------------

hi Comment      gui=NONE        guibg=NONE   guifg=#56b6c2
hi Underlined   gui=underline   guibg=NONE   guifg=NONE

hi clear Constant
hi clear Function
hi clear Identifier
hi clear PreProc
hi clear Special
hi clear Statement
hi clear Type

" -- Completion menu -----------------------------------------------------------

hi Pmenu        gui=NONE   guibg=#3e4452   guifg=NONE
hi PmenuSbar    gui=NONE   guibg=#5c6d70   guifg=NONE
hi PmenuSel     gui=NONE   guibg=#61afef   guifg=#282c34
hi PmenuThumb   gui=NONE   guibg=#abb2bf   guifg=NONE

" -- Spelling ------------------------------------------------------------------

hi SpellBad     gui=underline   guibg=NONE   guifg=#e06c75
hi SpellCap     gui=underline   guibg=NONE   guifg=#e5c07b
hi SpellLocal   gui=underline   guibg=NONE   guifg=NONE
hi SpellRare    gui=underline   guibg=NONE   guifg=#61afef

" -- Diff ----------------------------------------------------------------------

hi DiffAdd      gui=NONE   guibg=#282c34   guifg=#98c379
hi DiffChange   gui=NONE   guibg=#282c34   guifg=#e5c07b
hi DiffDelete   gui=NONE   guibg=#282c34   guifg=#e06c75
hi DiffText     gui=NONE   guibg=#282c34   guifg=#61afef

" -- Gitgutter signs -----------------------------------------------------------

hi GitGutterAdd      gui=NONE   guibg=NONE   guifg=#98c379
hi GitGutterChange   gui=NONE   guibg=NONE   guifg=#e5c07b
hi GitGutterDelete   gui=NONE   guibg=NONE   guifg=#e06c75
hi link GitGutterChangeDelete GitGutterChange

" -- lisp_rainbow highlight ----------------------------------------------------

hi def hlLevel0  guifg=#e06c75
hi def hlLevel1  guifg=#e5c07b
hi def hlLevel2  guifg=#98c379
hi def hlLevel3  guifg=#61afef
hi def hlLevel4  guifg=#c678dd
hi def hlLevel5  guifg=#e06c75
hi def hlLevel6  guifg=#e5c07b
hi def hlLevel7  guifg=#98c379
hi def hlLevel8  guifg=#61afef
hi def hlLevel9  guifg=#c678dd

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
