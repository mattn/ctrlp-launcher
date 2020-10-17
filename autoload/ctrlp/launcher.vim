if exists('g:loaded_ctrlp_launcher') && g:loaded_ctrlp_launcher
  finish
endif
let g:loaded_ctrlp_launcher = 1

let s:launcher_var = {
\  'init':   'ctrlp#launcher#init()',
\  'exit':   'ctrlp#launcher#exit()',
\  'accept': 'ctrlp#launcher#accept',
\  'lname':  'launcher',
\  'sname':  'launcher',
\  'type':   'path',
\  'sort':   0,
\  'nolim':  1,
\}

let s:list = []
let s:profile = ''
let s:bang = ''

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:launcher_var)
else
  let g:ctrlp_ext_vars = [s:launcher_var]
endif

function! ctrlp#launcher#launch(bang, ...)
  let s:bang = a:bang
  let s:profile = get(a:000, 0, '')
  call ctrlp#init(ctrlp#launcher#id())
endfunction

function! ctrlp#launcher#init(...)
  let l:config_file = get(g:, 'ctrlp_launcher_file', '~/.ctrlp-launcher')
  if !empty(s:profile)
    let l:config_file .= '-' . s:profile
  endif
  let l:file = fnamemodify(expand(l:config_file), ':p')
  let s:list = filereadable(l:file) ? filter(map(readfile(l:file), 'split(iconv(v:val, "utf-8", &encoding), "\\t\\+")'), 'len(v:val) > 0 && v:val[0]!~"^#"') : []
  if empty(s:bang)
    let s:list += [['--edit-menu--', printf('split %s', fnameescape(l:config_file))]]
  endif
  return map(copy(s:list), 'v:val[0]')
endfunction

function! ctrlp#launcher#accept(mode, str)
  let l:lines = filter(copy(s:list), 'v:val[0] == a:str')
  call ctrlp#exit()
  redraw!
  if len(l:lines) > 0 && len(l:lines[0]) > 1
    let l:cmd = l:lines[0][1]
    if l:cmd =~ '^!'
      silent exe l:cmd
    else
      exe l:cmd
    endif
  endif
endfunction

function! ctrlp#launcher#exit()
  if exists('s:list')
    unlet! s:list
  endif
  let s:bang = ''
  let s:profile = ''
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#launcher#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
