" Theme: violet
" Author: ashfinal <ashfinal@gmail.com>
" License: MIT
" Origin: http://github.com/ashfinal/vim-colors-violet.git

hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name = "violet"

" Sets the highlighting for the given group
function! s:HL(group, fg, bg, attr)
    if !empty(a:fg)
        exec "hi " . a:group . " guifg=" . a:fg[0] . " ctermfg=" . a:fg[1]
    endif
    if !empty(a:bg)
        exec "hi " . a:group . " guibg=" . a:bg[0] . " ctermbg=" . a:bg[1]
    endif
    if a:attr != ""
        exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
    endif
endfunction

" Color Palette: {{{

let s:is_dark=(&background == 'dark')

let s:base03  = ['#25272a', '234']
let s:base02  = ['#292b2e', '235']
let s:base01  = ['#45484b', '238']
let s:base00  = ['#657b83', '66']
let s:base0   = ['#839496', '102']
let s:base1   = ['#e5e0d2', '251']
let s:base2   = ['#eee8d5', '253']
let s:base3   = ['#fdf6e3', '254']
let s:yellow  = ['#b58900', '136']
let s:orange  = ['#cb4b16', '166']
let s:red     = ['#dc322f', '196']
let s:magenta = ['#d33682', '168']
let s:violet  = ['#6c71c4', '62']
let s:blue    = ['#268bd2', '32']
let s:cyan    = ['#2aa198', '28']
let s:green   = ['#859900', '30']

if s:is_dark == 0 " LIGHT VARIANT
    let s:temp03 = s:base03
    let s:temp02 = s:base02
    let s:temp01 = s:base01
    let s:temp00 = s:base00
    let s:base03 = s:base3
    let s:base02 = s:base2
    let s:base01 = s:base1
    let s:base00 = s:base0
    let s:base0  = s:temp00
    let s:base1  = s:temp01
    let s:base2  = s:temp02
    let s:base3  = s:temp03
endif
" }}}

" Syntax Highlighting: {{{

" call s:HL("Normal", s:base0, s:base03, "")
hi clear Normal

" Switching between dark & light variant through `set background`
" https://github.com/NLKNguyen/papercolor-theme/pull/20
if s:is_dark " DARK VARIANT
    set background=dark
else " LIGHT VARIANT
    set background=light
endif

" Basic highlighting
call s:HL("Comment", s:base00, "", "")
call s:HL("Constant", s:cyan, "", "")
call s:HL("Identifier", s:blue, "", "")
call s:HL("Statement", s:green, "", "")
call s:HL("PreProc", s:orange, "", "")
call s:HL("Type", s:yellow, "", "")
call s:HL("Special", s:blue, "", "")
call s:HL("Underlined", s:violet, "", "")
call s:HL("Ignore", "", "", "")
call s:HL("Error", s:red, s:base03, "bold")
call s:HL("Todo", s:magenta, s:base03, "bold")

" Extended highlighting
call s:HL("SpecialKey", s:base00, s:base02, "bold")
call s:HL("NonText", s:base00, "", "")
" call s:HL("Visual", s:base03, s:cyan, "")
call s:HL("Visual", s:base0, s:base01, "")
call s:HL("Directory", s:blue, "", "")
call s:HL("IncSearch", s:orange, "", "")
call s:HL("Search", s:base03, s:yellow, "")
call s:HL("MoreMsg", s:blue, s:base03, "")
call s:HL("ModeMsg", s:blue, s:base03, "")
call s:HL("Question", s:cyan, "", "")
call s:HL("VertSplit", s:base01, s:base01, "")
call s:HL("Title", s:orange, "", "bold")
call s:HL("VisualNOS", "", s:base02, "")
call s:HL("Folded", s:base00, ["NONE","NONE"], "")
call s:HL("FoldColumn", s:base0, s:base03, "")
call s:HL("LineNr", s:base00, "", "")
call s:HL("SignColumn", s:base0, s:base03, "")
call s:HL("Conceal", s:blue, "", "")
call s:HL("CursorLine", "", s:base02, "NONE")
call s:HL("ColorColumn", "", s:base02, "")
call s:HL("Cursorcolumn", "", s:base02, "")
call s:HL("Cursor", s:base03, s:base0, "")
call s:HL("MatchParen", s:base03, s:base00, "")

call s:HL("ErrorMsg", s:red, s:base03, "")
call s:HL("WarningMsg", s:orange, s:base03, "")

call s:HL("DiffAdd", s:green, s:base01, "")
call s:HL("DiffChange", s:yellow, s:base01, "")
call s:HL("DiffDelete", s:red, s:base01, "")
call s:HL("DiffText", s:blue, s:base01, "")

call s:HL("StatusLine", s:base01, s:base0, "")
call s:HL("StatusLineNC", s:base01, s:base00, "")

call s:HL("TabLine", s:base0, s:base01, "NONE")
call s:HL("TabLineFill", s:base01, s:base0, "")
call s:HL("TabLineSel", s:base01, s:base0, "")

call s:HL("WildMenu", s:base01, s:base0, "")
call s:HL("Pmenu", s:base0, s:base01, "")
call s:HL("PmenuSel", s:base01, s:base0, "")
call s:HL("PmenuSbar", s:base01, s:base00, "")
call s:HL("PmenuThumb", s:base0, s:base0, "")

call s:HL("SpellBad", s:red, s:base03, "underline")
call s:HL("SpellCap", s:yellow, s:base03, "underline")
call s:HL("SpellLocal", s:base0, s:base03, "underline")
call s:HL("SpellRare", s:blue, s:base03, "underline")


" hl-user1..9 for statusline (mainly)
call s:HL("User1", s:red, s:base01, "bold")
call s:HL("User2", s:base01, s:cyan, "bold")


hi! link SpecialKey NonText

" }}}