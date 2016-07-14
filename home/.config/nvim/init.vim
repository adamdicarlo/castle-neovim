call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'carlitux/deoplete-ternjs'

Plug 'NLKNguyen/papercolor-theme'
Plug 'benekastah/neomake'
Plug 'elixir-lang/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'matze/vim-move'  " bindings not working?!?!?
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" elmcast/elm-vim
let g:elm_format_autosave = 1

" deoplete
let g:deoplete#enable_at_startup = 1

set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set linebreak       " Break lines when appropriate
set smartindent
set textwidth=100
set backup
set noswapfile
set showcmd
set showmode
set ruler
set nojoinspaces    " Prevents inserting two spaces after punctuation on a join
set nolazyredraw    " Neovim.app redraw performance

set background=dark
set synmaxcol=200      " Don't try to highlight super long lines.
if exists('+colorcolumn')
  set colorcolumn=+1
endif
colorscheme PaperColor
set guifont=Inconsolata-dz\ for\ Powerline:h14

if exists("+spelllang")
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
" Easy split navigation, adapted from
" https://github.com/sjl/dotfiles/blob/master/vim/vimrc#L509.
noremap <C-h> <C-w>k
noremap <C-j> <C-w>h
noremap <C-k> <C-w>j
noremap <C-l> <C-w>l

" Select just-pasted text.
nnoremap gp `[v`]

" Airline
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_theme = 'luna'

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END

" Elm
autocmd FileType Elm setlocal shiftwidth=4 softtabstop=4

" Neomake
autocmd! BufWritePost * Neomake

let g:neomake_javascript_enabled_makers = ['eslint']

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

if exists("neovim_dot_app")
  call MacMenu("File.Print", "")
end
