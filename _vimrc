set nocompatible

filetype off
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	" deprecated function
	"call neobundle#rc(expand('~/.vim/bundle'))
	" new style
	call neobundle#begin(expand('~/.vim/bundle/'))
	NeoBundleFetch 'Shougo/neobundle.vim'
	call neobundle#end()
	" end
endif

" git clone https://github.com/Shougo/neobundle.vim
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
			\ 'build' : {
			\		'windows' : 'make -f make_mingw32.mak',
			\		'cygwin' : 'make -f make_cygwin.mak',
			\		'mac' : 'make -f make_mac.mak',
			\		'unix' : 'gmake -f make_unix.mak',
			\		},
			\ }
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'koron/codic-vim'
NeoBundle 'scrooloose/syntastic'
"NeoBundle 'slimv.vim'
NeoBundle 'VimClojure'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-pathogen'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-leiningen'
NeoBundle 'tpope/vim-projectionist'
NeoBundle 'tpope/vim-classpath'
NeoBundleLazy 'kongo2002/fsharp-vim', {
			\ 'autoload': {
			\		'filetypes': ['fsharp']
			\		}
			\ }
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'eagletmt/ghcmod-vim'
"NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'dag/vim2hs'
NeoBundle 'ujihisa/ref-hoogle'
NeoBundle 'ujihisa/unite-haskellimport'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'aharisu/vim-gdev'
NeoBundle 'aharisu/vim_goshrepl'


filetype plugin indent on

"----------
"codic-vim
"----------
"<C-W>P move ResultWindow
"<C-W><C-P> return EditWindow
"<C-W><C-Z> close ResultWindow
"'previewheight' is window height
"Operation of a preview-window can be used as it is.
":help preview-window

"--------------------
" QuickRun
"--------------------
if !exists('g:quickrun_config')
	let g:quickrun_config = {}
endif
let g:quickrun_config = {
			\	'_' : {
			\		'outputter' : 'multi:buffer:quickfix',
			\		'outputter/buffer/split' : ':botright 8sp',
			\		'runner' : 'vimproc',
			\		'runner/vimproc/updatetime' : 60,
			\	},
			\	'fsharp' : {
			\		'command': 'fsharpc',
			\		'runmode': 'simple',
			\		'exec': [
			\			'%c /nologo --out:"%S.exe" %s',
			\			'echo "--- result ---"',
			\			'mono "%S.exe" %a',
			\			'echo "\n---  end   ---"',
			\			'rm "%S.exe"'
			\			],
			\		'tempfile': '%{tempname()}.fs',
			\	},
			\	'gauche' : {
			\		'command' : 'gosh',
			\		'exec' : [
			\			'echo "eval"',
			\			'%c %s %a',
			\			'echo "end"'
			\			],
			\	},
			\}

function! s:QuickRunCustom(ft)
	:exec 'QuickRun ' . a:ft
endfunction
command! QR :call s:QuickRunCustom(<f-args>)a

"---------------------
" vim-gdev
"---------------------

" :Unite displays information of the symbols of the cursor position
nmap gk <Plug>(gosh_info_start_search_with_cur_keyword)
imap <C-A> <Plug>(gosh_info_start_search_with_cur_keyword)
" jump to the symbol definition of the cursor position
nmap <F12> <Plug>(gosh_goto_define)
nmap <F11> <Plug>(gosh_goto_define_split)

"set color scheme"
colorscheme hybrid

"encoding
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8
set fileencodings+=ucs-bom,euc-jp,cp932,sjis,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2
",utf-8
set fileformats=unix,dos,mac

"set split direction
set splitright

"show line number
set nu

"set whichwrap=b,s,[,],<,>

"save history
set history=100

"fix cursor pos
set ambiwidth=double

"backspace key extention
set backspace=indent,eol,start

"--------------------
"Vimclojure
"--------------------
"let vimclojure#WantNailgun=1
"let vimclojure#NailgunClient="ng"

