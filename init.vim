source $HOME\AppData\Local\nvim\themes\airline.vim
let g:polyglot_disabled = ['rust']

syntax on

"set autochdir
set showmatch
set relativenumber
"set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set ignorecase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set clipboard=unnamedplus               " Copy paste between vim and everything else
set ttimeout
set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast
set mouse=a
"set pastetoggle=<F5>

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
autocmd ColorScheme * highlight CocHighlightText     guibg=#3d465e

call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'cespare/vim-toml'
" Plug 'stephpy/vim-yaml'
" Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-rooter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'commit': '68ab6455743066165caa2e0f39e607e9c94b0bba'}
Plug 'jremmen/vim-ripgrep'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'voldikss/vim-floaterm'
call plug#end()

colorscheme onedark
let mapleader = " "
"Session
" let g:session_dir = '$HOME\AppData\Local\nvim\sessions'
" exec 'nnoremap <A-s> :mks! ' . g:session_dir . '\'
" exec 'nnoremap <A-r> :so ' . g:session_dir . '\'
nnoremap <A-s> :SSave<CR>
nnoremap <A-d> :SDelete<CR>

" let g:netrw_browse_split = 2
" let g:vrfr_rg = 'true'
" let g:netrw_banner = 0
" let g:netrw_winsize = 25
autocmd TermOpen * setlocal nonumber norelativenumber
let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.3, 'yoffset': 1, 'border': 'horizontal' } }
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh', 'package.json', '.gitignore', 'src', 'Cargo.toml']

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
"nnoremap <leader>fv :wincmd v<bar> :Ex <bar> :vertical resize 25<CR>
"nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>H :History<CR>
nnoremap <Leader>F :Files E:\Projects\
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Gfiles<CR>
nnoremap <leader>rr :Rg<SPACE>
nnoremap <Leader>R :Rg  E:\Projects\<left><left><left><left><left><left><left><left><left><left><left><left><left>
nnoremap <Leader>nv :e $HOME\AppData\Local\nvim\init.vim
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
"nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-c> <esc>
nmap <leader>b :Buffers<CR>

"Close buffers FZF
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))


if executable('fd')
    let $FZF_DEFAULT_COMMAND = 'fd --type f'
endif


"Rust
nnoremap <leader>ca :!cargo 

" Quick-save
nmap <leader>w :w<CR>
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
" inoremap <C-d> <esc>:wq!<cr>               " save and exit
" nnoremap <C-d> :wq!<cr>
" inoremap <leader>qq <esc>:qa!<cr>               " quit discarding changes
nnoremap <leader>qq :qa!<cr>


"Float Term
nnoremap <leader>te :FloatermNew --wintype=split --height=0.4<CR>
nnoremap <leader>py :FloatermNew --wintype=split --height=0.4 python<CR>
nnoremap <leader>no :FloatermNew --wintype=split --height=0.4 node<CR>
nnoremap   <silent>   <F4>    :FloatermNew --wintype=float --height=0.9 --width=0.40 --position=topright<CR>
tnoremap   <silent>   <F4>    <C-\><C-n>:FloatermNew<CR>
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_1eymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
"let g:floaterm_keymap_new    = '<F4>'



"Use Tab instead bn/bp
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nnoremap <C-w> :bd<cr>:bp<cr>

"Tab autocomplete
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Decent wildmenu
set wildmenu
"set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>


"COC GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nmap <leader>do <Plug>(coc-codeaction)
nnoremap <leader>cr :CocRestart

" Show commands.
nnoremap <silent><nowait><leader>cc  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>di :<C-u>CocList diagnostics<cr>

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Implement methods for trait
nnoremap <silent> <leader>im  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <leader>a  :CocAction<cr>

"Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
 
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <A-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <A-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <A-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <A-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <A-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <A-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif


"Nerd Tree
"autocmd VimEnter * NERDTree
nnoremap <C-f> :NERDTreeToggleVCS<CR>
nnoremap <A-f> :NERDTreeRefreshRoot<CR>

"autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"     \ quit | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'



let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['Sessions']       },
      \ { 'type': 'dir',     'header': ['Recent files']     },
      \ { 'type': 'bookmarks', 'header': ['Bookmarks']      },
      \ ]
