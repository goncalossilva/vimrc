"""""""""""
" Config. "
"""""""""""

" Set unicode encoding.
scriptencoding utf-8
set encoding=utf-8

" Set color scheme.
set termguicolors
colorscheme darcula
call darcula#Hi('Cursor', ['#2B2B2B', 235], ['#BBBBBB', 250])

" Disable cursor blinking.
set guicursor=a:blinkon0

" Setup command line bar.
set noshowmode    " Hide mode (e.g. --INSERT--).
set noshowcmd     " Hide last command.
set shortmess+=F  " Hide file name.

" Setup number column.
set number
set signcolumn=number

" Use relative numbers in normal model, absolute numbers otherwise.
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if mode() != "i" | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * set nornu
augroup END

" Highlight cursor line.
set cursorline

" Set title.
set title
set titlestring=%-25.55F\ %a%r%m titlelen=70

" Set encoding.
set encoding=utf8

" Show whitespace characters (overrides vim-sensible).
set showbreak=↪\
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:•,trail:·
set list

" Enable mouse support.
set mouse=a
set ttymouse=xterm

if has("gui_running")
  " Set font.
  if has("linux")
    set guifont=Consolas\ 10,Monospace\ 10
  else
    set guifont=Consolas:h14,Monaco:h12,Monospace:h12
  endif
  set linespace=2

  " Hide scrollbars, menu bars, toolbars, and tab pages.
  set guioptions-=r
  set guioptions-=L
  set guioptions-=b
  set guioptions-=T
  set guioptions-=m
  set guioptions-=e

  " Use dark theme variant if available.
  set guioptions+=d

  " Set starting size in GUI mode.
  set lines=50 columns=120
endif

" Sync clipboard with system.
set clipboard^=unnamed,unnamedplus

" Disable beeping.
set belloff=all

" Disable Ex mode.
map Q gq

" Indentation defaults (gated to not override vim-sleuth).
if get(g:, '_has_set_default_indent_settings', 0) == 0
  " Set the indenting level to 2 spaces for the following file types.
  autocmd FileType elixir,html,lua,ruby,scala,vim,yaml
\   setlocal ts=2 sts=2 sw=2 expandtab
  set ts=4 sts=4 sw=4 expandtab
  let g:_has_set_default_indent_settings = 1
endif
set shiftround

" Add cut command (complements vim-cutlass).
nnoremap x d
xnoremap x d
nnoremap xx dd
nnoremap X D

" Split to the right and bottom by default.
set splitbelow
set splitright

" Hide current buffer when opening a new file.
set hidden

" No screen updates during macro or script execution.
set lazyredraw

" Make regex chars have special meaning by default.
set magic

" Persistent undo (ensure private access, e.g., 0700).
set undodir=~/.vim-undo/
set undofile

" Disable backups.
set nobackup
set nowritebackup
set noswapfile

" Jump to last known position when reopening a file.
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif

" Leader is space.
let mapleader=" "
nmap <space> <leader>

" Move between buffers.
map <leader>bl :bnext<CR>
map <leader>bh :bprevious<CR>

" Move a line of text up and down.
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Toggle modes: paste, spellchecker.
map <leader>pp :setlocal paste!<cr>
map <leader>ss :setlocal spell!<cr>

" Set colorcolumn to textwidth.
function! s:SetColorColumn()
  if &textwidth == 0
    setlocal colorcolumn=
  else
    setlocal colorcolumn=+0
  endif
endfunction
augroup colorcolumn
  autocmd!
  autocmd OptionSet textwidth call s:SetColorColumn()
  autocmd BufEnter * call s:SetColorColumn()
augroup end


""""""""""""
" Plugins. "
""""""""""""

" lightline.vim.
let g:lightline = {
\ 'colorscheme': 'darculaOriginal',
\ 'active': {
\   'left': [
\      ['mode', 'paste'],
\      ['readonly', 'filename', 'modified'],
\      ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos'],
\   ],
\   'right': [
\      ['lineinfo'],
\      ['percent'],
\      ['fileformat', 'fileencoding', 'filetype', 'sleuth'],
\   ],
\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'sleuth': 'SleuthIndicator',
\ },
\ 'component_type': {
\   'linter_checking': 'middle',
\   'linter_infos': 'info',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\ },
\}

" lightline-ale.
let g:lightline#ale#indicator_checking = ' …'
let g:lightline#ale#indicator_errors = ' '
let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_infos = ' '

" nerdtree.
let g:NERDTreeChDirMode = 2
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>

