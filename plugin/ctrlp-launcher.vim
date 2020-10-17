command! -nargs=? CtrlPLauncher call ctrlp#launcher#launch(<f-args>)

nnoremap <plug>(ctrlp-launcher) :<c-u>CtrlPLauncher<cr>
