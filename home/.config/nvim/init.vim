" Install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Leader
let mapleader = ","

call plug#begin('~/.config/nvim/plugged')

Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'marko-cerovac/material.nvim'

Plug 'editorconfig/editorconfig-vim'
Plug 'google/vim-searchindex'
Plug 'mhinz/vim-grepper'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
" Plug 'matze/vim-move'  " bindings not working?!?!?
Plug 'rhysd/committia.vim' " git commit view
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'
Plug 'yogeshdhamija/terminal-command-motion.vim'

" jsonc (tsconfig.json, coc-settings.json, etc.)
" Plug 'kevinoid/vim-json'
"
" Plug 'tbastos/vim-lua'
" Plug 'elmcast/elm-vim', { 'for': 'elm' }
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" == TypeScript and JavaScript  ==
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'jason0x43/vim-js-indent'

" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
"
" NB: coc-tsserver needs watchman available for auto refactors when renaming files via `:CocCommand
" workspace.renameCurrentFile`.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-eslint8',
  \ 'coc-json',
  \ 'coc-sh',
  \ ]

let g:terminal_command_motion_prompt_matcher = '^[~/].*\n❯'

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
  elseif (coc#rpc#ready() && CocHasProvider('hover'))
    silent call CocActionAsync('doHover')
  endif
endfunction

augroup Coc
  au!

  " Highlight the symbol and its references when holding the cursor.
  " au CursorHold * silent call CocActionAsync('highlight')

  " au CursorHold * silent call <SID>show_documentation()
  au FileType lua,javascript,javascriptreact,typescript,typescriptreact map <buffer> <C-]> <Plug>(coc-definition)
augroup END

nmap <silent> gd  <Plug>(coc-definition)
nmap <silent> gy  <Plug>(coc-type-definition)
nmap <silent> gr  <Plug>(coc-references)
nmap <silent> [g  <Plug>(coc-diagnostic-prev)
nmap <silent> ]g  <Plug>(coc-diagnostic-next)

" Show available lists
nnoremap <leader>d  :<C-u>CocList diagnostics<CR>
nnoremap <leader>c  :<C-u>CocList commands<CR>

" List of workspace symbols
nnoremap <leader>s  :<C-u>CocList -I symbols<CR>

" Run a quick-fix
nmap <leader>qf  <Plug>(coc-codeaction)

" Rename a symbol.
nmap <leader>rn  <Plug>(coc-rename)

" Format selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Plug 'adelarsq/vim-emoji-icon-theme'

" Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

Plug 'windwp/windline.nvim'

" Plug 'adelarsq/neoline.vim'
" Plug 'airblade/vim-gitgutter'
" Plug 'nathanaelkane/vim-indent-guides'

" Plug 'codota/tabnine-vim'

call plug#end()

" TypeScript config {{{1

augroup JavaScriptTypeScript
  au!
  au FileType javascript,javascriptreact,typescript,typescriptreact setlocal
      \ smartindent
      \ softtabstop=4
      \ shiftwidth=4
      \ expandtab

augroup END

" }}}1

augroup Lua
  au!
  au FileType lua setlocal
        \ smartindent
        \ softtabstop=4
        \ shiftwidth=4
        \ noexpandtab
augroup END

" elmcast/elm-vim
let g:elm_format_autosave = 1

" deoplete
" let g:deoplete#enable_at_startup = 1

let g:highlightedyank_highlight_duration = 300

" General editor settings
colorscheme challenger_deep
set linebreak       " Break lines when appropriate
set smartindent
set softtabstop=2
set tabstop=4
set shiftwidth=2
set expandtab
set textwidth=100

if has('mouse')
  set mouse=a
endif

set laststatus=2
set number
set ruler
set nojoinspaces    " Prevent inserting two spaces after punctuation on a join
set synmaxcol=400   " Don't try to highlight ridiculously long lines.
" set shell=zsh\ -l

set hidden
set updatetime=300
set shortmess+=c
set signcolumn=number

if exists('+colorcolumn')
  set colorcolumn=+1
endif

if exists('+spelllang')
  set spelllang=en_us
  set spell
endif

let &backupdir=expand('$HOME') . '/.config/nvim/tmp/backup//'
let &directory=expand('$HOME') . '/.config/nvim/tmp/swap//'

" Make those folders automatically if they don't already exist.
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
if !isdirectory(&directory)
  call mkdir(&directory, 'p')