"--------------------
"Clojure
"--------------------
"key bind
"- cqp: open REPL window.
"- cqc: open command line window.
"- cqq: code execution from history.
"- [<C-D>:
"- ]<C-D>: view source code of a function under the cursor.
"- <C-W><C-D>:
"- <C-W>d: open the window the source code of the function under the cursor.
"- gf: open the file of the namespace under the cursor.
"command
"- Eval: evaluation of a function under the cursor.
"- Eval (foo args): evaluation of a function 'foo'.
"- %Eval: evaluation of this file.
"- Last: view the results of the last executed.
"- Doc println: see the documentation for 'println'.
"- FindDoc prin: search 'prin' from the document.
"- Source println: view source code of 'println'.
"- Apropos print: search for 'print' in the namespace that is currently loaded.
"- Console: run lein repl.

autocmd FileType clojure call s:VimClojureInitialize()
command! Crepl :call s:InitCrepl('v')
command! HCrepl :call s:InitCrepl('h')
command! VCrepl :call s:InitCrepl('v')

"--------------------
"unite-haskellimport
"--------------------
"cabal update && cabal install hoogle && hoogle data
":Unite haskellimport
":UniteWithCursorWord haskellimport

autocmd FileType haskell nnoremap <buffer> <C-i>UniteWithCursorWord haskellimport<Cr>
autocmd FileType haskell call s:ghcmodcheck()
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let g:necoghc_enable_detailed_browse = 1

"--------------------
"syntastic
"--------------------
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_check_on_open=1
highlight SyntasticErrorSign guifg=white guibg=red
highlight SyntasticErrorLine guibg=#2f0000
let g:syntastic_always_populate_loc_list = 1

"--------------------
"neocomplcache
"--------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1

" Use smartcase.
let g:neocomplcache_enable_smartcase = 1

" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Close popup.
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"

" Decision selected candidacy.
inoremap <expr><C-y> neocomplcache#close_popup()

" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

"--------------------
"search
"--------------------

"capital letter small letter is not identified
set ignorecase
set smartcase

"return first
set wrapscan

"incremental search
set incsearch

"emphasis
set hlsearch

"--------------------
"display
"--------------------

"tab
set ts=2 sw=2 sts=2

"auto indent
set autoindent

"display title
set title

"comandline height
set cmdheight=2
set laststatus=2

"display comand in statusline
set showcmd

"last line is displayed as much as possible
set display=lastline

"display tab and space of end of line
set list
set listchars=tab:^\ ,trail:~

"enable highlight
if &t_Co > 2 || has('gui_running')
	syntax on
endif

"display converted hex and char code in statusline
function! s:SetStatusLine()
	if has('iconv')
		set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\
	else
		set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L%8P\
	endif
endfunction
call s:SetStatusLine()

function! FencB()
	let c = matchstr(getline(','), '.', col('.') - 1)
	let c = iconv(c, &enc, &fenc)
	return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
	return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
	return join(map(copy(a:bytes), 'printf("%20X", v:val)'), '')
endfunction

"--------------------
"insert mode
"--------------------

"change statusline color
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call s:StatusLine('Enter')
		autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
	if a:mode == 'Enter'
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		highlight clear StatusLine
		silent exec s:slhlcmd
		redraw
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight ' . a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '' , 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction

function! s:VimClojureInitialize()
	let g:vimclojure#HighlightBuiltins=1
	let g:vimclojure#HighlightContrib=1
	let g:vimclojure#DynamicHighlighting=1
	let g:vimclojure#ParenRainbow=1
	call s:SetStatusLine()
endfunction

"open window and run clojure repl
function! s:InitCrepl(c)
	exec 'only'
	if a:c == 'v'
		let sp = '30vs'
	elseif a:c == 'h'
		let sp = '6sp'
	endif
	exec sp . ' +VimShell'
	exec 'VimShellSendString lein repl'
	exec 'wincmd w'
endfunction

function! s:ghcmodcheck()
	augroup ghcmodcheck
		autocmd! BufWritePost <buffer> GhcModCheckAsync
	augroup END
endfunction
