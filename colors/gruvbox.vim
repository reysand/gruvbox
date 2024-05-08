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
var gb.dark0       = ['#282828', 235]     # 40-40-40
var gb.dark0_soft  = ['#32302f', 236]     # 50-48-47
var gb.dark1       = ['#3c3836', 237]     # 60-56-54
var gb.dark2       = ['#504945', 239]     # 80-73-69
var gb.dark3       = ['#665c54', 241]     # 102-92-84
var gb.dark4       = ['#7c6f64', 243]     # 124-111-100
var gb.dark4_256   = ['#7c6f64', 243]     # 124-111-100

var gb.gray_245    = ['#928374', 245]     # 146-131-116
var gb.gray_244    = ['#928374', 244]     # 146-131-116

var gb.light0_hard = ['#f9f5d7', 230]     # 249-245-215
var gb.light0      = ['#fbf1c7', 229]     # 253-244-193
var gb.light0_soft = ['#f2e5bc', 228]     # 242-229-188
var gb.light1      = ['#ebdbb2', 223]     # 235-219-178
var gb.light2      = ['#d5c4a1', 250]     # 213-196-161
var gb.light3      = ['#bdae93', 248]     # 189-174-147
var gb.light4      = ['#a89984', 246]     # 168-153-132
var gb.light4_256  = ['#a89984', 246]     # 168-153-132

var gb.bright_red     = ['#fb4934', 167]     # 251-73-52
var gb.bright_green   = ['#b8bb26', 142]     # 184-187-38
var gb.bright_yellow  = ['#fabd2f', 214]     # 250-189-47
var gb.bright_blue    = ['#83a598', 109]     # 131-165-152
var gb.bright_purple  = ['#d3869b', 175]     # 211-134-155
var gb.bright_aqua    = ['#8ec07c', 108]     # 142-192-124
var gb.bright_orange  = ['#fe8019', 208]     # 254-128-25

var gb.neutral_red    = ['#cc241d', 124]     # 204-36-29
var gb.neutral_green  = ['#98971a', 106]     # 152-151-26
var gb.neutral_yellow = ['#d79921', 172]     # 215-153-33
var gb.neutral_blue   = ['#458588', 66]      # 69-133-136
var gb.neutral_purple = ['#b16286', 132]     # 177-98-134
var gb.neutral_aqua   = ['#689d6a', 72]      # 104-157-106
var gb.neutral_orange = ['#d65d0e', 166]     # 214-93-14

var gb.faded_red      = ['#9d0006', 88]      # 157-0-6
var gb.faded_green    = ['#79740e', 100]     # 121-116-14
var gb.faded_yellow   = ['#b57614', 136]     # 181-118-20
var gb.faded_blue     = ['#076678', 24]      # 7-102-120
var gb.faded_purple   = ['#8f3f71', 96]      # 143-63-113
var gb.faded_aqua     = ['#427b58', 66]      # 66-123-88
var gb.faded_orange   = ['#af3a03', 130]     # 175-58-3

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
  var bg0  = s:gb.dark0
  if g:gruvbox_contrast_dark == 'soft'
    var bg0  = s:gb.dark0_soft
  elseif g:gruvbox_contrast_dark == 'hard'
    var bg0  = s:gb.dark0_hard
  endif

  var bg1  = s:gb.dark1
  var bg2  = s:gb.dark2
  var bg3  = s:gb.dark3
  var bg4  = s:gb.dark4

  var gray = s:gb.gray_245

  var fg0 = s:gb.light0
  var fg1 = s:gb.light1
  var fg2 = s:gb.light2
  var fg3 = s:gb.light3
  var fg4 = s:gb.light4

  var fg4_256 = s:gb.light4_256

  var red    = s:gb.bright_red
  var green  = s:gb.bright_green
  var yellow = s:gb.bright_yellow
  var blue   = s:gb.bright_blue
  var purple = s:gb.bright_purple
  var aqua   = s:gb.bright_aqua
  var orange = s:gb.bright_orange
else
  var bg0  = s:gb.light0
  if g:gruvbox_contrast_light == 'soft'
    var bg0  = s:gb.light0_soft
  elseif g:gruvbox_contrast_light == 'hard'
    var bg0  = s:gb.light0_hard
  endif

  var bg1  = s:gb.light1
  var bg2  = s:gb.light2
  var bg3  = s:gb.light3
  var bg4  = s:gb.light4

  var gray = s:gb.gray_244

  var fg0 = s:gb.dark0
  var fg1 = s:gb.dark1
  var fg2 = s:gb.dark2
  var fg3 = s:gb.dark3
  var fg4 = s:gb.dark4

  var fg4_256 = s:gb.dark4_256

  var red    = s:gb.faded_red
  var green  = s:gb.faded_green
  var yellow = s:gb.faded_yellow
  var blue   = s:gb.faded_blue
  var purple = s:gb.faded_purple
  var aqua   = s:gb.faded_aqua
  var orange = s:gb.faded_orange
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
var gb.bg0 = s:bg0
var gb.bg1 = s:bg1
var gb.bg2 = s:bg2
var gb.bg3 = s:bg3
var gb.bg4 = s:bg4