endif

set backup
set swapfile

if has('persistent_undo')
  let myUndoDir = expand('$HOME') . '/.config/nvim/tmp/undo//'
  if !isdirectory(myUndoDir)
    call mkdir(myUndoDir, 'p')
  endif
  let &undodir = myUndoDir
  set undofile
endif

" Wildmenu
set wildmenu
set wildmode=list:longest
set wildignore+=*tmp/*,*.swp,*.zip,*.gz
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.so,*.o,*.a,*.manifest          " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " macOS bullshit
set wildignore+=*.orig                           " Merge resolution files

" Vimwiki
let g:vimwiki_list = [{'path': '~/Sync/wiki/', 'syntax': 'markdown'}]
let g:vimwiki_filetypes = ['markdown']
augroup VimWiki
  au!
  au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab
augroup END

" Cursorline

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" === Keybindings ===

nnoremap <M-[> :tabprev<CR>
nnoremap <M-]> :tabnext<CR>
inoremap <M-[> <Esc>:tabprev<CR>
inoremap <M-]> <Esc>:tabnext<CR>

" == junegunn/fzf ==
"
" Mapping selecting mappings
nmap <Leader><tab> <Plug>(fzf-maps-n)
xmap <Leader><tab> <Plug>(fzf-maps-x)
omap <Leader><tab> <Plug>(fzf-maps-o)

" Insert mode completion
imap <C-x><C-k> <Plug>(fzf-complete-word)
imap <C-x><C-f> <Plug>(fzf-complete-path)
imap <C-x><C-j> <Plug>(fzf-complete-file-ag)
imap <C-x><C-l> <Plug>(fzf-complete-line)

nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-p> :GitFiles<CR>
nnoremap <C-g> :GitFiles?<CR>
nnoremap <C-t> :Files<CR>

" Colemak keyboard layout mappings
map <Up> gh
map <Down> gk

" Source: http://forum.colemak.com/viewtopic.php?pid=184#p184
noremap K J
noremap J K
noremap h k
noremap j h
noremap k j
noremap gh gk
noremap gj gh
noremap gk gj
noremap zh zk
"zK does not exist
noremap zj zh
noremap zJ zH
noremap zk zj
"zJ does not exist
noremap z<Space> zl
noremap z<S-Space> zL
noremap z<BS> zh
noremap z<S-BS> zH
noremap <C-w>h <C-w>k
noremap <C-w>H <C-w>K
noremap <C-w>j <C-w>h
noremap <C-w>J <C-w>H
noremap <C-w>k <C-w>j
noremap <C-w>K <C-w>J

" Split navigation key mappings
" Easy split navigation, adapted from <https://github.com/sjl/dotfiles/blob/master/vim/vimrc#L509>.
noremap <C-h> <C-w>k
noremap <C-j> <C-w>h
noremap <C-k> <C-w>j
noremap <C-l> <C-w>l

" Terminal configuration
let g:terminal_scrollback_buffer_size=15000
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>k
tnoremap <C-j> <C-\><C-n><C-w>h
tnoremap <C-k> <C-\><C-n><C-w>j
tnoremap <C-l> <C-\><C-n><C-w>l

" Select just-pasted text.
nnoremap gp `[v`]

" Active buffer's path.
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h') . '/' : '%%'

" Force saving files that require root permission
cnoremap w!! w !sudo tee > /dev/null %

" Format JSON
nmap gJ :%!python -m json.tool<CR>

au BufEnter * let b:coc_current_function = ''
augroup Terminal
  au!
  au BufEnter term://* normal! i
augroup END

" Make sure Vim returns to the same line when reopening a file.
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END

" Automatically source config when saving it.
augroup ReloadConfig
  au!
  au BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" Completion

"set completeopt=longest,menuone,preview

" Indentation
augroup Elm
  au!
  au FileType elm setlocal shiftwidth=4 softtabstop=4
augroup END

augroup GitCommit
  au!
  au FileType gitcommit setlocal textwidth=72
augroup END

augroup VariousFileTypes
  au!
  au BufRead,BufNewFile .babelrc set filetype=json
  au BufRead,BufNewFile tsconfig.json set filetype=jsonc
augroup END

if has('nvim') || has('termguicolors')
  set termguicolors
endif

" lua require('bufferline').setup{}
lua require('wlsample.evil_line')
