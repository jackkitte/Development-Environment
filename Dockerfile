FROM ubuntu:latest
MAINTAINER tamash

# パッケージのインストールとアップデート
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install build-essential
RUN apt-get -y install git vim curl wget zsh sudo
RUN apt-get -y install language-pack-ja-base language-pack-ja
RUN apt-get -y install mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8
RUN apt-get -y install zlib1g-dev \
libssl-dev \
libreadline-dev \
libyaml-dev \
libxml2-dev \
libxslt-dev \
libncurses5-dev \
libncursesw5-dev 

# 日本語化
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

# ユーザーの追加
RUN useradd -m -d /home/tamash -s /bin/zsh -G sudo tamash
RUN echo 'tamash:tamash' | chpasswd
RUN echo 'tamash ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ENV HOME /home/tamash
ADD --chown=tamash:tamash .zshrc /home/tamash
USER tamash
WORKDIR /home/tamash
ADD --chown=tamash:tamash .vimrc /home/tamash
ADD --chown=tamash:tamash .vim /home/tamash/.vim
RUN curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
RUN sh ./installer.sh ~/.cache/dein
RUN rm installer.sh

# Neologism dictionary のインストール
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
WORKDIR /home/tamash/mecab-ipadic-neologd
RUN ./bin/install-mecab-ipadic-neologd -n -y

# pyenv のインストール
RUN git clone git://github.com/yyuu/pyenv.git ${HOME}/.pyenv
RUN git clone https://github.com/yyuu/pyenv-pip-rehash.git ${HOME}/.pyenv/plugins/pyenv-pip-rehash
ENV PYENV_ROOT ${HOME}/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN echo 'eval "$(pyenv init -)"' >> .zshrc

# anaconda のインストール
ENV ANACONDA_VER 5.2.0
ENV LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$PYENV_ROOT/versions/anaconda3-$ANACONDA_VER/lib
RUN pyenv install anaconda3-$ANACONDA_VER
RUN pyenv global anaconda3-$ANACONDA_VER
ENV PATH $PYENV_ROOT/versions/anaconda3-$ANACONDA_VER/bin:$PATH

# ライブラリのアップデート
RUN conda update -y conda
RUN pip install --upgrade pip
RUN pip install mecab-python3
RUN conda install -c conda-forge gensim
RUN conda install -c conda-forge wordcloud
RUN conda install -c conda-forge pygrib=2.0.2
RUN conda install -c conda-forge jpeg


RUN mkdir /home/tamash/work
ENTRYPOINT [ "/bin/zsh" ]