hi clear

if exists("syntax_on")
  syntax reset
endif

hi SpecialKey     ctermfg=4
hi TermCursor     cterm=reverse
hi NonText        ctermfg=12
hi Directory      ctermfg=4
hi ErrorMsg       ctermfg=15 ctermbg=1
hi IncSearch      cterm=reverse
hi MoreMsg        ctermfg=2
hi ModeMsg        cterm=bold
hi Question       ctermfg=2
hi Title          ctermfg=5
hi WarningMsg     ctermfg=1
hi WildMenu       ctermfg=0 ctermbg=11
hi Conceal        ctermfg=7 ctermbg=7
hi SpellBad       ctermbg=9
hi SpellRare      ctermbg=13
hi SpellLocal     ctermbg=14
hi PmenuSbar      ctermbg=8
hi PmenuThumb     ctermbg=0
hi TabLine        ctermfg=7 ctermbg=0
hi TabLineSel     ctermbg=14
hi TabLineFill    ctermbg=7
hi CursorColumn   ctermbg=7
hi CursorLine     cterm=underline
hi MatchParen     ctermbg=14
hi Constant       ctermfg=1
hi Special        ctermfg=5
hi Identifier     cterm=NONE ctermfg=6
hi Statement      ctermfg=3
hi PreProc        ctermfg=5
hi Type           ctermfg=2
hi Underlined     cterm=underline ctermfg=5
hi Ignore         ctermfg=15
hi Error          ctermfg=15 ctermbg=9
hi Todo           ctermfg=0 ctermbg=11

let colors_name = "dim"

" In diffs, added lines are green, changed lines are yellow, deleted lines are
" red, and changed text (within a changed line) is bright yellow and bold.
hi DiffAdd        ctermfg=0    ctermbg=10
hi DiffChange     ctermfg=0    ctermbg=NONE
hi DiffDelete     ctermfg=0    ctermbg=9
hi DiffText       ctermfg=0    ctermbg=12

" Invert selected lines in visual mode
hi Visual         ctermfg=NONE ctermbg=NONE cterm=inverse

" Highlight search matches in black, with a yellow background
hi Search         ctermfg=0    ctermbg=11

" Dim line numbers, comments, color columns, the status line, splits and sign
" columns.
if &background == "dark"
  hi LineNr       ctermfg=7
  hi CursorLineNr ctermfg=8
  hi Comment      ctermfg=7
  hi ColorColumn  ctermfg=8    ctermbg=7
  hi Folded       ctermfg=8    ctermbg=7
  hi FoldColumn   ctermfg=8    ctermbg=7
  hi Pmenu        ctermfg=0    ctermbg=7
  hi PmenuSel     ctermfg=7    ctermbg=0
  hi SpellCap     ctermfg=8    ctermbg=7
  hi StatusLine   ctermfg=0    ctermbg=7    cterm=bold
  hi StatusLineNC ctermfg=8    ctermbg=7    cterm=NONE
  hi VertSplit    ctermfg=8    ctermbg=7    cterm=NONE
  hi SignColumn                ctermbg=7
else
  hi LineNr       ctermfg=8
  hi CursorLineNr ctermfg=7
  hi Comment      ctermfg=8
  hi ColorColumn  ctermfg=7    ctermbg=8
  hi Folded       ctermfg=NONE ctermbg=NONE
  hi FoldColumn   ctermfg=7    ctermbg=8
  hi Pmenu        ctermfg=8    ctermbg=15
  hi PmenuSel     ctermfg=8    ctermbg=12
  hi PmenuSbar    ctermfg=8    ctermbg=13
  hi SpellCap     ctermfg=9    ctermbg=NONE
  hi SpellBad     ctermfg=9    ctermbg=NONE
  hi SpellRare    ctermfg=13   ctermbg=NONE
  hi SpellLocal   ctermfg=14   ctermbg=NONE
  hi StatusLine   ctermfg=15   ctermbg=8    cterm=NONE
  hi StatusLineNC ctermfg=7    ctermbg=8    cterm=NONE
  hi TabLineSel   ctermfg=7    ctermbg=4    cterm=NONE
  hi VertSplit    ctermfg=8    ctermbg=8    cterm=NONE
  hi SignColumn                ctermbg=8
  hi FloatBorder  ctermfg=NONE ctermbg=NONE cterm=NONE
endif

hi! link NormalFloat Pmenu
hi! link TabLine StatusLine
hi! link TabLineFill Tabline
hi! link PmenuSbar Pmenu
hi! link PmenuThumb PmenuSel
hi! clear DiagnosticHint
