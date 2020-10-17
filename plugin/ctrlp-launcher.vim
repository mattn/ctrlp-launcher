command! -bang -nargs=? CtrlPLauncher call ctrlp#launcher#launch('<bang>', <f-args>)

nnoremap <plug>(ctrlp-launcher) :<c-u>CtrlPLauncher<cr>
