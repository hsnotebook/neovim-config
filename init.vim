if (has("win32"))
	let nvim_home='c:/Users/Administrator/AppData/Local/nvim'
else
	let nvim_home='~/.config/nvim'
endif

let g:python3_host_prog = '/usr/bin/python'

call plug#begin(nvim_home . '/plugged')

"" Misc {{{
let mapleader=" "
let maplocalleader=" "

filetype plugin indent on

set directory=/tmp

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>wq :wq<cr>
nnoremap <leader>m :on<cr>

nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

set showmatch
set mat=2

set showcmd
set splitright

Plug 'vim-scripts/DrawIt'

Plug 'christoomey/vim-tmux-navigator'
"}}}

"" Windows and tabs {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap tn :tabn<cr>
nnoremap tp :tabp<cr>
Plug 'gcmt/taboo.vim'
"}}}

"" Terminal {{{
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
if has("nvim")
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif
augroup term_statusline
	au!
	autocmd TermOpen * setlocal statusline=%{b:term_title}
augroup END
nnoremap <leader>tb :vsplit term://bash<cr>
tnoremap <leader>tb <C-\><C-N>:vsplit term://bash<cr>
" }}}

"" GUI {{{
colorscheme wombat

set laststatus=2
set statusline=%F%m%r%w\ %{fugitive#statusline()}\ [POS+%04l,%04v]\ [%p%%]\ [LEN=%L]\ [%{&ff}]
" }}}

"" Folding {{{
set nofoldenable
"}}}

"" Tabstop {{{
set tabstop=4
set shiftwidth=4
set noexpandtab
augroup two_tab_indent
	au!
	autocmd FileType xml,html,json setlocal tabstop=2 | setlocal shiftwidth=2
    autocmd FileType scss,vue,javascript,yaml,css setlocal expandtab | setlocal tabstop=2 | setlocal shiftwidth=2
augroup END
"}}}

"" Editing {{{
set autowrite
set autoread
set clipboard+=unnamedplus

nnoremap <leader>e :e!<cr>
nnoremap gV `[v`]

inoremap <C-l> <esc>b~ea

augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=0
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

packadd! matchit

Plug 'lambdalisue/suda.vim'

Plug 'SirVer/ultisnips'
let g:UltiSnipsEditSplit="vertical"

Plug 'hotoo/pangu.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'junegunn/goyo.vim'
let g:goyo_width = 120

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_quit_key='<C-c>'
nnoremap <C-c> :call multiple_cursors#quit()<CR>

Plug 'easymotion/vim-easymotion'
map f <Plug>(easymotion-prefix)
map <Plug>(easymotion-prefix)w <Plug>(easymotion-bd-w)
map <Plug>(easymotion-prefix)e <Plug>(easymotion-bd-e)
map <Plug>(easymotion-prefix)l <Plug>(easymotion-lineforward)
map <Plug>(easymotion-prefix)h <Plug>(easymotion-linebackward)

Plug 'vim-scripts/fcitx.vim'
set ttimeoutlen=100

Plug 'jiangmiao/auto-pairs'
set sessionoptions+=globals

Plug 'junegunn/vim-easy-align'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

set undodir=~/tmp/vim/undo
set undofile
"}}}

"" Search {{{
set incsearch
set hlsearch
set ignorecase
set nowrapscan
hi Search cterm=NONE ctermfg=black ctermbg=gray

" disables search highlighting when you are done searching
" and re-enables it when you search again.
Plug 'romainl/vim-cool'

" search hilight text in visual mode
vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

" }}}

"" Project Manager {{{
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nnoremap <leader>fe :NERDTreeToggle<cr>
nnoremap <leader>ff :NERDTreeFind<cr>

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/target/*,*/node_modules/*
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '40%' }
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_commits_log_options = "--graph --color=always --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %Cblue<%an>%Creset' --date=format:'%F %T' --abbrev-commit --all"
nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader>P :GFiles<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
" nnoremap <silent> <C-p> :Files<CR>
nnoremap K :Ag <C-R><C-W><CR>

Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<cr>
"}}}

"" Develop {{{

" Plug 'ycm-core/YouCompleteMe'

"" Front {{{
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim' , { 'for': ['xml', 'html', 'jsp', 'js', 'vue'] }
Plug 'pangloss/vim-javascript'
"}}}

"" Java {{{
" let g:EclimLoggingDisabled=1
" augroup java
" 	au!
" 	au FileType java nnoremap <buffer> <leader>o :call eclim#java#import#OrganizeImports()<cr>
" 	au FileType java nnoremap <buffer> <leader>i :call eclim#java#correct#Correct()<cr>
" 	au FileType java nnoremap <buffer> gd :JavaSearch -x declarations<cr>
" 	au FileType java nnoremap <buffer> gi :JavaSearch -x implementors<cr>
" 	au FileType java inoremap <buffer> <c-d> <c-x><c-u>
" augroup END

" au FileType java nnoremap <buffer> <F1> :CocCommand java.debug.vimspector.start<cr>
"}}}

Plug 'vim-test/vim-test'
let test#java#runner = 'maventest'
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Plug 'puremourning/vimspector'
" let g:vimspector_enable_mappings = 'HUMAN'

"}}}

"" Document {{{
Plug 'vimwiki/vimwiki'
let ctfo = {}
let ctfo.path = '~/vimwiki/ctfo'
let ctfo.auto_toc=1
let ctfo.nested_syntaxes = {
			\ 'python': 'python',
			\ 'vimL': 'vim',
			\ 'bash': 'bash',
			\ 'java': 'java',
			\ 'js': 'javascript',
			\ 'json': 'json',
			\ 'xml': 'xml',
			\ 'sql': 'sql',
			\ 'html': 'html',
			\ 'plantuml': 'plantuml',
			\ 'perl': 'perl'}
let study = {}
let study.path = '~/vimwiki/study'
let personal = {}
let personal.path = '~/vimwiki/personal'
let zhuojun = {}
let zhuojun.path = '~/vimwiki/zhuojun'
let g:vimwiki_list = [ctfo, study, personal, zhuojun]
let g:vimwiki_html_header_numbering = 1
let g:vimwiki_folding = 'syntax'
au Filetype vimwiki setlocal textwidth=80
nnoremap <leader>tt :VimwikiToggleListItem<cr>

" file:xxx::lineNum to unnamed register
function! VimwikiStoreLink()
	let @" = 'file:'.expand("%:p").'::'.line('.')
endfunction
command! StoreLink :call VimwikiStoreLink()

Plug 'masukomi/vim-markdown-folding'
"}}}
"

Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
let g:dbs = {
\	'gxzx_30806':'mysql://root:123%40ctfo@192.168.43.105:30806/mou_gxzx',
\	'gxzx_30807':'mysql://root:123%40ctfo@192.168.43.105:30807/mou_gxzx'
\}
let g:db_ui_execute_on_save = 0
Plug 'kristijanhusak/vim-dadbod-completion'
" For built in omnifunc
augroup sql
	au!
	au FileType sql nnoremap <buffer> <C-Enter> vip<leader>S
	autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
	autocmd FileType sql inoremap <buffer> <c-d> <c-x><c-u>
augroup END


Plug 'neoclide/coc.nvim'

" coc-java
" coc-java-debug
" coc-pyright
" coc-vetur

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <c-d> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>af  :CocFix<cr>

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
nmap <leader>o  :call CocAction('runCommand', 'editor.action.organizeImport')<cr>:w<cr>

" Use K to show documentation in preview window.
nnoremap <silent> L :call <SID>show_documentation()<CR>

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

Plug 'jpalardy/vim-slime'
let g:slim_python_ipython = 1
let g:slime_target = "tmux"

call plug#end()
