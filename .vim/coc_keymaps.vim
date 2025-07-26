" Author: oQuintino
" Source: https://github.com/oQuintino/Dotfiles
" Description: Personal Coc.nvim keymaps loaded after CocNvimInit

function! ShowDocumentation() abort
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! s:setup_coc_keymaps() abort
  " Snippet mappings
  imap <C-l> <Plug>(coc-snippets-expand)
  vmap <C-j> <Plug>(coc-snippets-select)
  imap <C-j> <Plug>(coc-snippets-expand-jump)
  xmap <leader>x <Plug>(coc-convert-snippet)

  " Completion (TAB)
  inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) :
        \ s:check_back_space() ? "\<Tab>" : coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Diagnostics
  nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
  nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

  " Navigation
  nmap <silent><nowait> gd <Plug>(coc-definition)
  nmap <silent><nowait> gy <Plug>(coc-type-definition)
  nmap <silent><nowait> gi <Plug>(coc-implementation)
  nmap <silent><nowait> gr <Plug>(coc-references)

  " Hover doc
  nnoremap <silent> K :call ShowDocumentation()<CR>
endfunction

if exists('*s:setup_coc_keymaps')
  call s:setup_coc_keymaps()
endif
