" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Gruvbox colorscheme for Lightline (itchyny/lightline.vim)
" Author: gmoe <me@griffinmoe.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 20 Sep 2017
" -----------------------------------------------------------------------------

vim9script

def s:getGruvColor(group)
  var guiColor = synIDattr(hlID(a:group), "fg", "gui") 
  var termColor = synIDattr(hlID(a:group), "fg", "cterm") 
  return [ guiColor, termColor ]
enddef

if exists('g:lightline')

  var s:bg0  = s:getGruvColor('GruvboxBg0')
  var s:bg1  = s:getGruvColor('GruvboxBg1')
  var s:bg2  = s:getGruvColor('GruvboxBg2')
  var s:bg4  = s:getGruvColor('GruvboxBg4')
  var s:fg1  = s:getGruvColor('GruvboxFg1')
  var s:fg4  = s:getGruvColor('GruvboxFg4')

  var s:yellow = s:getGruvColor('GruvboxYellow')
  var s:blue   = s:getGruvColor('GruvboxBlue')
  var s:aqua   = s:getGruvColor('GruvboxAqua')
  var s:orange = s:getGruvColor('GruvboxOrange')
  var s:green = s:getGruvColor('GruvboxGreen')

  var s:p = {'normal':{}, 'inactive':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'tabline':{}, 'terminal':{}}
  var s:p.normal.left = [ [ s:bg0, s:fg4, 'bold' ], [ s:fg4, s:bg2 ] ]
  var s:p.normal.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  var s:p.normal.middle = [ [ s:fg4, s:bg1 ] ]
  var s:p.inactive.right = [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
  var s:p.inactive.left =  [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
  var s:p.inactive.middle = [ [ s:bg4, s:bg1 ] ]
  var s:p.insert.left = [ [ s:bg0, s:blue, 'bold' ], [ s:fg1, s:bg2 ] ]
  var s:p.insert.right = [ [ s:bg0, s:blue ], [ s:fg1, s:bg2 ] ]
  var s:p.insert.middle = [ [ s:fg4, s:bg2 ] ]
  var s:p.terminal.left = [ [ s:bg0, s:green, 'bold' ], [ s:fg1, s:bg2 ] ]
  var s:p.terminal.right = [ [ s:bg0, s:green ], [ s:fg1, s:bg2 ] ]
  var s:p.terminal.middle = [ [ s:fg4, s:bg2 ] ]
  var s:p.replace.left = [ [ s:bg0, s:aqua, 'bold' ], [ s:fg1, s:bg2 ] ]
  var s:p.replace.right = [ [ s:bg0, s:aqua ], [ s:fg1, s:bg2 ] ]
  var s:p.replace.middle = [ [ s:fg4, s:bg2 ] ]
  var s:p.visual.left = [ [ s:bg0, s:orange, 'bold' ], [ s:bg0, s:bg4 ] ]
  var s:p.visual.right = [ [ s:bg0, s:orange ], [ s:bg0, s:bg4 ] ]
  var s:p.visual.middle = [ [ s:fg4, s:bg1 ] ]
  var s:p.tabline.left = [ [ s:fg4, s:bg2 ] ]
  var s:p.tabline.tabsel = [ [ s:bg0, s:fg4 ] ]
  var s:p.tabline.middle = [ [ s:bg0, s:bg0 ] ]
  var s:p.tabline.right = [ [ s:bg0, s:orange ] ]
  var s:p.normal.error = [ [ s:bg0, s:orange ] ]
  var s:p.normal.warning = [ [ s:bg2, s:yellow ] ]

  g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(s:p)
endif
