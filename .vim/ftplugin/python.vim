"「Tab」を「スペース」に置き換える
setl expandtab
"「Tab」の「インデント幅」を4にする
setl tabstop=4
"自動インデントした時の「インデント幅」を4にする
setl shiftwidth=4
"キーバインドの「Tab」キーを押した時のスペースの数
"0 を設定すると「tabstop」で設定された数のスペースが挿入される
setl softtabstop=0
"保存するタイミングで行末のスペースを除去する
autocmd BufWritePre * :$s/\s\+$//ge

