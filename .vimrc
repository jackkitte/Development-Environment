if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
 call dein#begin('~/.cache/dein')

 call dein#add('~/.cache/dein')
 call dein#add('Shougo/deoplete.nvim')
 call dein#add('kannokanno/previm')
 call dein#add('plasticboy/vim-markdown')
 call dein#add('tyru/open-browser.vim')
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif

 call dein#end()
 call dein#save_state()
endif

filetype plugin indent on
syntax enable

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

" PythonのFileTypeの設定
autocmd BufRead,BufNewFile *.py set filetype=python

"ファイル名を常に表示"
set laststatus=2
"「Tab」を「スペース」に置き換える
setl expandtab
"「Tab」の「インデント幅」を4にする
setl tabstop=2
"自動インデントした時の「インデント幅」を4にする
setl shiftwidth=2
"キーバインドの「Tab」キーを押した時のスペースの数
"0 を設定すると「tabstop」で設定された数のスペースが挿入される
setl softtabstop=0
"保存するタイミングで行末のスペースを除去する
autocmd BufWritePre * :$s/\s\+$//ge
