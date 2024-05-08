" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 09 Apr 2014
" -----------------------------------------------------------------------------

vim9script

def gruvbox#invert_signs_toggle()
  if g:gruvbox_invert_signs == 0
    g:gruvbox_invert_signs=1
  else
    g:gruvbox_invert_signs=0
  endif

  colorscheme gruvbox
enddef

# Search Highlighting {{{

def gruvbox#hls_show()
  set hlsearch
  GruvboxHlsShowCursor()
enddef

def gruvbox#hls_hide()
  set nohlsearch
  GruvboxHlsHideCursor()
enddef

def gruvbox#hls_toggle()
  if &hlsearch
    gruvbox#hls_hide()
  else
    gruvbox#hls_show()
  endif
enddef

# }}}

# vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
