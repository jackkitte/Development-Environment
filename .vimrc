"起動時にruntimepathにNeoBundleのパスを追加する
if has('vim_starting')
	if &compatible
		set nocompatible
	endif
	set runtimepath+=/home/ユーザー名/.vim/bundle/neobundle.vim
endif 

"NeoBundle設定の開始"
call neobundle#begin(expand('/home/ユーザー名/.vim/bundle'))

"NeoBundleのバージョンをNeoBundle自身で管理する"
NeoBundleFetch 'Shougo/neobundle.vim'

"vimでmarkdownをリアルタイムプレビューする方法"
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

"NeoBundle設定の終了"
call neobundle#end()

"シンタックスハイライトの設定"
syntax on
"自動インデントの設定"
filetype plugin indent on

"""markdown {{{
autocmd BufRead,BufNewFile *.mkd  set filetype=markdown
autocmd BufRead,BufNewFile *.md  set filetype=markdown
"Need: kannokanno/previm
nnoremap <silent> <C-p> :PrevimOpen<CR> " Ctrl-pでプレビュー
"自動で折りたたまないようにする
let g:vim_markdown_folding_disabled=1
" }}}
