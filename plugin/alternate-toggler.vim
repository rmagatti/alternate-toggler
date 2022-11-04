if exists('g:loaded_alternate_toggler') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

let s:LuaToggleAlternate = luaeval('require("alternate-toggler").toggleAlternate')

function ToggleAlternate()

  " Save user clipboard and register
  let s:save_clipboard = &clipboard
  set clipboard=
  let s:save_reg = getreg('"')
  let s:save_regmode = getregtype('"')

  normal! yiw
  let s:text_object = getreg('"')

  call s:LuaToggleAlternate(s:text_object)

  " Restore user clipboard and register
  call setreg('"', s:save_reg, s:save_regmode)
  let &clipboard = s:save_clipboard

endfunction

" Available commands
command! -nargs=* ToggleAlternate call ToggleAlternate()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_alternate_toggler = 1
