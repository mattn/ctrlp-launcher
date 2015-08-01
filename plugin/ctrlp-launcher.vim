command! CtrlPLauncher cal ctrlp#init(ctrlp#launcher#id())

nnoremap <plug>(ctrlp-launcher) :<c-u>CtrlPLauncher<cr>
