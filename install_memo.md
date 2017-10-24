Ubuntuにおけるインストールメモ
==============================

## 環境構築

- zshのインストール
	- .zshrcの設定(GitHubアカウントに上げる)

- vimの設定
	1. .vimディレクトリの作成
	2. .vimディレクトリ内にftpluginディレクトリの作成
	3. ftplugin内にpython編集用のpython.vimの作成(GiHubアカウントに上げる)
	4. .vimrcの設定(GitHubアカウントに上げる)
	5. .vim内にbundleディレクトリを作成し、NeoBundle用のソースをGitHubからクローン
	6. .vimrcにNeoBundle用の設定を追記

- Markdown環境の設定
    1. pandocのインストール : Pandocのウェブページ(http://pandoc.org/)より、pandoc-1.17.0.2-1-amd64.deb(最新版) をダウンロード
        > ` sudo dpkg -i pandoc-1.17.0.2-1-amd64.deb`
    1. pandocでmarkdownからPDFを生成するためにTeX環境が必要ですので、aptを使ってTeXLive 等をインストール
        > ` sudo apt install texlive texlive-lang-cjk texlive-luatex texlive-xetex`

- sshdの設定
	- ポートの変更は/etc/ssh/sshd_configを以下のように編集
		> ` Port ポート番号`
	- rootログインの禁止は/etc/ssh/sshd_configを以下のように編集
		> ` PermitRootLogin no`

- ファイアウォールの設定
	- ufwのインストール ` sudo apt-get -y install ufw`
	- ufwの設定
		- IPv6サポートのOFF
			> ` IPV6=no`
		- ポートの開放
			> ` sudo ufw allow ポート番号`
			>
		- 許可されたポート以外全てを閉鎖
			> ` sudo ufw default deny`
		- ufwの有効化
			> ` sudo ufw enable`

- CUDA Toolkitのインストール/設定, NVIDIA GPUカード用のドライバーのインストール
	- Toolkitとドライバーのインストールは、こちらの[サイト](https://help.sakura.ad.jp/hc/ja/articles/115000122721-CUDA-Toolkit-GPU%E3%82%AB%E3%83%BC%E3%83%89%E3%83%89%E3%83%A9%E3%82%A4%E3%83%90%E3%83%BC%E5%B0%8E%E5%85%A5%E6%89%8B%E9%A0%86)を参照
	- インストール後のToolkitの環境変数は、.zshrに$PATH, $LD_LIBRARY_PATH, $CUDA_HOMEの設定を追記
	- ドライバーに関してはインストール先が/usr/binになるので環境変数の設定は不要

- Proxy設定
	- aptの設定は/etc/apt/apt.confに以下を追記
		> Acquire::http://:proxy "http://IPアドレス:ポート番号/";
		> 
		> Acquire::https::proxy "http://IPアドレス:ポート番号/";
	- bashの設定は/etc/profileに以下を追記
		> export http_proxy="http://IPアドレス:ポート番号/"
	- zshの設定は/etc/zsh/zshenvに以下を追記
		> export http_proxy="http://IPアドレス:ポート番号/"
	- wgetの設定は/etc/wgetrcに以下を追記
		> https_proxy = http://IPアドレス:ポート番号/
		>
		> http_proxy = http://IPアドレス:ポート番号/

## データ解析関連の環境構築

- Ubuntu標準のPython(python 2.7.12)とPython3(pytho 3.5.2)を使う
	- python(python2)用のpipのインストール: `sudo apt-get -y install python-pip`
	- python3用のpipのインストール: `sudo apt-get -y install python3-pi`
	- pythonでデータ解析を行う上で必要になってくるライブラリのインストール
		- NumPy ` sudo pip3 install numpy`
		- SciPy ` sudo pip3 install scipy`
		- Pandas ` sudo pip3 install pandas`
		- scikit-learn ` sudo pip3 install scikit-learn`
		- matplotlib ` sudo pip3 install matplotlib`

- 自然言語処理環境
	- 形態素解析器 Mecabのインストール ` sudo apt-get install mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8`
	- mecab-ipadic-NEologd辞書のインストール
		> ` git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git`
		>
		> ` cd mecab-ipadic-neologd`
		>
		> ` ./bin/install-mecab-ipadic-neologd -n -a`
		- デフォルト辞書に設定 /etc/mecabrcを以下のように編集
			> ` dicdir = /usr/lib/mecab/dic/mecab-ipadic-neologd`
	- python3向けのMecabバインディングのインストール ` sudo pip3 install mecab-python3`
	- LDAを使うためにgensimをインストール ` sudo pip3 install gensim`
	- sjiからのutf8エンコーディングを行うためのツールのインストール
		> ` sudo apt-get -y install nkf`
		>
		> ` sudo apt-get -y install convmv`
	- wordcloudのインストール ` sudo pip3 install wordcloud`
		- wordcloudの描画に必要なモジュールのインストール ` sudo apt-get install -y python3-tk`
		- 日本語対応フォントのインストール ` sudo apt-get -y install fonts-ipafont-gothic`
	- グラフ構造を描画するためのツールのインストール
		> ` sudo apt-get -y install graphviz`
        >
       	> ` sudo pip3 install graphviz`
    - gensimの仕様でpython3.6以前を使ってると辞書配列がランダムのため、単語辞書とLDAモデルとの整合性がとれなくなるため、別で3.6をインストール
    	> ` sudo apt install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev openssl`
    	>
    	> ` mkdir -p $HOME/opt`
    	>
    	> ` cd $HOME/opt`
    	>
    	> ` curl -O https://www.python.org/ftp/python/3.6.0/Python-3.6.0rc2.tgz`
    	>
    	> ` tar -xzf Python-3.6.0rc2.tgz`
    	>
    	> ` cd Python-3.6.0rc2/`
    	>
    	> ` ./configure --enable-shared --prefix=/usr/local LDFLAGS="-Wl,--rpath=/usr/local/lib"`
    	>
    	> ` sudo make altinstall`
    	>
    	> ` python3.6 -V`
    	>
    	> ` >> Python 3.6.0rc2`
    	- ちみに上記のようにインストールするとpython3.6に対応したpipとsetup-toolsも一緒に入る
    		> ` pip3.6 -V`
    		>
    		> ` >> pip 9.0.1 from /usr/local/lib/python3.6/site-packages (python 3.6)`

- Jupyter環境構築
    - Jupyterのインストール ` sudo pip3 install jupyter`
	- Jupyterへのログイン時に用いるパスワードの生成
		> ` python3`
		>
		> ` from notebook.auth import passwd()`
		>
		> ` passwd()`
	- Jupyterの設定ファイルの生成 ` jupyter notebook --generate-config` -> ~/.jupyter/jupyter_notebook_config.pyが生成される
	- 設定ファイルの編集
		> c.NotebookApp.ip = '*'
		>
		> c.NotebookApp.open_browser = False
		>
		> c.NotebookApp.password = 'passwd()でハッシュされて生成されたパスワードを記載'
		>
		> c.NotebookApp.port = 30000
	- systemdでJupyterをサービス化
		- Unit定義ファイルを作成 ` sudo vim /etc/systemd/system/jupyter-notebook.service`
		- Unit定義ファイルの編集
			> [Unit]
			>
            > Description = Jupyter Notebook
            > 
            > [Service]
			>
            > Type=simple
			>
            > PIDFile=/var/run/jupyter-notebook.pid
			>
            > ExecStart=/usr/local/bin/jupyter notebook
			>
            > WorkingDirectory=/home/ユーザー名/jupyter_notebook
			>
            > User=ユーザー名
			>
            > Group=ユーザー名
			>
            > Restart=always
            > 
            > [Install]
			>
            > WantedBy = multi-user.target
		- 起動時に実行するように設定
			> ` systemctl enable jupyter-notebook`
			>
			> ` systemctl start jupyter-notebook`
	- Jupyterにextensionを追加 
		> ` sudo pip3 install jupyter_contrib_nbextensions`
		>
		> ` jupyter contrib nbextension install --user`
		- vim_bindingの追加
			> ` mkdir -p $(jupyter --data-dir)/nbextensions`
			>
			> ` cd $(jupyter --data-dir)/nbextensions`
			>
			> ` git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding`
			>
			> ` jupyter nbextension enable vim_binding/vim_binding`
		- Jupyterのthemeを変える
			> ` sudo pip3 install --upgrade jupyterthemes`
			>
			> ` jt -t oceans16 -vim -cellw 1600 -T -N`

- 深層学習環境
    - TensorFlowのインストール
        > ` sudo apt-get -y install libcupti-dev`
        >
        > ` sudo pip3.6 install tensorflow-gpu`
        >
