if (has("win32"))
	let nvim_home='c:/Users/Administrator/AppData/Local/nvim'
else
	let nvim_home='~/.config/nvim'
endif

call plug#begin(nvim_home . '/plugged')

let mapleader=" "
let maplocalleader=" "

filetype plugin indent on

" Windows and tabs start {{{

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap tn :tabn<cr>
nnoremap tp :tabp<cr>
Plug 'gcmt/taboo.vim'

" }}}

" Terminal {{{
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

" Misc {{{
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

colorscheme wombat

set showmatch
set mat=2

set showcmd
set splitright
set autowrite
set autoread

set laststatus=2
set statusline=%F%m%r%w\ %{fugitive#statusline()}\ [POS+%04l,%04v]\ [%p%%]\ [LEN=%L]\ [%{&ff}]
" }}}

" Tab config {{{
set tabstop=4
set shiftwidth=4
set noexpandtab
augroup xml_html_indent
	au!
	autocmd FileType xml,html setlocal tabstop=2 | setlocal shiftwidth=2
augroup END
" }}}

" Search {{{
set incsearch
set hlsearch
set ignorecase
set nowrapscan
hi Search cterm=NONE ctermfg=black ctermbg=gray

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

" disables search highlighting when you are done searching and re-enables it when you search again.
Plug 'romainl/vim-cool'
" }}}

" Delete trailing whitespace {{{
function! DeleteTrailingWS()
	execute 'normal! mz'
	execute '%s/\s\+$//e'
	execute "normal! `z"
endfunction

augroup clear_trail_white_space
	au!
	au BufWritePre * :call DeleteTrailingWS()
augroup END
" }}}

" grep setting
set grepprg=ag\ --nogroup\ --nocolor
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 500
let g:deoplete#complete_method = 'omnifunc'

" quickfix
Plug 'romainl/vim-qf'

Plug 'kien/ctrlp.vim'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/target/*,*/node_modules/*
let g:ctrlp_clear_cache_on_exit = 0

Plug 'SirVer/ultisnips'
let g:UltiSnipsEditSplit="vertical"

Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<cr>

Plug 'hotoo/pangu.vim'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

" Frontend Develop {{{
Plug 'posva/vim-vue'
augroup web_indent
    au!
    autocmd FileType vue setlocal expandtab | setlocal tabstop=2 | setlocal shiftwidth=2
    autocmd FileType javascript setlocal expandtab | setlocal tabstop=2 | setlocal shiftwidth=2
augroup END

Plug 'othree/html5.vim'

Plug 'mattn/emmet-vim' , { 'for': ['xml', 'html', 'jsp', 'js', 'vue'] }

Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0

Plug 'pangloss/vim-javascript'
" javascript
Plug 'prettier/vim-prettier', { 'do': 'npm install -g' }
" }}}


Plug 'christoomey/vim-tmux-navigator'

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

Plug 'junegunn/vim-easy-align'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

Plug 'jiangmiao/auto-pairs'

Plug 'aklt/plantuml-syntax'
let g:plantuml_executable_script="java -jar /home/hs/bin/plantuml.jar -charset UTF-8"

augroup plantuml_refresh
	au!
	au filetype plantuml nnoremap <f5> :w<cr>:silent make<cr>
	au filetype plantuml inoremap <f5> <esc>:w<cr>:silent make<cr>
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" Edit something """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " tabular plugin is used to format tables
" Plug 'godlygeek/tabular'
" " JSON front matter highlight plugin
" Plug 'elzr/vim-json'
" Plug 'plasticboy/vim-markdown'

" " disable header folding
" let g:vim_markdown_folding_disabled = 1

" " do not use conceal feature, the implementation is not so good
" let g:vim_markdown_conceal = 0

" " support front matter of various format
" let g:vim_markdown_frontmatter = 1  " for YAML format
" let g:vim_markdown_toml_frontmatter = 1  " for TOML format
" let g:vim_markdown_json_frontmatter = 1  " for JSON format

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#folding#fdc = 0
let g:pandoc#spell#enabled = 0

" Plug 'vimwiki/vimwiki'
" let wiki = {}
" let wiki.path = '~/vimwiki/'
" let wiki.auto_toc=1
" let wiki.nested_syntaxes = {
" 			\ 'python': 'python',
" 			\ 'vimL': 'vim',
" 			\ 'bash': 'bash',
" 			\ 'java': 'java',
" 			\ 'json': 'json',
" 			\ 'xml': 'xml',
" 			\ 'plantuml': 'plantuml',
" 			\ 'perl': 'perl'}
" let g:vimwiki_list = [wiki]
" let g:vimwiki_html_header_numbering = 1
" au Filetype vimwiki setlocal textwidth=80

" " file:xxx::lineNum to unnamed register
" function! VimwikiStoreLink()
" 	let @" = 'file:'.expand("%:p").'::'.line('.')
" endfunction
" command! StoreLink :call VimwikiStoreLink()

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'tpope/vim-unimpaired'

" The vim source for neocomplete/deoplete
Plug 'Shougo/neco-vim'

Plug 'nhooyr/neoman.vim'

set sessionoptions+=globals
Plug 'tpope/vim-obsession'

" eclim
augroup java
	au!
	au FileType java nnoremap <buffer> <leader>o :call eclim#java#import#OrganizeImports()<cr>
	au FileType java nnoremap <buffer> <leader>i :call eclim#java#correct#Correct()<cr>
	au FileType java inoremap <buffer> <c-d> <c-x><c-u>
augroup END

call plug#end()