var gb.gray = s:gray

var gb.fg0 = s:fg0
var gb.fg1 = s:fg1
var gb.fg2 = s:fg2
var gb.fg3 = s:fg3
var gb.fg4 = s:fg4

var gb.fg4_256 = s:fg4_256

var gb.red    = s:red
var gb.green  = s:green
var gb.yellow = s:yellow
var gb.blue   = s:blue
var gb.purple = s:purple
var gb.aqua   = s:aqua
var gb.orange = s:orange

# }}}
# Setup Terminal Colors For Neovim: {{{

if has('nvim')
  g:terminal_color_0 = s:bg0[0]
  g:terminal_color_8 = s:gray[0]

  g:terminal_color_1 = s:gb.neutral_red[0]
  g:terminal_color_9 = s:red[0]

  g:terminal_color_2 = s:gb.neutral_green[0]
  g:terminal_color_10 = s:green[0]

  g:terminal_color_3 = s:gb.neutral_yellow[0]
  g:terminal_color_11 = s:yellow[0]

  g:terminal_color_4 = s:gb.neutral_blue[0]
  g:terminal_color_12 = s:blue[0]

  g:terminal_color_5 = s:gb.neutral_purple[0]
  g:terminal_color_13 = s:purple[0]

  g:terminal_color_6 = s:gb.neutral_aqua[0]
  g:terminal_color_14 = s:aqua[0]

  g:terminal_color_7 = s:fg4[0]
  g:terminal_color_15 = s:fg1[0]
endif

# }}}
# Overload Setting: {{{

var hls_cursor = s:orange
if exists('g:gruvbox_hls_cursor')
  var hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

var number_column = s:none
if exists('g:gruvbox_number_column')
  var number_column = get(s:gb, g:gruvbox_number_column)
endif

var sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  var sign_column = s:number_column
else
  g:gitgutter_override_sign_column_highlight = 0

  if exists('g:gruvbox_sign_column')
    var sign_column = get(s:gb, g:gruvbox_sign_column)
  endif
endif

var color_column = s:bg1
if exists('g:gruvbox_color_column')
  var color_column = get(s:gb, g:gruvbox_color_column)
endif

var vert_split = s:bg0
if exists('g:gruvbox_vert_split')
  var vert_split = get(s:gb, g:gruvbox_vert_split)
endif

var invert_signs = ''
if exists('g:gruvbox_invert_signs')
  if g:gruvbox_invert_signs == 1
    var invert_signs = s:inverse
  endif
endif

var invert_selection = s:inverse
if exists('g:gruvbox_invert_selection')
  if g:gruvbox_invert_selection == 0
    var invert_selection = ''
  endif
endif

var invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
  if g:gruvbox_invert_tabline == 1
    var invert_tabline = s:inverse
  endif
endif

var italicize_comments = s:italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    var italicize_comments = ''
  endif
endif

var italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    var italicize_strings = s:italic
  endif
endif

# }}}
# Highlighting Function: {{{

def s:HL(group, fg, ...)
  # Arguments: group, guifg, guibg, gui, guisp

  # foreground
  var fg = a:fg

  # background
  if a:0 >= 1
    var bg = a:1
  else
    var bg = s:none
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
s:HL('GruvboxFg0', s:fg0)
s:HL('GruvboxFg1', s:fg1)
s:HL('GruvboxFg2', s:fg2)
s:HL('GruvboxFg3', s:fg3)
s:HL('GruvboxFg4', s:fg4)
s:HL('GruvboxGray', s:gray)
s:HL('GruvboxBg0', s:bg0)
s:HL('GruvboxBg1', s:bg1)
s:HL('GruvboxBg2', s:bg2)
s:HL('GruvboxBg3', s:bg3)
s:HL('GruvboxBg4', s:bg4)