" fzf.
let g:fzf_colors = {
\ 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'],
\}
nnoremap <leader>o :Files<CR>
nnoremap <leader>O :GFiles<CR>
nnoremap <leader>f :Rg!<CR>

" vim-sneak.
map s <Plug>Sneak_s
map S <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
hi! link Sneak Search

" vim-easy-align.
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ale.
"
" Aids in editing files by fixing (enabled explicitly),
" linting (enabled by default) and completing (LSPs + tsserver).
" Runtimes, linters and LSPs must be installed and available in $PATH.
"
" The defaults below rely on runtimes being installed and tools in $PATH
" or in `$HOME/.vim-ale`. To install them there instead of globally:
"
" mkdir -p $HOME/.vim-ale/{pip,npm,gem,go,git}
" #pip install --target="$HOME/.vim-ale/pip" black pylint mypy python-language-server gitlint
" pip install --target="$HOME/.vim-ale/pip" black flake8 mypy python-language-server gitlint
" npm install --prefix="$HOME/.vim-ale/npm" bash-language-server vim-language-server \
"   prettier prettier-eslint eslint typescript htmlhint
" gem install --install-dir="$HOME/.vim-ale/gem" rubocop solargraph
" GOPATH="$HOME/.vim-ale/go" go get honnef.co/go/tools/cmd/staticcheck
" GOPATH="$HOME/.vim-ale/go" GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
" git clone https://github.com/elixir-lsp/elixir-ls.git $HOME/.vim-ale/git/elixir-ls && \
" cd $HOME/.vim-ale/git/elixir-ls && mix deps.get && mix compile && mix elixir_ls.release
"
" TODO: Java, Kotlin, Rust, Swift.
" TODO: 'python':     ['pylint', 'mypy', 'pyls'],
let g:ale_linters = {
\ 'elixir':     ['mix', 'elixir-ls'],
\ 'go':         ['staticcheck', 'gopls'],
\ 'python':     ['flake8', 'mypy', 'pyls'],
\ 'ruby':       ['ruby', 'rubocop', 'solargraph'],
\ 'typescript': ['eslint', 'tsserver'],
\ 'vim':        ['vimls'],
\}
let g:ale_fixers = {
\ 'css':            ['prettier'],
\ 'elixir':         ['mix_format'],
\ 'go':             ['gofmt'],
\ 'javascript':     ['prettier_eslint'],
\ 'javascript.jsx': ['prettier_eslint'],
\ 'less':           ['prettier'],
\ 'markdown':       ['prettier'],
\ 'python':         ['black'],
\ 'ruby':           ['rubocop'],
\ 'scss':           ['prettier'],
\ 'sh':             ['shfmt'],
\ 'typescript':     ['prettier_eslint'],
\ 'yaml':           ['prettier'],
\}
let $PYTHONPATH .= $HOME.'/.vim-ale/pip'
let $PATH .= ':'.$HOME.'/.vim-ale/pip/bin'
let $PATH .= ':'.$HOME.'/.vim-ale/npm/node_modules/.bin'
let $PATH .= ':'.$HOME.'/.vim-ale/gem/bin'
let $PATH .= ':'.$HOME.'/.vim-ale/go/bin'
let g:ale_elixir_elixir_ls_release = $HOME.'/.vim-ale/git/elixir-ls/release'
let g:ale_go_staticcheck_lint_package = 1
let g:ale_dockerfile_hadolint_use_docker = 'yes'
" Fix on save.
let g:ale_fix_on_save = 1
" Shortcuts.
nnoremap <leader>h :ALEHover<CR>
nnoremap <leader>F :ALESymbolSearch<CR>
" Cycle between errors.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Enable completion.
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
" Use Tab and Shift+Tab to cycle between completions.
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" Leverage LSP to go to definition and find references.
function ALELSPMappings()
  let l:lsp_found=0
  for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found=1 | endif | endfor
  if (l:lsp_found)
    nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
    nnoremap <buffer> <C-^> :ALEFindReferences<CR>
    nnoremap <buffer> <leader>r :ALERename<CR>
  else
    silent! unmap <buffer> <C-]>
    silent! unmap <buffer> <C-^>
    silent! unmap <buffer> <leader>r
  endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()
hi! link ALEError Error
hi! link ALEWarning CodeWarning
hi! link ALEInfo CodeInfo
hi! link ALEErrorSign ErrorSign
hi! link ALEWarningSign WarningSign
hi! link ALEInfoSign InfoSign

" vim-test.
nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tg :TestVisit<CR>
let test#strategy = "vimterminal"

" Load all plugins now and generate help tags.
packloadall
silent! helptags ALL
