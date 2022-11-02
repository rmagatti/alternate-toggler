if exists('g:loaded_alternate_toggler') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

let LuaToggleAlternate = luaeval('require("alternate-toggler").toggleAlternate')

" Available commands
command! -nargs=* ToggleAlternate call LuaToggleAlternate(expand('<cWORD>'))

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_alternate_toggler = 1
