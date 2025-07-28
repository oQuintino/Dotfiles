" Author: oQuintino
" Source: https://github.com/oQuintino/Dotfiles
" Description: Personal Coc.nvim keymaps loaded after CocNvimInit
" Adapted From: https://github.com/neoclide/coc.nvim?tab=readme-ov-file#example-vim-configuration


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

  " Refactorings
  nmap <leader>rn <Plug>(coc-rename)
  nmap <leader>ac <Plug>(coc-codeaction)
  xmap <leader>ac <Plug>(coc-codeaction-selected)
  nmap <leader>qf <Plug>(coc-fix-current)

  nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
  xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
  nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

  " Hover doc
  nnoremap <silent> K :call ShowDocumentation()<CR>

  " Floating window scroll
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Text objects
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)
endfunction

augroup CocKeymaps
  autocmd!
  autocmd User CocNvimInit ++once call s:setup_coc_keymaps()
augroup END
