if (has("win32"))
	let nvim_home='c:/Users/Administrator/AppData/Local/nvim'
else
	let nvim_home='~/.config/nvim'
endif

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

" disable arrow in insert mode
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

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
tnoremap <Esc><Esc> <C-\><C-n>
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
set foldenable
augroup folding
	au!
	au FileType vimwiki setlocal foldlevel=1
	au FileType vim setlocal foldmethod=marker | setlocal foldlevel=0
	au FileType java setlocal foldmethod=syntax | setlocal foldlevel=1 | setlocal nofoldenable
	au FileType java nnoremap <buffer> zo zO
augroup end
" "Refocus" folds
nnoremap ,z zMzvzz
nnoremap zv zvzz
nnoremap <leadar>z za
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

nnoremap <leader>e :e!<cr>
nnoremap gV `[v`]

inoremap <C-l> <esc>b~ea

Plug 'bronson/vim-trailing-whitespace'

augroup clear_trail_white_space
	au!
	au BufWritePre * :FixWhitespace
augroup END

packadd! matchit

Plug 'SirVer/ultisnips'
let g:UltiSnipsEditSplit="vertical"

Plug 'hotoo/pangu.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_quit_key='<C-c>'
nnoremap <C-c> :call multiple_cursors#quit()<CR>

Plug 'easymotion/vim-easymotion'
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

" grep setting
set grepprg=ag\ --nogroup\ --nocolor
" }}}

"" Project Manager {{{
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nnoremap <leader>fe :NERDTreeToggle<cr>
nnoremap <leader>ff :NERDTreeFind<cr>

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/target/*,*/node_modules/*
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" nnoremap <silent> <leader>p :Files<CR>
" nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>

Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<cr>

Plug 'airblade/vim-rooter'
let g:rooter_patterns = ['.root', '.gitignore', '.git/']
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
let g:rooter_change_directory_for_non_project_files = ''
"}}}

"" Langauage {{{
"" Lsp {{{
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" Plug 'autozimu/LanguageClient-neovim'
"}}}

"" Front Develop {{{
Plug 'posva/vim-vue'

Plug 'othree/html5.vim'

Plug 'mattn/emmet-vim' , { 'for': ['xml', 'html', 'jsp', 'js', 'vue'] }

Plug 'leafgarland/typescript-vim'

Plug 'pangloss/vim-javascript'

let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0
"}}}

"" Java {{{
function! JavaFindOrCreateTest()

	let srcFile = expand('%:h')
	echo srcFile

endfunction

let g:EclimLoggingDisabled=1
augroup java
	au!
	au FileType java nnoremap <buffer> <leader>o :call eclim#java#import#OrganizeImports()<cr>
	au FileType java nnoremap <buffer> <leader>i :call eclim#java#correct#Correct()<cr>
	au FileType java nnoremap <buffer> gd :JavaSearch -x declarations<cr>
	au FileType java nnoremap <buffer> gi :JavaSearch -x implementors<cr>
	au FileType java inoremap <buffer> <c-d> <c-x><c-u>
augroup END
"}}}
"}}}

"" Document {{{

Plug 'vimwiki/vimwiki'
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.auto_toc=1
let wiki.nested_syntaxes = {
			\ 'python': 'python',
			\ 'vimL': 'vim',
			\ 'bash': 'bash',
			\ 'java': 'java',
			\ 'js': 'javascript',
			\ 'json': 'json',
			\ 'xml': 'xml',
			\ 'sql': 'sql',
			\ 'plantuml': 'plantuml',
			\ 'perl': 'perl'}
let g:vimwiki_list = [wiki]
let g:vimwiki_html_header_numbering = 1
let g:vimwiki_folding = 'syntax'
" au Filetype vimwiki setlocal textwidth=80

" Plug 'vimwiki/vimwiki'
" let g:vimwiki_list = [{'path': '~/vimwiki/',
"                       \ 'syntax': 'markdown', 'ext': '.md'}]
nnoremap <leader>tt :VimwikiToggleListItem<cr>

" file:xxx::lineNum to unnamed register
function! VimwikiStoreLink()
	let @" = 'file:'.expand("%:p").'::'.line('.')
endfunction
command! StoreLink :call VimwikiStoreLink()

" function! VimwikiLinkHandler(link)
" 	try
" 		let pageNum = matchstr(a:link, '::\zs\d\+')
" 		let file = matchstr(a:link, '^.*:\zs.*\ze::')
" 		let fileCmdOutput = system('file '.file)
" 		if pageNum ==? ""
" 			pageNum = 1
" 		endif
" 		if matchstr(fileCmdOutput, '\zsPDF\ze') ==? 'PDF'
" 			let opener = '/usr/bin/zathura'
" 			call system(opener.' -P '.pageNum.' '.file.' &')
" 			return 1
" 		elseif matchstr(fileCmdOutput, '\zstext\ze') ==? 'text'
" 			execute 'edit +'.pageNum.' '.file
" 			return 1
" 		else
" 			return 0
" 		endif
" 	catch
" 		echom "This can happen for a variety of reasons ..."
" 	endtry
" 	return 0
" endfunction

Plug 'masukomi/vim-markdown-folding'
"}}}

call plug#end()
