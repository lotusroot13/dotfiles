
""" init.vimrc

"""""""""""" Plugins managed by vim-plug
"""""""""""" Auto-completion by nvim-completion-manager
call plug#begin('~/.config/nvim/plugged')
""" UI
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'artanikin/vim-synthwave84'
Plug 'sts10/vim-pink-moon'
""" LSP
Plug 'tpope/vim-sensible'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}
""" Fuzzy Search
" Replacement for ctrlp: Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" vim-picker using fzy and ripgrep
Plug 'srstevenson/vim-picker'
" use fzy and ripgrep, fastest, map key to ctrl+p: ':FuzzyOpen'
Plug 'cloudhead/neovim-fuzzy'
""" General, editing
" Language packages
Plug 'sheerun/vim-polyglot'
" Indentline marking
Plug 'Yggdroot/indentLine'
" Insert, delete brackets
Plug 'jiangmiao/auto-pairs'
" multiple selection like sublime text
Plug 'terryma/vim-multiple-cursors'
" comment
Plug 'tpope/vim-commentary'
""" Snippets
" engine
Plug 'SirVer/ultisnips'
" snippets
Plug 'honza/vim-snippets'
""" javascript, jsx
" syntax highlighting
Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx', this causes indentation bug in react js files
" snippets: react
Plug 'epilande/vim-react-snippets'
" CSS color
Plug 'ap/vim-css-color'

" Make sure you use single quotes


""" UI

" vim-airline for vim status bar
" let g:airline_theme='nord'

" color scheme Nord
" let g:nord_cursor_line_number_background = 1

" Note, the above line is ignored in Neovim 0.1.5 above, use this line instead.
set termguicolors
" bug: "colorscheme synthwave84" doesn't work
" solution: https://vi.stackexchange.com/questions/5567/non-default-colorschemes-cant-be-loaded-setting-them-manually-after-startup-wo
autocmd VimEnter * colorscheme synthwave84
set background= "dark"



""" LSP/auto-complete

""" coc.nvim
" note: have to put coc config at front of init.vim

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""" General

""" fuzzy search
let g:picker_custom_find_executable = 'rg'
let g:picker_custom_find_flags = '--color never --files'
nnoremap <C-p> :PickerEdit<CR>

" error E117
" https://www.rockyourcode.com/vim-e-117-unknown-function-styledcomplete-complete-sc/
let g:polyglot_disabled = ['javascript']

""" Editing


""" Snippets
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


"""""" Auto-complete
""" deoplete: only for ocaml currently
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins', 'for': 'ocaml'}
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

" Python, jedi
"Plug 'zchee/deoplete-jedi'
"Plug 'davidhalter/jedi-vim', {'for': 'python'}

" ocaml, deoplete-ocaml
" Plug 'copy/deoplete-ocaml', {'for': 'ocaml'}


""" html, emmet
Plug 'mattn/emmet-vim'
" enable just for html, css
" let g:user_emmet_install_global = 0
" redefine emmet trigger key"
" let g:user_emmet_leader_key=','
" let g:user_emmet_settings = {
" \  'javascript.jsx' : {
" \      'extends' : 'jsx',
" \  },
" \}
" autocmd FileType html,css,javascript.jsx EmmetInstall

""" ncm2: for other languages
" ncm2
" assuming your using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
"
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

" Python
Plug 'ncm2/ncm2-jedi', {'for': 'python'}
" Disable lsp for python: github.com/ncm2/ncm2/issues/60
autocmd BufEnter * call ncm2#override_source('LanguageClient_python', {'enable': 0})




"""""" linting/fixing
" manager
Plug 'w0rp/ale'
let g:ale_linters = {
\   'python': ['pylint'],
\}

""" on-demand

" Python
" mypy: type checking for Python
" Plug 'Integralist/vim-mypy', {'for': 'python'}


"""""" Orgmode

" Plug 'jceb/vim-orgmode'


"""""" Other




"""""""""""" UI Settings

" default was changed to dark from light, I like light
set background=light

" Line number on startup
set number

" Show last command in bottom right
set showcmd

" Highlight current line
set cursorline


" Set tab to 4 spaces
filetype plugin indent on
set expandtab
" Filetype indent
" http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
autocmd FileType ocaml setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType c setlocal shiftwidth=4 tabstop=4
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2

""" UI plugins
" airline status bar


"""""""""""" Linting

""" Ale

" " Enable completion where available.
" let g:ale_completion_enabled = 1
" 
" let g:ale_sign_column_always = 0
" 
" " Set this in your vimrc file to disabling highlighting
" let g:ale_set_highlights = 1
" highlight ALEWarning ctermbg=DarkGray
" 
" let b:ale_set_balloons = 0
" 
" " Set this. Airline will handle the rest.
" let g:airline#extensions#ale#enabled = 1


"""""""""""" Settings for different languages

""" ocaml
" ocaml Merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" " deoplete-ocaml
" " this is the default, make sure it is not set to "omnifunc" somewhere else in your vimrc
" let g:deoplete#complete_method = "complete"
" " other completion sources suggested to disable
" let g:deoplete#ignore_sources = {}
" let g:deoplete#ignore_sources.ocaml = ['buffer', 'around', 'member', 'tag']
" " no delay before completion
" let g:deoplete#auto_complete_delay = 0




" Add plugins to &runtimepath
call plug#end()
""""""""""""
