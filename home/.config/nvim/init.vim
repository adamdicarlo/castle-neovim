" Install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'dense-analysis/ale'
Plug 'NLKNguyen/papercolor-theme'
Plug 'docker/docker', {'rtp': '/contrib/syntax/vim/'}
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'editorconfig/editorconfig-vim'
Plug 'elmcast/elm-vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'google/vim-searchindex'
Plug 'mhinz/vim-grepper'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
" Plug 'matze/vim-move'  " bindings not working?!?!?
Plug 'rhysd/committia.vim' " git commit view
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tbastos/vim-lua'
Plug 'vimwiki/vimwiki'

" == TypeScript and JavaScript  ==
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jason0x43/vim-js-indent'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

" TypeScript config {{{1

autocmd FileType typescript,typescriptreact setlocal
      \ smartindent
      \ softtabstop=4
      \ shiftwidth=4
      \ expandtab

autocmd FileType lua,javascript,typescript,typescriptreact map <buffer> <c-]> :ALEGoToDefinition<CR>

" }}}1

autocmd FileType lua setlocal
      \ smartindent
      \ softtabstop=4
      \ shiftwidth=4
      \ noexpandtab

" TreeSitter {{{1

lua <<EOF
require'nvim-treesitter.configs'.setup {
	-- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = {
		"c",
		"cpp",
		"css",
		"elm",
		"html",
		"javascript",
		"json",
		"jsdoc",
		"lua",
		"python",
		"typescript",
		"tsx"
	},

	highlight = {
		-- false will disable the whole extension
		enable = true,

		-- list of languages to disable
		disable = {},
	},
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
}
EOF

" }}}1

" elmcast/elm-vim
let g:elm_format_autosave = 1

" deoplete
let g:deoplete#enable_at_startup = 1

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

let &backupdir=expand('$HOME/.config/nvim/tmp/backup//')
let &directory=expand('$HOME/.config/nvim/tmp/swap//')

" Make those folders automatically if they don't already exist.
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
if !isdirectory(&directory)
  call mkdir(&directory, 'p')
endif

set backup
set noswapfile

if has('persistent_undo')
  let myUndoDir = expand('$HOME/.config/nvim/tmp/undo//')
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

" Vimwiki
let g:vimwiki_list = [{'path': '~/Sync/wiki/', 'syntax': 'markdown'}]
au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab

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
let g:terminal_scrollback_buffer_size=15000
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


set completeopt=longest,menuone,preview

autocmd FileType javascript,javascript.jsx let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Indentation
autocmd FileType elm setlocal shiftwidth=4 softtabstop=4
autocmd FileType gitcommit setlocal textwidth=72

autocmd BufRead,BufNewFile .babelrc set filetype=json

" === Keybindings ===

" == ALE ==

let js_fixers = ['prettier']
let g:ale_linters = {
      \ 'typescript': ['tslint', 'tsserver', 'typecheck'],
      \ 'typescriptreact': ['tslint', 'tsserver', 'typecheck'],
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': js_fixers,
      \ 'javascript.jsx': js_fixers,
      \ 'typescript': js_fixers,
      \ 'typescriptreact': js_fixers,
      \ 'css': ['prettier'],
      \ 'json': ['prettier'],
      \ 'scss': ['prettier'],
      \}
let g:ale_pattern_options = {
      \ '/dist/': { 'ale_enabled': 0 },
      \}
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

nnoremap <M-[> :tabprev<CR>
nnoremap <M-]> :tabnext<CR>
inoremap <M-[> <ESC>:tabprev<CR>
inoremap <M-]> <ESC>:tabnext<CR>

" Prev/next error
nmap <silent> <M-h> <Plug>(ale_previous_wrap)
nmap <silent> <M-k> <Plug>(ale_next_wrap)

nmap <silent> <leader>al :ALENext<CR>
nmap <silent> <leader>aj :ALEPrevious<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <silent> rn :ALERename<CR>
nnoremap <silent> gi :ALEHover<CR>

" Quickfix
nnoremap <leader>qf :ALECodeAction<CR>
vnoremap <leader>qf :ALECodeAction<CR>

" == junegunn/fzf ==
nnoremap <C-T> :FZF<CR>
inoremap <C-T> <ESC>:FZF<CR>i

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

nnoremap <C-S-P> :Files<CR>
nnoremap <C-p> :GitFiles<CR>

if has('nvim') || has('termguicolors')
  set termguicolors
endif
