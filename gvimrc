if has("gui_win32")
    " Fullscreen takes up entire screen 
    " 'x' is accel for maximization of window in window menu. Can be different in localization.
    autocmd GUIEnter * :simalt ~x
endif

" Include local vim config
if filereadable(".gvimrc.local")
  source .gvimrc.local
endif
