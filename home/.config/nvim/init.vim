call plug#begin('~/.config/nvim/plugged')

" Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

Plug 'NLKNguyen/papercolor-theme'
Plug 'docker/docker', {'rtp': '/contrib/syntax/vim/'}
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'editorconfig/editorconfig-vim'
Plug 'elmcast/elm-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'google/vim-searchindex'
Plug 'mhinz/vim-grepper'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'matze/vim-move'  " bindings not working?!?!?
Plug 'rhysd/committia.vim' " git commit view
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'

" Plug 'scrooloose/nerdtree'

Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'

Plug 'sbdchd/neoformat'
let g:neoformat_only_msg_on_error = 0
let g:neoformat_javascript_prettier = {
  \ 'exe': 'prettier',
  \ }
let g:neoformat_typescript_prettier = {
  \ 'exe': 'prettier',
  \ }
let g:neoformat_enabled_typescript = ['prettier']

let g:neoformat_enabled = 1
augroup neoformat
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx
    \ if g:neoformat_enabled == 1 |
    \   Neoformat |
    \ endif
augroup end

command! NeoformatDisable let g:neoformat_enabled = 0
command! NeoformatEnable let g:neoformat_enabled = 1

" == Autocomplete plugins ==
" https://www.gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
" Plug 'SirVer/ultisnips'
" Plug 'ervandew/supertab'
" Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }

" Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'fleischie/vim-styled-components'

Plug 'iloginow/vim-stylus'

" == JavaScript syntax highlighting ==
" Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }

" Plug 'jason0x43/vim-js-indent'
"

" == TypeScript ==
" Plug 'leafgarland/typescript-vim'
" Plug 'Quramy/tsuquyomi'

" if has('balooneval')
"   set ballooneval
"   autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
" endif

autocmd FileType typescript setlocal
      \ smartindent
      \ softtabstop=2
      \ shiftwidth=2
      \ expandtab 

" Plug 'ernstvanderlinden/vim-coldfusion'

call plug#end()

" elmcast/elm-vim
let g:elm_format_autosave = 1

" deoplete
" let g:deoplete#enable_at_startup = 1

" General editor settings
set linebreak       " Break lines when appropriate
set smartindent
set softtabstop=2
set tabstop=8
set shiftwidth=2
set expandtab
set textwidth=100

set backup
set noswapfile

set laststatus=2
set number
set ruler
set nojoinspaces    " Prevent inserting two spaces after punctuation on a join
set synmaxcol=400   " Don't try to highlight ridiculously long lines.
set title           " VimR
" set shell=zsh\ -l

if exists('+colorcolumn')
  set colorcolumn=+1
endif

if exists('neovim_dot_app')
  call MacMenu('File.Print', '')
end

if exists('+spelllang')
  set spelllang=en_us
endif

if has('persistent_undo')
  set undodir=~/.vim/tmp/undo//     " undo files
  " Make the folder automatically if it doesn't already exist.
  if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
  endif
endif

set backupdir=~/.config/nvim/tmp/backup/ " backups
set directory=~/.config/nvim/tmp/swap/   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), 'p')
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), 'p')
endif

if has('persistent_undo')
  let myUndoDir = expand('$HOME/.config/nvim/tmp/undo/')
  if !isdirectory(myUndoDir)
    call mkdir(myUndoDir, 'p')
  endif
  let &undodir = myUndoDir
  set undofile
endif

" Leader
let mapleader = ","

" Wildmenu
set wildmenu
set wildmode=list:longest
set wildignore+=*tmp/*,*.swp,*.zip,*.gz
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.so,*.o,*.a,*.manifest          " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.orig                           " Merge resolution files

" Cursorline

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Active buffer's path.
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h') . '/' : '%%'

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
noremap <C-w><Space> <C-w>l
noremap <C-w><S-Space> <C-w>L
noremap <C-w><S-BS> <C-w>H

" Split navigation key mappings
" Easy split navigation, adapted from <https://github.com/sjl/dotfiles/blob/master/vim/vimrc#L509>.
noremap <C-h> <C-w>k
noremap <C-j> <C-w>h
noremap <C-k> <C-w>j
noremap <C-l> <C-w>l

" Terminal configuration
let g:terminal_scrollback_buffer_size=5000
"tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>k
tnoremap <C-j> <C-\><C-n><C-w>h
tnoremap <C-k> <C-\><C-n><C-w>j
tnoremap <C-l> <C-\><C-n><C-w>l

" Select just-pasted text.
nnoremap gp `[v`]

" Format JSON
nmap gJ :%!python -m json.tool<CR>

" Make sure Vim returns to the same line when reopening a file
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END

" Automatically source vim config when saving it
augroup reload_vimrc
  au!
  au BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" Completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

autocmd FileType javascript,javascript.jsx let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" close the preview window when you're not using it
" let g:SuperTabClosePreviewOnPopupClose = 1

" or just disable the preview entirely
" set completeopt-=preview"

" Indentation
autocmd FileType elm setlocal shiftwidth=4 softtabstop=4
autocmd FileType gitcommit setlocal textwidth=72

autocmd FileType eoz
    \ setlocal
      \ noexpandtab
      \ foldmethod=syntax
      \ shiftwidth=4
      \ smarttab
      \ softtabstop=0
      \ tabstop=4

autocmd BufRead,BufNewFile *.cfm set filetype=eoz
autocmd BufRead,BufNewFile *.cfc set filetype=eoz

autocmd BufRead,BufNewFile .babelrc set filetype=json

" == scrooloose/syntastic ==
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_jump = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 1
" let g:syntastic_javascript_checkers = ['eslint']

" === Keybindings ===

nnoremap <M-[> :tabprev<CR>
nnoremap <M-]> :tabnext<CR>
inoremap <M-[> <ESC>:tabprev<CR>
inoremap <M-]> <ESC>:tabnext<CR>

" == junegunn/fzf ==
nnoremap <C-T> :FZF<CR>
inoremap <C-T> <ESC>:FZF<CR>i

" == scrooloose/nerdtree ==
" nnoremap <C-\> :NERDTreeToggle<CR>
" inoremap <C-\> <ESC>:NERDTreeToggle<CR>

" fzf
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <C-p> :GitFiles<CR>
nnoremap <C-S-p> :Files<CR>

if has('nvim') || has('termguicolors')
  set termguicolors
endif
