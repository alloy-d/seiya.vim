if exists('g:loaded_seiya')
  finish
endif
let g:loaded_seiya = 1

let s:save_cpo = &cpo
set cpo&vim

let g:seiya_target_groups = get(g:, 'seiya_target_groups', ['ctermbg'])
let g:seiya_target_highlights = get(g:, 'seiya_target_highlights', [
      \ 'Normal',
      \ 'LineNr',
      \ 'CursorLineNr',
      \ 'SignColumn',
      \ 'VertSplit',
      \ 'NonText',
      \])

function! s:clear_bg(hl)
  for group in g:seiya_target_groups
    execute 'highlight ' . a:hl . ' ' . group . '=None'
  endfor
endfunction

function! s:clear_bg_all()
  for hl in g:seiya_target_highlights
    call s:clear_bg(hl)
  endfor
endfunction

function! s:clear_auto()
  call s:clear_bg_all()
  augroup seiya_auto
    autocmd!
    autocmd ColorScheme * call s:clear_bg_all()
  augroup END
endfunction

function! s:disable()
  autocmd! seiya_auto
  let l:colors_name = get(g:, 'colors_name', '')
  echomsg l:colors_name
  if l:colors_name !=# ''
    try
      execute 'colorscheme ' . l:colors_name
    endtry
  endif
endfunction

command! SeiyaEnable call s:clear_auto()
command! SeiyaDisable call s:disable()

augroup seiya_auto
  if get(g:, 'seiya_auto_enable', 0)
    autocmd VimEnter * execute "call s:clear_auto()"
  endif
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:set ts=2:set sw=2:
