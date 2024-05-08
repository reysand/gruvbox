" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------

vim9script

# Supporting code -------------------------------------------------------------
# Initialisation: {{{

if v:version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

g:colors_name = 'gruvbox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && 256 != 256 #&t_Co != 256
  finish
endif

# }}}
# Global Settings: {{{

if !exists('g:gruvbox_bold')
  g:gruvbox_bold = 1
endif
if !exists('g:gruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    g:gruvbox_italic = 1
  else
    g:gruvbox_italic = 0
  endif
endif
if !exists('g:gruvbox_undercurl')
  g:gruvbox_undercurl = 1
endif
if !exists('g:gruvbox_underline')
  g:gruvbox_underline = 1
endif
if !exists('g:gruvbox_inverse')
  g:gruvbox_inverse = 1
endif

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
  g:gruvbox_guisp_fallback = 'NONE'
endif

if !exists('g:gruvbox_improved_strings')
  g:gruvbox_improved_strings = 0
endif

if !exists('g:gruvbox_improved_warnings')
  g:gruvbox_improved_warnings = 0
endif

if !exists('g:gruvbox_termcolors')
  g:gruvbox_termcolors = 256
endif

if !exists('g:gruvbox_invert_indent_guides')
  g:gruvbox_invert_indent_guides = 0
endif

if exists('g:gruvbox_contrast')
  echo 'g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead'
endif

if !exists('g:gruvbox_contrast_dark')
  g:gruvbox_contrast_dark = 'medium'
endif

if !exists('g:gruvbox_contrast_light')
  g:gruvbox_contrast_light = 'medium'
endif

var is_dark = (&background == 'dark')

# }}}
# Pavarte: {{{

# setup pavarte dictionary
var gb = {}

# fill it with absolute colors
gb.dark0_hard  = ['#1d2021', 234]     # 29-32-33
gb.dark0       = ['#282828', 235]     # 40-40-40
gb.dark0_soft  = ['#32302f', 236]     # 50-48-47
gb.dark1       = ['#3c3836', 237]     # 60-56-54
gb.dark2       = ['#504945', 239]     # 80-73-69
gb.dark3       = ['#665c54', 241]     # 102-92-84
gb.dark4       = ['#7c6f64', 243]     # 124-111-100
gb.dark4_256   = ['#7c6f64', 243]     # 124-111-100

gb.gray_245    = ['#928374', 245]     # 146-131-116
gb.gray_244    = ['#928374', 244]     # 146-131-116

gb.light0_hard = ['#f9f5d7', 230]     # 249-245-215
gb.light0      = ['#fbf1c7', 229]     # 253-244-193
gb.light0_soft = ['#f2e5bc', 228]     # 242-229-188
gb.light1      = ['#ebdbb2', 223]     # 235-219-178
gb.light2      = ['#d5c4a1', 250]     # 213-196-161
gb.light3      = ['#bdae93', 248]     # 189-174-147
gb.light4      = ['#a89984', 246]     # 168-153-132
gb.light4_256  = ['#a89984', 246]     # 168-153-132

gb.bright_red     = ['#fb4934', 167]     # 251-73-52
gb.bright_green   = ['#b8bb26', 142]     # 184-187-38
gb.bright_yellow  = ['#fabd2f', 214]     # 250-189-47
gb.bright_blue    = ['#83a598', 109]     # 131-165-152
gb.bright_purple  = ['#d3869b', 175]     # 211-134-155
gb.bright_aqua    = ['#8ec07c', 108]     # 142-192-124
gb.bright_orange  = ['#fe8019', 208]     # 254-128-25

gb.neutral_red    = ['#cc241d', 124]     # 204-36-29
gb.neutral_green  = ['#98971a', 106]     # 152-151-26
gb.neutral_yellow = ['#d79921', 172]     # 215-153-33
gb.neutral_blue   = ['#458588', 66]      # 69-133-136
gb.neutral_purple = ['#b16286', 132]     # 177-98-134
gb.neutral_aqua   = ['#689d6a', 72]      # 104-157-106
gb.neutral_orange = ['#d65d0e', 166]     # 214-93-14

gb.faded_red      = ['#9d0006', 88]      # 157-0-6
gb.faded_green    = ['#79740e', 100]     # 121-116-14
gb.faded_yellow   = ['#b57614', 136]     # 181-118-20
gb.faded_blue     = ['#076678', 24]      # 7-102-120
gb.faded_purple   = ['#8f3f71', 96]      # 143-63-113
gb.faded_aqua     = ['#427b58', 66]      # 66-123-88
gb.faded_orange   = ['#af3a03', 130]     # 175-58-3

# }}}
# Setup Emphasis: {{{

var bold = 'bold,'
if g:gruvbox_bold == 0
  var bold = ''
endif

var italic = 'italic,'
if g:gruvbox_italic == 0
  var italic = ''
endif

var underline = 'underline,'
if g:gruvbox_underline == 0
  var underline = ''
endif

var undercurl = 'undercurl,'
if g:gruvbox_undercurl == 0
  var undercurl = ''
endif

var inverse = 'inverse,'
if g:gruvbox_inverse == 0
  var inverse = ''
endif

# }}}
# Setup Colors: {{{

var vim_bg = ['bg', 'bg']
var vim_fg = ['fg', 'fg']
var none = ['NONE', 'NONE']

# determine relative colors
if is_dark
  var bg0  = gb.dark0
  if g:gruvbox_contrast_dark == 'soft'
    bg0  = gb.dark0_soft
  elseif g:gruvbox_contrast_dark == 'hard'
    bg0  = gb.dark0_hard
  endif

  var bg1  = gb.dark1
  var bg2  = gb.dark2
  var bg3  = gb.dark3
  var bg4  = gb.dark4

  var gray = gb.gray_245

  var fg0 = gb.light0
  var fg1 = gb.light1
  var fg2 = gb.light2
  var fg3 = gb.light3
  var fg4 = gb.light4

  var fg4_256 = gb.light4_256

  var red    = gb.bright_red
  var green  = gb.bright_green
  var yellow = gb.bright_yellow
  var blue   = gb.bright_blue
  var purple = gb.bright_purple
  var aqua   = gb.bright_aqua
  var orange = gb.bright_orange
else
  var bg0  = gb.light0
  if g:gruvbox_contrast_light == 'soft'
    bg0  = gb.light0_soft
  elseif g:gruvbox_contrast_light == 'hard'
    bg0  = gb.light0_hard
  endif

  var bg1  = gb.light1
  var bg2  = gb.light2
  var bg3  = gb.light3
  var bg4  = gb.light4

  var gray = gb.gray_244

  var fg0 = gb.dark0
  var fg1 = gb.dark1
  var fg2 = gb.dark2
  var fg3 = gb.dark3
  var fg4 = gb.dark4

  var fg4_256 = gb.dark4_256

  var red    = gb.faded_red
  var green  = gb.faded_green
  var yellow = gb.faded_yellow
  var blue   = gb.faded_blue
  var purple = gb.faded_purple
  var aqua   = gb.faded_aqua
  var orange = gb.faded_orange
endif

# reset to 16 colors fallback
if g:gruvbox_termcolors == 16
  var bg0[1]    = 0
  var fg4[1]    = 7
  var gray[1]   = 8
  var red[1]    = 9
  var green[1]  = 10
  var yellow[1] = 11
  var blue[1]   = 12
  var purple[1] = 13
  var aqua[1]   = 14
  var fg1[1]    = 15
endif

# save current relative colors back to pavarte dictionary
var gb.bg0 = bg0
var gb.bg1 = bg1
var gb.bg2 = bg2
var gb.bg3 = bg3
var gb.bg4 = bg4

var gb.gray = gray

var gb.fg0 = fg0
var gb.fg1 = fg1
var gb.fg2 = fg2
var gb.fg3 = fg3
var gb.fg4 = fg4

var gb.fg4_256 = fg4_256

var gb.red    = red
var gb.green  = green
var gb.yellow = yellow
var gb.blue   = blue
var gb.purple = purple
var gb.aqua   = aqua
var gb.orange = orange

# }}}
# Setup Terminal Colors For Neovim: {{{

if has('nvim')
  g:terminal_color_0 = bg0[0]
  g:terminal_color_8 = gray[0]

  g:terminal_color_1 = gb.neutral_red[0]
  g:terminal_color_9 = red[0]

  g:terminal_color_2 = gb.neutral_green[0]
  g:terminal_color_10 = green[0]

  g:terminal_color_3 = gb.neutral_yellow[0]
  g:terminal_color_11 = yellow[0]

  g:terminal_color_4 = gb.neutral_blue[0]
  g:terminal_color_12 = blue[0]

  g:terminal_color_5 = gb.neutral_purple[0]
  g:terminal_color_13 = purple[0]

  g:terminal_color_6 = gb.neutral_aqua[0]
  g:terminal_color_14 = aqua[0]

  g:terminal_color_7 = fg4[0]
  g:terminal_color_15 = fg1[0]
endif

# }}}
# Overload Setting: {{{

var hls_cursor = orange
if exists('g:gruvbox_hls_cursor')
  var hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

var number_column = none
if exists('g:gruvbox_number_column')
  var number_column = get(s:gb, g:gruvbox_number_column)
endif

var sign_column = bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  var sign_column = number_column
else
  g:gitgutter_override_sign_column_highlight = 0

  if exists('g:gruvbox_sign_column')
    var sign_column = get(s:gb, g:gruvbox_sign_column)
  endif
endif

var color_column = bg1
if exists('g:gruvbox_color_column')
  var color_column = get(s:gb, g:gruvbox_color_column)
endif

var vert_split = bg0
if exists('g:gruvbox_vert_split')
  var vert_split = get(s:gb, g:gruvbox_vert_split)
endif

var invert_signs = ''
if exists('g:gruvbox_invert_signs')
  if g:gruvbox_invert_signs == 1
    var invert_signs = inverse
  endif
endif

var invert_selection = inverse
if exists('g:gruvbox_invert_selection')
  if g:gruvbox_invert_selection == 0
    var invert_selection = ''
  endif
endif

var invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
  if g:gruvbox_invert_tabline == 1
    var invert_tabline = inverse
  endif
endif

var italicize_comments = italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    var italicize_comments = ''
  endif
endif

var italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    var italicize_strings = italic
  endif
endif

# }}}
# Highlighting Function: {{{

def HL(group, fg, ...)
  # Arguments: group, guifg, guibg, gui, guisp

  # foreground
  var fg = a:fg

  # background
  if a:0 >= 1
    var bg = a:1
  else
    var bg = none
  endif

  # emphasis
  if a:0 >= 2 && strlen(a:2)
    var emstr = a:2
  else
    var emstr = 'NONE,'
  endif

  # special fallback
  if a:0 >= 3
    if g:gruvbox_guisp_fallback != 'NONE'
      fg = a:3
    endif

    # bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback == 'bg'
      emstr .= 'inverse,'
    endif
  endif

  var histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  # special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

# }}}
# Gruvbox Hi Groups: {{{

# memoize common hi groups
s:HL('GruvboxFg0', fg0)
s:HL('GruvboxFg1', fg1)
s:HL('GruvboxFg2', fg2)
s:HL('GruvboxFg3', fg3)
s:HL('GruvboxFg4', fg4)
s:HL('GruvboxGray', gray)
s:HL('GruvboxBg0', bg0)
s:HL('GruvboxBg1', bg1)
s:HL('GruvboxBg2', bg2)
s:HL('GruvboxBg3', bg3)
s:HL('GruvboxBg4', bg4)

s:HL('GruvboxRed', red)
s:HL('GruvboxRedBold', red, none, bold)
s:HL('GruvboxGreen', green)
s:HL('GruvboxGreenBold', green, none, bold)
s:HL('GruvboxYellow', yellow)
s:HL('GruvboxYellowBold', yellow, none, bold)
s:HL('GruvboxBlue', blue)
s:HL('GruvboxBlueBold', blue, none, bold)
s:HL('GruvboxPurple', purple)
s:HL('GruvboxPurpleBold', purple, none, bold)
s:HL('GruvboxAqua', aqua)
s:HL('GruvboxAquaBold', aqua, none, bold)
s:HL('GruvboxOrange', orange)
s:HL('GruvboxOrangeBold', orange, none, bold)

s:HL('GruvboxRedSign', red, sign_column, invert_signs)
s:HL('GruvboxGreenSign', green, sign_column, invert_signs)
s:HL('GruvboxYellowSign', yellow, sign_column, invert_signs)
s:HL('GruvboxBlueSign', blue, sign_column, invert_signs)
s:HL('GruvboxPurpleSign', purple, sign_column, invert_signs)
s:HL('GruvboxAquaSign', aqua, sign_column, invert_signs)
s:HL('GruvboxOrangeSign', orange, sign_column, invert_signs)

# }}}

# Vanilla colorscheme ---------------------------------------------------------
# General UI: {{{

# Normal text
s:HL('Normal', fg1, bg0)

# Correct background (see issue #7):
# --- Problem with changing between dark and light on 256 color terminal
# --- https://github.com/morhetz/gruvbox/issues/7
if is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  # Screen line that the cursor is
s:HL('CursorLine',   none, bg1)
  # Screen column that the cursor is
  hi! link CursorColumn CursorLine

  # Tab pages line filler
s:HL('TabLineFill', bg4, bg1, invert_tabline)
  # Active tab page label
s:HL('TabLineSel', green, bg1, invert_tabline)
  # Not active tab page label
  hi! link TabLine TabLineFill

  # Match paired bracket under the cursor
s:HL('MatchParen', none, bg3, bold)
endif

if version >= 703
  # Highlighted screen columns
s:HL('ColorColumn',  none, color_column)

  # Concealed element: \lambda → λ
s:HL('Conceal', blue, none)

  # Line number of CursorLine
s:HL('CursorLineNr', yellow, bg1)
endif

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxBg2

s:HL('Visual',    none,  bg3, invert_selection)
hi! link VisualNOS Visual

s:HL('Search',    yellow, bg0, inverse)
s:HL('IncSearch', hls_cursor, bg0, inverse)

s:HL('Underlined', blue, none, underline)

s:HL('StatusLine',   bg2, fg1, inverse)
s:HL('StatusLineNC', bg1, fg4, inverse)

# The column separating vertically split windows
s:HL('VertSplit', bg3, vert_split)

# Current match in wildmenu compvarion
s:HL('WildMenu', blue, bg2, bold)

# Directory names, special names in listing
hi! link Directory GruvboxGreenBold

# Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

# Error messages on the command line
s:HL('ErrorMsg',   bg0, red, bold)
# More prompt: -- More --
hi! link MoreMsg GruvboxYellowBold
# Current mode message: -- INSERT --
hi! link ModeMsg GruvboxYellowBold
# 'Press enter' prompt and yes/no questions
hi! link Question GruvboxOrangeBold
# Warning messages
hi! link WarningMsg GruvboxRedBold

# }}}
# Gutter: {{{

# Line number for :number and :# commands
s:HL('LineNr', bg4, number_column)

# Column where signs are displayed
s:HL('SignColumn', none, sign_column)

# Line used for closed folds
s:HL('Folded', gray, bg1, italic)
# Column where folds are displayed
s:HL('FoldColumn', gray, bg1)

# }}}
# Cursor: {{{

# Character under cursor
s:HL('Cursor', none, none, inverse)
# Visual mode cursor, selection
hi! link vCursor Cursor
# Input moder cursor
hi! link iCursor Cursor
# Language mapping cursor
hi! link lCursor Cursor

# }}}
# Syntax Highlighting: {{{

if g:gruvbox_improved_strings == 0
  hi! link Special GruvboxOrange
else
s:HL('Special', orange, bg1, italicize_strings)
endif

s:HL('Comment', gray, none, italicize_comments)
s:HL('Todo', vim_fg, vim_bg, bold . s:italic)
s:HL('Error', red, vim_bg, bold . s:inverse)

# Generic statement
hi! link Statement GruvboxRed
# if, then, else, endif, swicth, etc.
hi! link Conditional GruvboxRed
# for, do, while, etc.
hi! link Repeat GruvboxRed
# case, default, etc.
hi! link Label GruvboxRed
# try, catch, throw
hi! link Exception GruvboxRed
# sizeof, "+", "*", etc.
hi! link Operator Normal
# Any other keyword
hi! link Keyword GruvboxRed

# Variable name
hi! link Identifier GruvboxBlue
# Function name
hi! link Function GruvboxGreenBold

# Generic preprocessor
hi! link PreProc GruvboxAqua
# Preprocessor #include
hi! link Include GruvboxAqua
# Preprocessor #define
hi! link Define GruvboxAqua
# Same as Define
hi! link Macro GruvboxAqua
# Preprocessor #if, #else, #endif, etc.
hi! link PreCondit GruvboxAqua

# Generic constant
hi! link Constant GruvboxPurple
# Character constant: 'c', '/n'
hi! link Character GruvboxPurple
# String constant: "this is a string"
if g:gruvbox_improved_strings == 0
s:HL('String',  green, none, italicize_strings)
else
s:HL('String',  fg1, bg1, italicize_strings)
endif
# Boolean constant: TRUE, false
hi! link Boolean GruvboxPurple
# Number constant: 234, 0xff
hi! link Number GruvboxPurple
# Floating point constant: 2.3e10
hi! link Float GruvboxPurple

# Generic type
hi! link Type GruvboxYellow
# static, register, volatile, etc
hi! link StorageClass GruvboxOrange
# struct, union, enum, etc.
hi! link Structure GruvboxAqua
# typedef
hi! link Typedef GruvboxYellow

# }}}
# Compvarion Menu: {{{

if version >= 700
  # Popup menu: normal item
s:HL('Pmenu', fg1, bg2)
  # Popup menu: selected item
s:HL('PmenuSel', bg2, blue, bold)
  # Popup menu: scrollbar
s:HL('PmenuSbar', none, bg2)
  # Popup menu: scrollbar thumb
s:HL('PmenuThumb', none, bg4)
endif

# }}}
# Diffs: {{{

s:HL('DiffDevare', red, bg0, inverse)
s:HL('DiffAdd',    green, bg0, inverse)
#s:HL('DiffChange', bg0, blue)
#s:HL('DiffText',   bg0, yellow)

# Alternative setting
s:HL('DiffChange', aqua, bg0, inverse)
s:HL('DiffText',   yellow, bg0, inverse)

# }}}
# Spelling: {{{

if has("spell")
  # Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
s:HL('SpellCap',   none, none, undercurl, red)
  else
s:HL('SpellCap',   green, none, bold . s:italic)
  endif
  # Not recognized word
s:HL('SpellBad',   none, none, undercurl, blue)
  # Wrong spelling for selected region
s:HL('SpellLocal', none, none, undercurl, aqua)
  # Rare word
s:HL('SpellRare',  none, none, undercurl, purple)
endif

# }}}

# Plugin specific -------------------------------------------------------------
# EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

# }}}
# Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

# }}}
# Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:gruvbox_invert_indent_guides == 0
s:HL('IndentGuidesOdd', vim_bg, bg2)
s:HL('IndentGuidesEven', vim_bg, bg1)
  else
s:HL('IndentGuidesOdd', vim_bg, bg2, inverse)
s:HL('IndentGuidesEven', vim_bg, bg3, inverse)
  endif
endif

# }}}
# IndentLine: {{{

if !exists('g:indentLine_color_term')
  g:indentLine_color_term = bg2[1]
endif
if !exists('g:indentLine_color_gui')
  g:indentLine_color_gui = bg2[0]
endif

# }}}
# Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

g:niji_dark_colours = g:rbpt_colorpairs
g:niji_light_colours = g:rbpt_colorpairs

"}}}
# GitGutter: {{{

hi! link GitGutterAdd GruvboxGreenSign
hi! link GitGutterChange GruvboxAquaSign
hi! link GitGutterDevare GruvboxRedSign
hi! link GitGutterChangeDevare GruvboxAquaSign

# }}}
# GitCommit: "{{{

hi! link gitcommitSelectedFile GruvboxGreen
hi! link gitcommitDiscardedFile GruvboxRed

# }}}
# Signify: {{{

hi! link SignifySignAdd GruvboxGreenSign
hi! link SignifySignChange GruvboxAquaSign
hi! link SignifySignDevare GruvboxRedSign

# }}}
# Syntastic: {{{

s:HL('SyntasticError', none, none, undercurl, red)
s:HL('SyntasticWarning', none, none, undercurl, yellow)

hi! link SyntasticErrorSign GruvboxRedSign
hi! link SyntasticWarningSign GruvboxYellowSign

# }}}
# Signature: {{{
hi! link SignatureMarkText   GruvboxBlueSign
hi! link SignatureMarkerText GruvboxPurpleSign

# }}}
# ShowMarks: {{{

hi! link ShowMarksHLl GruvboxBlueSign
hi! link ShowMarksHLu GruvboxBlueSign
hi! link ShowMarksHLo GruvboxBlueSign
hi! link ShowMarksHLm GruvboxBlueSign

# }}}
# CtrlP: {{{

hi! link CtrlPMatch GruvboxYellow
hi! link CtrlPNoEntries GruvboxRed
hi! link CtrlPPrtBase GruvboxBg2
hi! link CtrlPPrtCursor GruvboxBlue
hi! link CtrlPLinePre GruvboxBg2

s:HL('CtrlPMode1', blue, bg2, bold)
s:HL('CtrlPMode2', bg0, blue, bold)
s:HL('CtrlPStats', fg4, bg2, bold)

# }}}
# Startify: {{{

hi! link StartifyBracket GruvboxFg3
hi! link StartifyFile GruvboxFg1
hi! link StartifyNumber GruvboxBlue
hi! link StartifyPath GruvboxGray
hi! link StartifySlash GruvboxGray
hi! link StartifySection GruvboxYellow
hi! link StartifySpecial GruvboxBg2
hi! link StartifyHeader GruvboxOrange
hi! link StartifyFooter GruvboxBg2

# }}}
# Vimshell: {{{

g:vimshell_escape_colors = [
  \ bg4[0], red[0], green[0], yellow[0],
  \ blue[0], purple[0], aqua[0], fg4[0],
  \ bg0[0], red[0], green[0], orange[0],
  \ blue[0], purple[0], aqua[0], fg0[0]
  \ ]

# }}}
# BufTabLine: {{{

s:HL('BufTabLineCurrent', bg0, fg4)
s:HL('BufTabLineActive', fg4, bg2)
s:HL('BufTabLineHidden', bg4, bg1)
s:HL('BufTabLineFill', bg0, bg0)

# }}}
# Asynchronous Lint Engine: {{{

s:HL('ALEError', none, none, undercurl, red)
s:HL('ALEWarning', none, none, undercurl, yellow)
s:HL('ALEInfo', none, none, undercurl, blue)

hi! link ALEErrorSign GruvboxRedSign
hi! link ALEWarningSign GruvboxYellowSign
hi! link ALEInfoSign GruvboxBlueSign

# }}}
# Dirvish: {{{

hi! link DirvishPathTail GruvboxAqua
hi! link DirvishArg GruvboxYellow

# }}}
# Netrw: {{{

hi! link netrwDir GruvboxAqua
hi! link netrwClassify GruvboxAqua
hi! link netrwLink GruvboxGray
hi! link netrwSymLink GruvboxFg1
hi! link netrwExe GruvboxYellow
hi! link netrwComment GruvboxGray
hi! link netrwList GruvboxBlue
hi! link netrwHelpCmd GruvboxAqua
hi! link netrwCmdSep GruvboxFg3
hi! link netrwVersion GruvboxGreen

# }}}
# NERDTree: {{{

hi! link NERDTreeDir GruvboxAqua
hi! link NERDTreeDirSlash GruvboxAqua

hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange

hi! link NERDTreeFile GruvboxFg1
hi! link NERDTreeExecFile GruvboxYellow

hi! link NERDTreeUp GruvboxGray
hi! link NERDTreeCWD GruvboxGreen
hi! link NERDTreeHelp GruvboxFg1

hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxRed

# }}}
# Vim Multiple Cursors: {{{

s:HL('multiple_cursors_cursor', none, none, inverse)
s:HL('multiple_cursors_visual', none, bg2)

# }}}
# coc.nvim: {{{

hi! link CocErrorSign GruvboxRedSign
hi! link CocWarningSign GruvboxOrangeSign
hi! link CocInfoSign GruvboxYellowSign
hi! link CocHintSign GruvboxBlueSign
hi! link CocErrorFloat GruvboxRed
hi! link CocWarningFloat GruvboxOrange
hi! link CocInfoFloat GruvboxYellow
hi! link CocHintFloat GruvboxBlue
hi! link CocDiagnosticsError GruvboxRed
hi! link CocDiagnosticsWarning GruvboxOrange
hi! link CocDiagnosticsInfo GruvboxYellow
hi! link CocDiagnosticsHint GruvboxBlue

hi! link CocSelectedText GruvboxRed
hi! link CocCodeLens GruvboxGray

s:HL('CocErrorHighlight', none, none, undercurl, red)
s:HL('CocWarningHighlight', none, none, undercurl, orange)
s:HL('CocInfoHighlight', none, none, undercurl, yellow)
s:HL('CocHintHighlight', none, none, undercurl, blue)

# }}}

# Fivarype specific -----------------------------------------------------------
# Diff: {{{

hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxBlue

# }}}
# Html: {{{

hi! link htmlTag GruvboxBlue
hi! link htmlEndTag GruvboxBlue

hi! link htmlTagName GruvboxAquaBold
hi! link htmlArg GruvboxAqua

hi! link htmlScriptTag GruvboxPurple
hi! link htmlTagN GruvboxFg1
hi! link htmlSpecialTagName GruvboxAquaBold

s:HL('htmlLink', fg4, none, underline)

hi! link htmlSpecialChar GruvboxOrange

s:HL('htmlBold', vim_fg, vim_bg, bold)
s:HL('htmlBoldUnderline', vim_fg, vim_bg, bold . s:underline)
s:HL('htmlBoldItalic', vim_fg, vim_bg, bold . s:italic)
s:HL('htmlBoldUnderlineItalic', vim_fg, vim_bg, bold . s:underline . s:italic)

s:HL('htmlUnderline', vim_fg, vim_bg, underline)
s:HL('htmlUnderlineItalic', vim_fg, vim_bg, underline . s:italic)
s:HL('htmlItalic', vim_fg, vim_bg, italic)

# }}}
# Xml: {{{

hi! link xmlTag GruvboxBlue
hi! link xmlEndTag GruvboxBlue
hi! link xmlTagName GruvboxBlue
hi! link xmlEqual GruvboxBlue
hi! link docbkKeyword GruvboxAquaBold

hi! link xmlDocTypeDecl GruvboxGray
hi! link xmlDocTypeKeyword GruvboxPurple
hi! link xmlCdataStart GruvboxGray
hi! link xmlCdataCdata GruvboxPurple
hi! link dtdFunction GruvboxGray
hi! link dtdTagName GruvboxPurple

hi! link xmlAttrib GruvboxAqua
hi! link xmlProcessingDelim GruvboxGray
hi! link dtdParamEntityPunct GruvboxGray
hi! link dtdParamEntityDPunct GruvboxGray
hi! link xmlAttribPunct GruvboxGray

hi! link xmlEntity GruvboxOrange
hi! link xmlEntityPunct GruvboxOrange
# }}}
# Vim: {{{

s:HL('vimCommentTitle', fg4_256, none, bold . s:italicize_comments)

hi! link vimNotation GruvboxOrange
hi! link vimBracket GruvboxOrange
hi! link vimMapModKey GruvboxOrange
hi! link vimFuncSID GruvboxFg3
hi! link vimSetSep GruvboxFg3
hi! link vimSep GruvboxFg3
hi! link vimContinue GruvboxFg3

# }}}
# Clojure: {{{

hi! link clojureKeyword GruvboxBlue
hi! link clojureCond GruvboxOrange
hi! link clojureSpecial GruvboxOrange
hi! link clojureDefine GruvboxOrange

hi! link clojureFunc GruvboxYellow
hi! link clojureRepeat GruvboxYellow
hi! link clojureCharacter GruvboxAqua
hi! link clojureStringEscape GruvboxAqua
hi! link clojureException GruvboxRed

hi! link clojureRegexp GruvboxAqua
hi! link clojureRegexpEscape GruvboxAqua
s:HL('clojureRegexpCharClass', fg3, none, bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen GruvboxFg3
hi! link clojureAnonArg GruvboxYellow
hi! link clojureVariable GruvboxBlue
hi! link clojureMacro GruvboxOrange

hi! link clojureMeta GruvboxYellow
hi! link clojureDeref GruvboxYellow
hi! link clojureQuote GruvboxYellow
hi! link clojureUnquote GruvboxYellow

# }}}
# C: {{{

hi! link cOperator GruvboxPurple
hi! link cStructure GruvboxOrange

# }}}
# Python: {{{

hi! link pythonBuiltin GruvboxOrange
hi! link pythonBuiltinObj GruvboxOrange
hi! link pythonBuiltinFunc GruvboxOrange
hi! link pythonFunction GruvboxAqua
hi! link pythonDecorator GruvboxRed
hi! link pythonInclude GruvboxBlue
hi! link pythonImport GruvboxBlue
hi! link pythonRun GruvboxBlue
hi! link pythonCoding GruvboxBlue
hi! link pythonOperator GruvboxRed
hi! link pythonException GruvboxRed
hi! link pythonExceptions GruvboxPurple
hi! link pythonBoolean GruvboxPurple
hi! link pythonDot GruvboxFg3
hi! link pythonConditional GruvboxRed
hi! link pythonRepeat GruvboxRed
hi! link pythonDottedName GruvboxGreenBold

# }}}
# CSS: {{{

hi! link cssBraces GruvboxBlue
hi! link cssFunctionName GruvboxYellow
hi! link cssIdentifier GruvboxOrange
hi! link cssClassName GruvboxGreen
hi! link cssColor GruvboxBlue
hi! link cssSelectorOp GruvboxBlue
hi! link cssSelectorOp2 GruvboxBlue
hi! link cssImportant GruvboxGreen
hi! link cssVendor GruvboxFg1

hi! link cssTextProp GruvboxAqua
hi! link cssAnimationProp GruvboxAqua
hi! link cssUIProp GruvboxYellow
hi! link cssTransformProp GruvboxAqua
hi! link cssTransitionProp GruvboxAqua
hi! link cssPrintProp GruvboxAqua
hi! link cssPositioningProp GruvboxYellow
hi! link cssBoxProp GruvboxAqua
hi! link cssFontDescriptorProp GruvboxAqua
hi! link cssFlexibleBoxProp GruvboxAqua
hi! link cssBorderOutlineProp GruvboxAqua
hi! link cssBackgroundProp GruvboxAqua
hi! link cssMarginProp GruvboxAqua
hi! link cssListProp GruvboxAqua
hi! link cssTableProp GruvboxAqua
hi! link cssFontProp GruvboxAqua
hi! link cssPaddingProp GruvboxAqua
hi! link cssDimensionProp GruvboxAqua
hi! link cssRenderProp GruvboxAqua
hi! link cssColorProp GruvboxAqua
hi! link cssGeneratedContentProp GruvboxAqua

# }}}
# JavaScript: {{{

hi! link javaScriptBraces GruvboxFg1
hi! link javaScriptFunction GruvboxAqua
hi! link javaScriptIdentifier GruvboxRed
hi! link javaScriptMember GruvboxBlue
hi! link javaScriptNumber GruvboxPurple
hi! link javaScriptNull GruvboxPurple
hi! link javaScriptParens GruvboxFg3

# }}}
# YAJS: {{{

hi! link javascriptImport GruvboxAqua
hi! link javascriptExport GruvboxAqua
hi! link javascriptClassKeyword GruvboxAqua
hi! link javascriptClassExtends GruvboxAqua
hi! link javascriptDefault GruvboxAqua

hi! link javascriptClassName GruvboxYellow
hi! link javascriptClassSuperName GruvboxYellow
hi! link javascriptGlobal GruvboxYellow

hi! link javascriptEndColons GruvboxFg1
hi! link javascriptFuncArg GruvboxFg1
hi! link javascriptGlobalMethod GruvboxFg1
hi! link javascriptNodeGlobal GruvboxFg1
hi! link javascriptBOMWindowProp GruvboxFg1
hi! link javascriptArrayMethod GruvboxFg1
hi! link javascriptArrayStaticMethod GruvboxFg1
hi! link javascriptCacheMethod GruvboxFg1
hi! link javascriptDateMethod GruvboxFg1
hi! link javascriptMathStaticMethod GruvboxFg1

# hi! link javascriptProp GruvboxFg1
hi! link javascriptURLUtilsProp GruvboxFg1
hi! link javascriptBOMNavigatorProp GruvboxFg1
hi! link javascriptDOMDocMethod GruvboxFg1
hi! link javascriptDOMDocProp GruvboxFg1
hi! link javascriptBOMLocationMethod GruvboxFg1
hi! link javascriptBOMWindowMethod GruvboxFg1
hi! link javascriptStringMethod GruvboxFg1

hi! link javascriptVariable GruvboxOrange
# hi! link javascriptVariable GruvboxRed
# hi! link javascriptIdentifier GruvboxOrange
# hi! link javascriptClassSuper GruvboxOrange
hi! link javascriptIdentifier GruvboxOrange
hi! link javascriptClassSuper GruvboxOrange

# hi! link javascriptFuncKeyword GruvboxOrange
# hi! link javascriptAsyncFunc GruvboxOrange
hi! link javascriptFuncKeyword GruvboxAqua
hi! link javascriptAsyncFunc GruvboxAqua
hi! link javascriptClassStatic GruvboxOrange

hi! link javascriptOperator GruvboxRed
hi! link javascriptForOperator GruvboxRed
hi! link javascriptYield GruvboxRed
hi! link javascriptExceptions GruvboxRed
hi! link javascriptMessage GruvboxRed

hi! link javascriptTemplateSB GruvboxAqua
hi! link javascriptTemplateSubstitution GruvboxFg1

# hi! link javascriptLabel GruvboxBlue
# hi! link javascriptObjectLabel GruvboxBlue
# hi! link javascriptPropertyName GruvboxBlue
hi! link javascriptLabel GruvboxFg1
hi! link javascriptObjectLabel GruvboxFg1
hi! link javascriptPropertyName GruvboxFg1

hi! link javascriptLogicSymbols GruvboxFg1
hi! link javascriptArrowFunc GruvboxYellow

hi! link javascriptDocParamName GruvboxFg4
hi! link javascriptDocTags GruvboxFg4
hi! link javascriptDocNotation GruvboxFg4
hi! link javascriptDocParamType GruvboxFg4
hi! link javascriptDocNamedParamType GruvboxFg4

hi! link javascriptBrackets GruvboxFg1
hi! link javascriptDOMElemAttrs GruvboxFg1
hi! link javascriptDOMEventMethod GruvboxFg1
hi! link javascriptDOMNodeMethod GruvboxFg1
hi! link javascriptDOMStorageMethod GruvboxFg1
hi! link javascriptHeadersMethod GruvboxFg1

hi! link javascriptAsyncFuncKeyword GruvboxRed
hi! link javascriptAwaitFuncKeyword GruvboxRed

# }}}
# PanglossJS: {{{

hi! link jsClassKeyword GruvboxAqua
hi! link jsExtendsKeyword GruvboxAqua
hi! link jsExportDefault GruvboxAqua
hi! link jsTemplateBraces GruvboxAqua
hi! link jsGlobalNodeObjects GruvboxFg1
hi! link jsGlobalObjects GruvboxFg1
hi! link jsFunction GruvboxAqua
hi! link jsFuncParens GruvboxFg3
hi! link jsParens GruvboxFg3
hi! link jsNull GruvboxPurple
hi! link jsUndefined GruvboxPurple
hi! link jsClassDefinition GruvboxYellow

# }}}
# TypeScript: {{{

hi! link typeScriptReserved GruvboxAqua
hi! link typeScriptLabel GruvboxAqua
hi! link typeScriptFuncKeyword GruvboxAqua
hi! link typeScriptIdentifier GruvboxOrange
hi! link typeScriptBraces GruvboxFg1
hi! link typeScriptEndColons GruvboxFg1
hi! link typeScriptDOMObjects GruvboxFg1
hi! link typeScriptAjaxMethods GruvboxFg1
hi! link typeScriptLogicSymbols GruvboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects GruvboxFg1
hi! link typeScriptParens GruvboxFg3
hi! link typeScriptOpSymbols GruvboxFg3
hi! link typeScriptHtmlElemProperties GruvboxFg1
hi! link typeScriptNull GruvboxPurple
hi! link typeScriptInterpolationDelimiter GruvboxAqua

# }}}
# PureScript: {{{

hi! link purescriptModuleKeyword GruvboxAqua
hi! link purescriptModuleName GruvboxFg1
hi! link purescriptWhere GruvboxAqua
hi! link purescriptDelimiter GruvboxFg4
hi! link purescriptType GruvboxFg1
hi! link purescriptImportKeyword GruvboxAqua
hi! link purescriptHidingKeyword GruvboxAqua
hi! link purescriptAsKeyword GruvboxAqua
hi! link purescriptStructure GruvboxAqua
hi! link purescriptOperator GruvboxBlue

hi! link purescriptTypeVar GruvboxFg1
hi! link purescriptConstructor GruvboxFg1
hi! link purescriptFunction GruvboxFg1
hi! link purescriptConditional GruvboxOrange
hi! link purescriptBacktick GruvboxOrange

# }}}
# CoffeeScript: {{{

hi! link coffeeExtendedOp GruvboxFg3
hi! link coffeeSpecialOp GruvboxFg3
hi! link coffeeCurly GruvboxOrange
hi! link coffeeParen GruvboxFg3
hi! link coffeeBracket GruvboxOrange

# }}}
# Ruby: {{{

hi! link rubyStringDelimiter GruvboxGreen
hi! link rubyInterpolationDelimiter GruvboxAqua

# }}}
# ObjectiveC: {{{

hi! link objcTypeModifier GruvboxRed
hi! link objcDirective GruvboxBlue

# }}}
# Go: {{{

hi! link goDirective GruvboxAqua
hi! link goConstants GruvboxPurple
hi! link goDeclaration GruvboxRed
hi! link goDeclType GruvboxBlue
hi! link goBuiltins GruvboxOrange

# }}}
# Lua: {{{

hi! link luaIn GruvboxRed
hi! link luaFunction GruvboxAqua
hi! link luaTable GruvboxOrange

#
#}}}
# MoonScript: {{{

hi! link moonSpecialOp GruvboxFg3
hi! link moonExtendedOp GruvboxFg3
hi! link moonFunction GruvboxFg3
hi! link moonObject GruvboxYellow

# }}}
# Java: {{{

hi! link javaAnnotation GruvboxBlue
hi! link javaDocTags GruvboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen GruvboxFg3
hi! link javaParen1 GruvboxFg3
hi! link javaParen2 GruvboxFg3
hi! link javaParen3 GruvboxFg3
hi! link javaParen4 GruvboxFg3
hi! link javaParen5 GruvboxFg3
hi! link javaOperator GruvboxOrange

hi! link javaVarArg GruvboxGreen

# }}}
# Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter GruvboxGreen
hi! link elixirInterpolationDelimiter GruvboxAqua

hi! link elixirModuleDeclaration GruvboxYellow

# }}}
# Scala: {{{

# NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition GruvboxFg1
hi! link scalaCaseFollowing GruvboxFg1
hi! link scalaCapitalWord GruvboxFg1
hi! link scalaTypeExtension GruvboxFg1

hi! link scalaKeyword GruvboxRed
hi! link scalaKeywordModifier GruvboxRed

hi! link scalaSpecial GruvboxAqua
hi! link scalaOperator GruvboxFg1

hi! link scalaTypeDeclaration GruvboxYellow
hi! link scalaTypeTypePostDeclaration GruvboxYellow

hi! link scalaInstanceDeclaration GruvboxFg1
hi! link scalaInterpolation GruvboxAqua

# }}}
# Markdown: {{{

s:HL('markdownItalic', fg3, none, italic)

hi! link markdownH1 GruvboxGreenBold
hi! link markdownH2 GruvboxGreenBold
hi! link markdownH3 GruvboxYellowBold
hi! link markdownH4 GruvboxYellowBold
hi! link markdownH5 GruvboxYellow
hi! link markdownH6 GruvboxYellow

hi! link markdownCode GruvboxAqua
hi! link markdownCodeBlock GruvboxAqua
hi! link markdownCodeDelimiter GruvboxAqua

hi! link markdownBlockquote GruvboxGray
hi! link markdownListMarker GruvboxGray
hi! link markdownOrderedListMarker GruvboxGray
hi! link markdownRule GruvboxGray
hi! link markdownHeadingRule GruvboxGray

hi! link markdownUrlDelimiter GruvboxFg3
hi! link markdownLinkDelimiter GruvboxFg3
hi! link markdownLinkTextDelimiter GruvboxFg3

hi! link markdownHeadingDelimiter GruvboxOrange
hi! link markdownUrl GruvboxPurple
hi! link markdownUrlTitleDelimiter GruvboxGreen

s:HL('markdownLinkText', gray, none, underline)
hi! link markdownIdDeclaration markdownLinkText

# }}}
# Haskell: {{{

# hi! link haskellType GruvboxYellow
# hi! link haskellOperators GruvboxOrange
# hi! link haskellConditional GruvboxAqua
# hi! link haskellLet GruvboxOrange
#
hi! link haskellType GruvboxFg1
hi! link haskellIdentifier GruvboxFg1
hi! link haskellSeparator GruvboxFg1
hi! link haskellDelimiter GruvboxFg4
hi! link haskellOperators GruvboxBlue
#
hi! link haskellBacktick GruvboxOrange
hi! link haskellStatement GruvboxOrange
hi! link haskellConditional GruvboxOrange

hi! link haskellLet GruvboxAqua
hi! link haskellDefault GruvboxAqua
hi! link haskellWhere GruvboxAqua
hi! link haskellBottom GruvboxAqua
hi! link haskellBlockKeywords GruvboxAqua
hi! link haskellImportKeywords GruvboxAqua
hi! link haskellDeclKeyword GruvboxAqua
hi! link haskellDeriving GruvboxAqua
hi! link haskellAssocType GruvboxAqua

hi! link haskellNumber GruvboxPurple
hi! link haskellPragma GruvboxPurple

hi! link haskellString GruvboxGreen
hi! link haskellChar GruvboxGreen

# }}}
# Json: {{{

hi! link jsonKeyword GruvboxGreen
hi! link jsonQuote GruvboxGreen
hi! link jsonBraces GruvboxFg1
hi! link jsonString GruvboxFg1

# }}}


# Functions -------------------------------------------------------------------
# Search Highlighting Cursor {{{

def GruvboxHlsShowCursor()
s:HL('Cursor', bg0, hls_cursor)
enddef

def GruvboxHlsHideCursor()
s:HL('Cursor', none, none, inverse)
enddef

# }}}

# vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
