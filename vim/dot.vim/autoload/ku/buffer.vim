" ku source: buffer
" Version: 0.0.0
" Copyright (C) 2008 kana <http://whileimautomaton.net/>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Variables  "{{{1

let s:cached_items = []








" Interface  "{{{1
function! ku#buffer#on_start_session()  "{{{2
  " FIXME: better caching
  let _ = []
  for i in range(1, bufnr('$'))
    if bufexists(i) && buflisted(i)
      call add(_, {
      \      'word': bufname(i),
      \      'menu': printf('buffer %*d', len(bufnr('$')), i),
      \      'dup': 1,
      \      '_buffer_nr': i,
      \    })
    endif
  endfor
  let s:cached_items = _
  return
endfunction




function! ku#buffer#on_end_session()  "{{{2
  " Nothing to do.
  return
endfunction




function! ku#buffer#action_table()  "{{{2
  return {
  \   'Bottom': 'ku#buffer#action_Bottom',
  \   'Left': 'ku#buffer#action_Left',
  \   'Right': 'ku#buffer#action_Right',
  \   'Top': 'ku#buffer#action_Top',
  \   'above': 'ku#buffer#action_above',
  \   'below': 'ku#buffer#action_below',
  \   'default': 'ku#buffer#action_open',
  \   'left': 'ku#buffer#action_left',
  \   'open!': 'ku#buffer#action_open_x',
  \   'open': 'ku#buffer#action_open',
  \   'right': 'ku#buffer#action_right',
  \   'tab-Left': 'ku#buffer#action_tab_Left',
  \   'tab-Right': 'ku#buffer#action_tab_Right',
  \   'tab-left': 'ku#buffer#action_tab_left',
  \   'tab-right': 'ku#buffer#action_tab_right',
  \ }
endfunction




function! ku#buffer#key_table()  "{{{2
  return {
  \   "\<C-h>": 'left',
  \   "\<C-j>": 'below',
  \   "\<C-k>": 'above',
  \   "\<C-l>": 'right',
  \   "\<C-o>": 'open',
  \   "\<C-t>": 'tab-Right',
  \   'H': 'Left',
  \   'J': 'Bottom',
  \   'K': 'Top',
  \   'L': 'Right',
  \   'O': 'open!',
  \   'h': 'left',
  \   'j': 'below',
  \   'k': 'above',
  \   'l': 'right',
  \   'o': 'open',
  \   't': 'tab-Right',
  \ }
endfunction




function! ku#buffer#gather_items(pattern)  "{{{2
  return s:cached_items
endfunction








" Misc.  "{{{1
function! s:open(direction_modifier, item)  "{{{2
  if a:direction_modifier !~# '^here\>'
    execute a:direction_modifier 'split'
  endif
  let bang = (a:direction_modifier =~# '!$' ? '!' : '')

  if a:item._ku_completed_p
    execute a:item._buffer_nr 'buffer'.bang
  else
    execute 'edit'.bang '`=fnameescape(a:item.word)`'
  endif
endfunction




" Actions  "{{{2
function! ku#buffer#action_Bottom(item)  "{{{3
  call s:open('botright', a:item)
  return
endfunction


function! ku#buffer#action_Left(item)  "{{{3
  call s:open('vertical topleft', a:item)
  return
endfunction


function! ku#buffer#action_Right(item)  "{{{3
  call s:open('vertical botright', a:item)
  return
endfunction


function! ku#buffer#action_Top(item)  "{{{3
  call s:open('topleft', a:item)
  return
endfunction


function! ku#buffer#action_above(item)  "{{{3
  call s:open('aboveleft', a:item)
  return
endfunction


function! ku#buffer#action_below(item)  "{{{3
  call s:open('belowright', a:item)
  return
endfunction


function! ku#buffer#action_left(item)  "{{{3
  call s:open('vertical aboveleft', a:item)
  return
endfunction


function! ku#buffer#action_open(item)  "{{{3
  call s:open('here', a:item)
  return
endfunction


function! ku#buffer#action_open_x(item)  "{{{3
  call s:open('here!', a:item)
  return
endfunction


function! ku#buffer#action_right(item)  "{{{3
  call s:open('vertical belowright', a:item)
  return
endfunction


function! ku#buffer#action_tab_Left(item)  "{{{3
  call s:open('0 tab', a:item)
  return
endfunction


function! ku#buffer#action_tab_Right(item)  "{{{3
  call s:open(tabpagenr('$') . ' tab', a:item)
  return
endfunction


function! ku#buffer#action_tab_left(item)  "{{{3
  call s:open((tabpagenr() - 1) . ' tab', a:item)
  return
endfunction


function! ku#buffer#action_tab_right(item)  "{{{3
  call s:open('tab', a:item)
  return
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