s:HL('GruvboxRed', s:red)
s:HL('GruvboxRedBold', s:red, s:none, s:bold)
s:HL('GruvboxGreen', s:green)
s:HL('GruvboxGreenBold', s:green, s:none, s:bold)
s:HL('GruvboxYellow', s:yellow)
s:HL('GruvboxYellowBold', s:yellow, s:none, s:bold)
s:HL('GruvboxBlue', s:blue)
s:HL('GruvboxBlueBold', s:blue, s:none, s:bold)
s:HL('GruvboxPurple', s:purple)
s:HL('GruvboxPurpleBold', s:purple, s:none, s:bold)
s:HL('GruvboxAqua', s:aqua)
s:HL('GruvboxAquaBold', s:aqua, s:none, s:bold)
s:HL('GruvboxOrange', s:orange)
s:HL('GruvboxOrangeBold', s:orange, s:none, s:bold)

s:HL('GruvboxRedSign', s:red, s:sign_column, s:invert_signs)
s:HL('GruvboxGreenSign', s:green, s:sign_column, s:invert_signs)
s:HL('GruvboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
s:HL('GruvboxBlueSign', s:blue, s:sign_column, s:invert_signs)
s:HL('GruvboxPurpleSign', s:purple, s:sign_column, s:invert_signs)
s:HL('GruvboxAquaSign', s:aqua, s:sign_column, s:invert_signs)
s:HL('GruvboxOrangeSign', s:orange, s:sign_column, s:invert_signs)

# }}}

# Vanilla colorscheme ---------------------------------------------------------
# General UI: {{{

# Normal text
s:HL('Normal', s:fg1, s:bg0)

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
s:HL('CursorLine',   s:none, s:bg1)
  # Screen column that the cursor is
  hi! link CursorColumn CursorLine

  # Tab pages line filler
s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  # Active tab page label
s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  # Not active tab page label
  hi! link TabLine TabLineFill

  # Match paired bracket under the cursor
s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  # Highlighted screen columns
s:HL('ColorColumn',  s:none, s:color_column)

  # Concealed element: \lambda → λ
s:HL('Conceal', s:blue, s:none)

  # Line number of CursorLine
s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxBg2

s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

s:HL('Search',    s:yellow, s:bg0, s:inverse)
s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

s:HL('Underlined', s:blue, s:none, s:underline)

s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

# The column separating vertically split windows
s:HL('VertSplit', s:bg3, s:vert_split)

# Current match in wildmenu compvarion
s:HL('WildMenu', s:blue, s:bg2, s:bold)

# Directory names, special names in listing
hi! link Directory GruvboxGreenBold

# Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

# Error messages on the command line
s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
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
s:HL('LineNr', s:bg4, s:number_column)

# Column where signs are displayed
s:HL('SignColumn', s:none, s:sign_column)

# Line used for closed folds
s:HL('Folded', s:gray, s:bg1, s:italic)
# Column where folds are displayed
s:HL('FoldColumn', s:gray, s:bg1)

# }}}
# Cursor: {{{

# Character under cursor
s:HL('Cursor', s:none, s:none, s:inverse)
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
s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

s:HL('Comment', s:gray, s:none, s:italicize_comments)
s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

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
s:HL('String',  s:green, s:none, s:italicize_strings)
else
s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
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
s:HL('Pmenu', s:fg1, s:bg2)
  # Popup menu: selected item
s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  # Popup menu: scrollbar
s:HL('PmenuSbar', s:none, s:bg2)
  # Popup menu: scrollbar thumb
s:HL('PmenuThumb', s:none, s:bg4)
endif

# }}}
# Diffs: {{{

s:HL('DiffDevare', s:red, s:bg0, s:inverse)
s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
#s:HL('DiffChange', s:bg0, s:blue)
#s:HL('DiffText',   s:bg0, s:yellow)

# Alternative setting
s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

# }}}
# Spelling: {{{

if has("spell")
  # Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  # Not recognized word
s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  # Wrong spelling for selected region
s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  # Rare word
s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
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
s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

# }}}
# IndentLine: {{{

if !exists('g:indentLine_color_term')
  g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  g:indentLine_color_gui = s:bg2[0]
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

s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

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

s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

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
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

# }}}
# BufTabLine: {{{

s:HL('BufTabLineCurrent', s:bg0, s:fg4)
s:HL('BufTabLineActive', s:fg4, s:bg2)
s:HL('BufTabLineHidden', s:bg4, s:bg1)
s:HL('BufTabLineFill', s:bg0, s:bg0)

# }}}
# Asynchronous Lint Engine: {{{

s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

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

s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
s:HL('multiple_cursors_visual', s:none, s:bg2)

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

s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

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

s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar GruvboxOrange

s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

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

s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

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
s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
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

s:HL('markdownItalic', s:fg3, s:none, s:italic)

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

s:HL('markdownLinkText', s:gray, s:none, s:underline)
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
s:HL('Cursor', s:bg0, s:hls_cursor)
enddef

def GruvboxHlsHideCursor()
s:HL('Cursor', s:none, s:none, s:inverse)
enddef

# }}}

# vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
