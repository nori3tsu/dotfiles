"---------------------------------------------------------------------------
" Patch
"---------------------------------------------------------------------------
" jedi-vim
" === let g:jedi#popup_select_first = 0 が効かない問題に対応: 2013/11/06
" ~/.vim/bundle/jedi-vim/ftplugin/python/jedi.vim
" -----
"let s:save_cpo = &cpo
"set cpo&vim

"if g:jedi#popup_select_first == 0
  "inoremap <buffer> . .<C-R>=jedi#complete_opened() ? "" : "\<lt>C-X>\<lt>C-O>\<lt>C-P>"<CR>
"endif

"let &cpo = s:save_cpo
"unlet s:save_cpo
" -----


" release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

"===========================================================================
" Unite本体
"===========================================================================
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
    " NeoBundleが存在しない、
    " もしくはVimのバージョンが古い場合はプラグインを一切読み込まない
    let s:noplugin = 1
else
    " NeoBundleを'runtimepath'に追加し初期化を行う
    if has('vim_starting')
        execute "set runtimepath+=" . s:neobundle_root
    endif
    call neobundle#rc(s:bundle_root)

    " NeoBundle自身をNeoBundleで管理させる NeoBundleFetch 'Shougo/neobundle.vim'

    " 非同期通信を可能にする
    " 'build'が指定されているのでインストール時に自動的に
    " 指定されたコマンドが実行され vimproc がコンパイルされる
    NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}

    "===========================================================================
    " Unite
    "===========================================================================
    "---------------------------------------------------------------------------
    " Unite本体
    "---------------------------------------------------------------------------
    NeoBundleLazy "Shougo/unite.vim", {
          \ "autoload": {
          \   "commands": ["Unite", "UniteWithBufferDir"]
          \ }}
    nnoremap [unite] <Nop>
    nmap U [unite]
    nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
    nnoremap <silent> [unite]r :<C-u>Unite register<CR>
    nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
    nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
    nnoremap <silent> [unite]w :<C-u>Unite window<CR>
    let s:hooks = neobundle#get_hooks("unite.vim")
    function! s:hooks.on_source(bundle)
        " タブで開く
        call unite#custom_default_action('file', 'tabopen')
        au FileType unite nnoremap <silent> <buffer> <expr> <S-t> unite#do_action('tabopen')
        au FileType unite inoremap <silent> <buffer> <expr> <S-t> unite#do_action('tabopen')

        " start unite in insert mode
        let g:unite_enable_start_insert = 1
        " use vimfiler to open directory
        call unite#custom_default_action("source/bookmark/directory", "vimfiler")
        call unite#custom_default_action("directory", "vimfiler")
        call unite#custom_default_action("directory_mru", "vimfiler")
        autocmd MyAutoCmd FileType unite call s:unite_settings()
        function! s:unite_settings()
            imap <buffer> <Esc><Esc> <Plug>(unite_exit)
            nmap <buffer> <Esc> <Plug>(unite_exit)
            nmap <buffer> <C-n> <Plug>(unite_select_next_line)
            nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
        endfunction
    endfunction

    "---------------------------------------------------------------------------
    " アウトライン
    "---------------------------------------------------------------------------
    NeoBundleLazy 'h1mesuke/unite-outline', {
          \ "autoload": {
          \   "unite_sources": ["outline"],
          \ }}

    "---------------------------------------------------------------------------
    " ファイラ
    "---------------------------------------------------------------------------
    NeoBundleLazy "Shougo/vimfiler", {
          \ "depends": ["Shougo/unite.vim"],
          \ "autoload": {
          \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
          \   "mappings": ['<Plug>(vimfiler_switch)'],
          \   "explorer": 1,
          \ }}
    nnoremap <Leader>e :VimFilerExplorer<CR>
    "autocmd VimEnter * :VimFiler -buffer-name=explorer -split -toggle -no-quit -winwidth=35
    "autocmd VimEnter * :VimFilerExplorer
    " close vimfiler automatically when there are only vimfiler open
    "autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
    let s:hooks = neobundle#get_hooks("vimfiler")
    function! s:hooks.on_source(bundle)
        let g:vimfiler_edit_action='tabopen'
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_enable_auto_cd = 1

        " Safe Mode 無効
        let g:vimfiler_safe_mode_by_default = 0
        let g:netrw_liststyle = 3

        " .から始まるファイルおよび.pycで終わるファイルを不可視パターンに
        let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"

        " vimfiler specific key mappings
        autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
        function! s:vimfiler_settings()
            " ^^ to go up
            nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
            " use R to refresh
            nmap <buffer> R <Plug>(vimfiler_redraw_screen)
            " overwrite C-l
            nmap <buffer> <C-l> <C-w>l
        endfunction
    endfunction


    "===========================================================================
    " 表示
    "===========================================================================
    "---------------------------------------------------------------------------
    " ウィンドウサイズ制御
    "---------------------------------------------------------------------------
    NeoBundle "jimsei/winresizer"

    "---------------------------------------------------------------------------
    " カラースキーム
    "---------------------------------------------------------------------------
    "NeoBundle 'tomasr/molokai'
    NeoBundle 'nanotech/jellybeans.vim'

    "---------------------------------------------------------------------------
    " ステータスライン
    "---------------------------------------------------------------------------
    NeoBundle 'itchyny/lightline.vim'
    let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }
    set laststatus=2

    "---------------------------------------------------------------------------
    " TODO管理
    "---------------------------------------------------------------------------
    NeoBundleLazy "vim-scripts/TaskList.vim", {
        \ "autoload": {
        \   "mappings": ['<Plug>TaskList'],
        \}}
    nmap <Leader>T <plug>TaskList


    "---------------------------------------------------------------------------
    " 構文エラー表示
    "---------------------------------------------------------------------------
    NeoBundleLazy "scrooloose/syntastic", {
        \ "build": {
        \   "mac": ["pip install flake8", "npm -g install coffeelint"],
        \   "unix": ["pip install flake8", "npm -g install coffeelint"],
        \ }}

    "---------------------------------------------------------------------------
    " クラスアウトライン
    "---------------------------------------------------------------------------
    NeoBundleLazy 'majutsushi/tagbar', {
        \ "autoload": {
        \   "commands": ["TagbarToggle"],
        \ },
        \ "build": {
        \   "mac": "brew install ctags",
        \ }}
    nmap <Leader>o :TagbarToggle<CR>


    "===========================================================================
    " 検索
    "===========================================================================
    "---------------------------------------------------------------------------
    " 検索結果数表示
    "---------------------------------------------------------------------------
    NeoBundle "osyo-manga/vim-anzu"
    " mapping
    nmap n <Plug>(anzu-n-with-echo)
    nmap N <Plug>(anzu-N-with-echo)
    nmap * <Plug>(anzu-star-with-echo)
    nmap # <Plug>(anzu-sharp-with-echo)

    " clear status
    nmap <silent> <ESC><ESC> :<C-u>nohlsearch<CR><Plug>(anzu-clear-search-status)

    " statusline
    set statusline=%{anzu#search_status()}


    "===========================================================================
    " 編集
    "===========================================================================
    "---------------------------------------------------------------------------
    " ヤンク循環
    "---------------------------------------------------------------------------
    NeoBundle "vim-scripts/YankRing.vim"

    "---------------------------------------------------------------------------
    " 引用符整形
    "---------------------------------------------------------------------------
    NeoBundle "tpope/vim-surround"

    "---------------------------------------------------------------------------
    " テキスト整形
    "---------------------------------------------------------------------------
    NeoBundle "vim-scripts/Align"

    "---------------------------------------------------------------------------
    " コメント整形
    "---------------------------------------------------------------------------
    NeoBundle "scrooloose/nerdcommenter", {
        \ "autoload": {
        \   "mappings": ['<Plug>NERDCommenterToggle'],
        \}}
    let s:hooks = neobundle#get_hooks("nerdcommenter")
    function! s:hooks.on_source(bundle)
        let NERDSpaceDelims = 1
    endfunction
    nmap ,, <Plug>NERDCommenterToggle
    vmap ,, <Plug>NERDCommenterToggle


    "---------------------------------------------------------------------------
    " undo強化
    "---------------------------------------------------------------------------
    NeoBundleLazy "sjl/gundo.vim", {
        \ "autoload": {
        \   "commands": ['GundoToggle'],
        \}}
    nnoremap <Leader>g :GundoToggle<CR>


    "---------------------------------------------------------------------------
    " 補完
    "---------------------------------------------------------------------------
    if has('lua') && v:version >= 703 && has('patch885')
        NeoBundleLazy "Shougo/neocomplete.vim", {
            \ "autoload": {
            \   "insert": 1,
            \ }}
        " 2013-07-03 14:30 NeoComplCacheに合わせた
        let g:neocomplete#enable_at_startup = 1
        let s:hooks = neobundle#get_hooks("neocomplete.vim")
        function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplet#enable_smart_case = 1
            " NeoCompleteを有効化
            " NeoCompleteEnable
        endfunction
    else
        NeoBundleLazy "Shougo/neocomplcache.vim", {
            \ "autoload": {
            \   "insert": 1,
            \ }}
        " 2013-07-03 14:30 原因不明だがNeoComplCacheEnableコマンドが見つからないので変更
        let g:neocomplcache_enable_at_startup = 1
        let s:hooks = neobundle#get_hooks("neocomplcache.vim")
        function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_smart_case = 1
            " NeoComplCacheを有効化
            " NeoComplCacheEnable
        endfunction
    endif

    "---------------------------------------------------------------------------
    " スニペット
    "---------------------------------------------------------------------------
    NeoBundleLazy "Shougo/neosnippet.vim", {
        \ "depends": ["honza/vim-snippets"],
        \ "autoload": {
        \   "insert": 1,
        \ }}
    let s:hooks = neobundle#get_hooks("neosnippet.vim")
    function! s:hooks.on_source(bundle)
        " Plugin key-mappings.
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)
        " SuperTab like snippets behavior.
        imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"
        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
        " Enable snipMate compatibility feature.
        let g:neosnippet#enable_snipmate_compatibility = 1
        " Tell Neosnippet about the other snippets
        let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'

    endfunction


    "===========================================================================
    " 言語
    "===========================================================================
    " Python
    "---------------------------------------------------------------------------
    " コーディングスタイル
    "---------------------------------------------------------------------------
    NeoBundleLazy "andviro/flake8-vim", {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"],
        \ }}
    let s:hooks = neobundle#get_hooks("flake8-vim")
    function! s:hooks.on_source(bundle)
        "保存時に自動でチェック
        let g:PyFlakeOnWrite = 1

        "解析種別を設定
        let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'

        "McCabe複雑度の最大値
        let g:PyFlakeDefaultComplexity=10

        "visualモードでQを押すと自動で修正
        let g:PyFlakeRangeCommand = 'Q'
    endfunction


    "---------------------------------------------------------------------------
    " virtualenv
    "---------------------------------------------------------------------------
    NeoBundle "jmcantrell/vim-virtualenv"

    "---------------------------------------------------------------------------
    " 補完
    "---------------------------------------------------------------------------
    NeoBundleLazy "davidhalter/jedi-vim", {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"],
        \ },
        \ "build": {
        \   "mac": "pip install jedi",
        \   "unix": "pip install jedi",
        \ }}
    let s:hooks = neobundle#get_hooks("jedi-vim")
    function! s:hooks.on_source(bundle)
        " jediにvimの設定を任せると'completeopt+=preview'するので
        " 自動設定機能をoffにし手動で設定を行う
        let g:jedi#auto_vim_configuration = 1
        " quickrunと被るため大文字に変更
        let g:jedi#rename_command = '<leader>r'
        " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
        let g:jedi#goto_assignments_command = '<leader>g'
        " 補完の最初の項目が選択された状態だと使いにくいためオフにする
        let g:jedi#popup_select_first = 0
    endfunction


    "---------------------------------------------------------------------------
    " gf移動強化
    "---------------------------------------------------------------------------
    NeoBundleLazy "mkomitee/vim-gf-python", {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"],
        \ }}

    " Javascript
    "---------------------------------------------------------------------------
    " コーディングスタイル
    "---------------------------------------------------------------------------
    NeoBundleLazy "hallettj/jslint.vim", {
        \ "autoload": {
        \   "filetypes": ["javascript"],
        \ }}

    "---------------------------------------------------------------------------
    " jsdoc入力
    "---------------------------------------------------------------------------
    NeoBundleLazy "heavenshell/vim-jsdoc", {
        \ "autoload": {
        \   "filetypes": ["javascript"],
        \ }}
    let s:hooks = neobundle#get_hooks("vim-jsdoc")
    function! s:hooks.on_source(bundle)
        let g:jsdoc_default_mapping = 1
        nmap <silent> <C-c> <Plug>(jsdoc)
    endfunction

    " HTML
    "---------------------------------------------------------------------------
    " zen-coding
    "---------------------------------------------------------------------------
    NeoBundle "mattn/emmet-vim"
    let g:user_emmet_leader_key = '<C-e>'

    "---------------------------------------------------------------------------
    " vim上でプログラム実行
    "---------------------------------------------------------------------------
    NeoBundleLazy "thinca/vim-quickrun", {
        \ "autoload": {
        \   "mappings": [['nxo', '<Plug>(quickrun)']]
        \ }}
    nmap <Leader>r <Plug>(quickrun)
    let s:hooks = neobundle#get_hooks("vim-quickrun")
    function! s:hooks.on_source(bundle)
    "    let g:quickrun_config = {
    "        \ "*": {"runner": "remote/vimproc"},
    "        \ }
    endfunction

    " インストールされていないプラグインのチェックおよびダウンロード
    NeoBundleCheck
