" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Airline
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------

vim9script

g:airline#themes#gruvbox#palette = {}

def airline#themes#gruvbox#refresh()

  var M0 = airline#themes#get_highlight('Identifier')
  var accents_group = airline#themes#get_highlight('Special')
  var modified_group = [M0[0], '', M0[2], '', '']
  var warning_group = airline#themes#get_highlight2(['Normal', 'bg'], ['Question', 'fg'])
  var error_group = airline#themes#get_highlight2(['Normal', 'bg'], ['WarningMsg', 'fg'])

  var s:N1 = airline#themes#get_highlight2(['Normal', 'bg'], ['StatusLineNC', 'bg'])
  var s:N2 = airline#themes#get_highlight2(['StatusLineNC', 'bg'], ['Pmenu', 'bg'])
  var s:N3 = airline#themes#get_highlight2(['StatusLineNC', 'bg'], ['CursorLine', 'bg'])
  g:airline#themes#gruvbox#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
  g:airline#themes#gruvbox#palette.normal_modified = { 'airline_c': modified_group }
  g:airline#themes#gruvbox#palette.normal.airline_warning = warning_group
  g:airline#themes#gruvbox#palette.normal_modified.airline_warning = warning_group
  g:airline#themes#gruvbox#palette.normal.airline_error = error_group
  g:airline#themes#gruvbox#palette.normal_modified.airline_error = error_group

  var s:I1 = airline#themes#get_highlight2(['Normal', 'bg'], ['Identifier', 'fg'])
  var s:I2 = s:N2
  var s:I3 = airline#themes#get_highlight2(['Normal', 'fg'], ['Pmenu', 'bg'])
  g:airline#themes#gruvbox#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  g:airline#themes#gruvbox#palette.insert_modified = g:airline#themes#gruvbox#palette.normal_modified
  g:airline#themes#gruvbox#palette.insert.airline_warning = g:airline#themes#gruvbox#palette.normal.airline_warning
  g:airline#themes#gruvbox#palette.insert_modified.airline_warning = g:airline#themes#gruvbox#palette.normal_modified.airline_warning
  g:airline#themes#gruvbox#palette.insert.airline_error = g:airline#themes#gruvbox#palette.normal.airline_error
  g:airline#themes#gruvbox#palette.insert_modified.airline_error = g:airline#themes#gruvbox#palette.normal_modified.airline_error

  var s:R1 = airline#themes#get_highlight2(['Normal', 'bg'], ['Structure', 'fg'])
  var s:R2 = s:I2
  var s:R3 = s:I3
  g:airline#themes#gruvbox#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
  g:airline#themes#gruvbox#palette.replace_modified = g:airline#themes#gruvbox#palette.normal_modified
  g:airline#themes#gruvbox#palette.replace.airline_warning = g:airline#themes#gruvbox#palette.normal.airline_warning
  g:airline#themes#gruvbox#palette.replace_modified.airline_warning = g:airline#themes#gruvbox#palette.normal_modified.airline_warning
  g:airline#themes#gruvbox#palette.replace.airline_error = g:airline#themes#gruvbox#palette.normal.airline_error
  g:airline#themes#gruvbox#palette.replace_modified.airline_error = g:airline#themes#gruvbox#palette.normal_modified.airline_error

  var s:V1 = airline#themes#get_highlight2(['Normal', 'bg'], ['Question', 'fg'])
  var s:V2 = s:N2
  var s:V3 = airline#themes#get_highlight2(['Normal', 'bg'], ['TabLine', 'fg'])
  g:airline#themes#gruvbox#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
  g:airline#themes#gruvbox#palette.visual_modified = { 'airline_c': [ s:V3[0], '', s:V3[2], '', '' ] }
  g:airline#themes#gruvbox#palette.visual.airline_warning = g:airline#themes#gruvbox#palette.normal.airline_warning
  g:airline#themes#gruvbox#palette.visual_modified.airline_warning = g:airline#themes#gruvbox#palette.normal_modified.airline_warning
  g:airline#themes#gruvbox#palette.visual.airline_error = g:airline#themes#gruvbox#palette.normal.airline_error
  g:airline#themes#gruvbox#palette.visual_modified.airline_error = g:airline#themes#gruvbox#palette.normal_modified.airline_error

  var s:IA = airline#themes#get_highlight2(['TabLine', 'fg'], ['CursorLine', 'bg'])
  g:airline#themes#gruvbox#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
  g:airline#themes#gruvbox#palette.inactive_modified = { 'airline_c': modified_group }

  g:airline#themes#gruvbox#palette.accents = { 'red': accents_group }

  var s:TF = airline#themes#get_highlight2(['Normal', 'bg'], ['Normal', 'bg'])
  g:airline#themes#gruvbox#palette.tabline = {
    \ 'airline_tab':  s:N2,
    \ 'airline_tabsel':  s:N1,
    \ 'airline_tabtype':  s:V1,
    \ 'airline_tabfill':  s:TF,
    \ 'airline_tabhid':  s:IA,
    \ 'airline_tabmod':  s:I1
    \ }

enddef

airline#themes#gruvbox#refresh()

# vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
