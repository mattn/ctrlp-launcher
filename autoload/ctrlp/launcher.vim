if exists('g:loaded_ctrlp_launcher') && g:loaded_ctrlp_launcher
  finish
endif
let g:loaded_ctrlp_launcher = 1

let s:config_file = get(g:, 'ctrlp_launcher_file', '~/.ctrlp-launcher')

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

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:launcher_var)
else
  let g:ctrlp_ext_vars = [s:launcher_var]
endif

function! ctrlp#launcher#init()
  let file = fnamemodify(expand(s:config_file), ':p')
  let s:list = filereadable(file) ? filter(map(readfile(file), 'split(iconv(v:val, "utf-8", &encoding), "\\t\\+")'), 'len(v:val) > 0 && v:val[0]!~"^#"') : []
  let s:list += [["--edit-menu--", printf("split %s", s:config_file)]]
  return map(copy(s:list), 'v:val[0]')
endfunc

function! ctrlp#launcher#accept(mode, str)
  let lines = filter(copy(s:list), 'v:val[0] == a:str')
  call ctrlp#exit()
  redraw!
  if len(lines) > 0 && len(lines[0]) > 1
    let cmd = lines[0][1]
    if cmd =~ '^!'
      silent exe cmd
    else
      exe cmd
    endif
  endif
endfunction

function! ctrlp#launcher#exit()
  if exists('s:list')
    unlet! s:list
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#launcher#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