endif

" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on


"===========================================================================
" 基本設定
"===========================================================================
"---------------------------------------------------------------------------
" 表示関係
"---------------------------------------------------------------------------
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
"set colorcolumn=80      " その代わり80文字目にラインを入れる
set ruler               " ルーラーの表示
set cursorline          " カーソルラインの表示
"set cursorcolumn        " カーソルカラムの表示

" スクリーンベルを無効化
set t_vb=
set novisualbell

"全角スペースをハイライトさせる。
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=grey
endf
"syntaxの有無をチェックし、新規バッファと新規読み込み時にハイライトさせる
if has("syntax")
    syntax on
        augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif

" 不可視文字を変更
"set listchars=tab:^-,trail:-,extends:≫,precedes:≪,nbsp:%,eol:?
set listchars=tab:^\ ,trail:+

syntax on
set t_Co=256

"colorscheme molokai
colorscheme jellybeans

"---------------------------------------------------------------------------
" 検索関係
"---------------------------------------------------------------------------
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
"set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト
set nowrapscan          " 検索ループなし

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" 選択範囲を検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

"---------------------------------------------------------------------------
" 編集関係
"---------------------------------------------------------------------------
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
"set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set pastetoggle=<F12>   " ペーストモードに切り替え
set mouse=a             " マウス操作を有効化
"set clipboard+=autoselect      " visual selection -> clipboard
"set clipboard+=unnamed         " yank -> clipboard

" 連続インデント
set shiftwidth=4
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    " set clipboard& clipboard+=unnamedplus
    set clipboard& clipboard+=unnamedplus,unnamed
else
    " set clipboard& clipboard+=unnamed,autoselect
    set clipboard& clipboard+=unnamed
endif

" クリップボードからの貼り付け時に自動で set paste を実行
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" Swap/Backupファイルを無効化
set nowritebackup
set nobackup
set noswapfile

" angularのファイルタイプを設定
autocmd BufNewFile,BufRead *.html set filetype=html.angular_html

"---------------------------------------------------------------------------
" マクロおよびキー設定
"---------------------------------------------------------------------------
" leaderをSpaceに変更
map <Space> <leader>

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
"nnoremap <S-Left>  <C-w><<CR>
"nnoremap <S-Right> <C-w>><CR>
"nnoremap <S-Up>    <C-w>-<CR>
"nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" タブ関連を設定
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = fnamemodify(bufname(bufnr), ':t')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2       " 常にタブラインを表示
set expandtab           " タブ文字をスペースに変換
set tabstop=4           " タブ文字の空白数

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tl 次のタブ
map <silent> [Tag]l :tabnext<CR>
" th 前のタブ
map <silent> [Tag]h :tabprevious<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')

        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif

