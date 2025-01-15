hi clear

if exists("syntax_on")
  syntax reset
endif

hi! clear

if &t_Co < 256 && !has("gui_running")
  let &t_Co = 256
endif

if !has('nvim') && has('win32')
  if &bg == 'light'
    hi Normal       ctermfg=0    ctermbg=7
    hi Normal       ctermfg=0    ctermbg=15
  else
    hi Normal       ctermfg=15    ctermbg=0
  endif
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
hi DiffAdd        cterm=NONE    ctermfg=0    ctermbg=10
hi DiffChange     cterm=NONE    ctermfg=0    ctermbg=NONE
hi DiffDelete     cterm=NONE    ctermfg=0    ctermbg=9
hi DiffText       cterm=NONE    ctermfg=0    ctermbg=12

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
  hi Pmenu        ctermfg=0    ctermbg=NONE
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
  hi Pmenu        ctermfg=8    ctermbg=NONE
  hi PmenuSel     ctermfg=7    ctermbg=4
  hi PmenuSbar    ctermfg=7    ctermbg=5
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

let g:terminal_ansi_colors = [
      \ "#383A42", "#E45649", "#50A14F", "#C18301",
      \ "#0184BC", "#A626A4", "#0997B3", "#fff0d2",
      \ "#4F525D", "#DF6C75", "#98C379", "#E4C07A",
      \ "#61AFEF", "#C577DD", "#56B5C1", "#FAFAFA",
      \ ]


" -- GVim ------------------------------------------------------------------

let tc = g:terminal_ansi_colors

exec 'hi Cursor guibg=' . tc[1] . ' guifg=' . tc[7]
hi! link Terminal Normal

let hlgroups = ["Normal","SpecialKey","TermCursor","NonText","Directory","ErrorMsg","IncSearch","MoreMsg","ModeMsg","Question","Title","WarningMsg","WildMenu","Conceal","SpellBad","SpellRare","SpellLocal","PmenuSbar","PmenuThumb","TabLine","TabLineSel","TabLineFill","CursorColumn","CursorLine","MatchParen","Constant","Special","Identifier","Statement","PreProc","Type","Underlined","Ignore","Error","Todo","Search", "Visual", "LineNr","CursorLineNr","Comment","ColorColumn","Folded","FoldColumn","Pmenu","PmenuSel","PmenuSbar","SpellCap","SpellBad","SpellRare","SpellLocal","StatusLine","StatusLineNC","TabLineSel","VertSplit","SignColumn","FloatBorder","DiffAdd","DiffChange","DiffDelete","DiffText"]
" let hlgroups = ["SpecialKey"]
let attrs = ['bg', 'fg']

for hlg in hlgroups
  for attr in attrs
    let c = synIDattr(hlID(hlg), attr, 'cterm')
    if c ==# ''
      let c = synIDattr(hlID('Normal'), attr, 'cterm')
    endif
    " echom c
    if c !=# ''
      exec 'hi' hlg 'gui'.attr.'='.tc[c]
      exec 'hi' hlg 'cterm'.attr.'='.c
    endif
  endfor
  exec 'hi ' . hlg . ' gui=NONE'
  if synIDattr(hlID(hlg), 'reverse', 'cterm')
    exec 'hi ' . hlg . ' gui=reverse'
  endif
  " exec 'hi' hlg
endfor
