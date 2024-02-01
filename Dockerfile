# Read the Docs - Environment base
FROM ubuntu:22.04
LABEL mantainer="Read the Docs <support@readthedocs.com>"
LABEL version="ubuntu-22.04-2024.01.29"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

USER root
WORKDIR /

# System dependencies
RUN apt-get -y update
RUN apt-get -y install \
      software-properties-common \
      vim

# Install requirements
RUN apt-get -y install \
      build-essential \
      bzr \
      curl \
      doxygen \
      g++ \
      git-core \
      graphviz-dev \
      libbz2-dev \
      libcairo2-dev \
      libenchant-2-2 \
      libevent-dev \
      libffi-dev \
      libfreetype6 \
      libfreetype6-dev \
      libgraphviz-dev \
      libjpeg8-dev \
      libjpeg-dev \
      liblcms2-dev \
      libmysqlclient-dev \
      libpq-dev \
      libreadline-dev \
      libsqlite3-dev \
      libtiff5-dev \
      libwebp-dev \
      libxml2-dev \
      libxslt1-dev \
      libxslt-dev \
      mercurial \
      pandoc \
      pkg-config \
      postgresql-client \
      subversion \
      zlib1g-dev

# LaTeX -- split to reduce image layer size
RUN apt-get -y install \
    texlive-fonts-extra
RUN apt-get -y install \
    texlive-lang-english \
    texlive-lang-japanese
RUN apt-get -y install \
    texlive-full

# lmodern: extra fonts
# https://github.com/rtfd/readthedocs.org/issues/5494
#
# xindy: is useful to generate non-ascii indexes
# https://github.com/rtfd/readthedocs.org/issues/4454
#
# fonts-noto-cjk-extra
# fonts-hanazono: chinese fonts
# https://github.com/readthedocs/readthedocs.org/issues/6319
RUN apt-get -y install \
    fonts-symbola \
    lmodern \
    latex-cjk-chinese-arphic-bkai00mp \
    latex-cjk-chinese-arphic-gbsn00lp \
    latex-cjk-chinese-arphic-gkai00mp \
    texlive-fonts-recommended \
    fonts-noto-cjk-extra \
    fonts-hanazono \
    xindy

# asdf Python extra requirements
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
RUN apt-get install -y \
    liblzma-dev \
    libncursesw5-dev \
    libssl-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils

# asdf nodejs extra requirements
# https://github.com/asdf-vm/asdf-nodejs#linux-debian
RUN apt-get install -y \
    dirmngr \
    gpg

# asdf Golang extra requirements
# https://github.com/kennyp/asdf-golang#linux-debian
RUN apt-get install -y \
    coreutils

# asdf Ruby extra requirements
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
RUN apt-get install -y \
    autoconf \
    patch \
    rustc \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    libgmp-dev \
    libncurses5-dev \
    libgdbm6 \
    libgdbm-dev \
    libdb-dev \
    uuid-dev


# UID and GID from readthedocs/user
RUN groupadd --gid 205 docs
RUN useradd -m --uid 1005 --gid 205 docs

USER docs
WORKDIR /home/docs

# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --depth 1 --branch v0.14.0
RUN echo ". /home/docs/.asdf/asdf.sh" >> /home/docs/.bashrc
RUN echo ". /home/docs/.asdf/completions/asdf.bash" >> /home/docs/.bashrc

# Activate asdf in current session
ENV PATH /home/docs/.asdf/shims:/home/docs/.asdf/bin:$PATH

# Install asdf plugins
RUN asdf plugin add python
RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN asdf plugin add rust https://github.com/code-lever/asdf-rust.git
RUN asdf plugin add golang https://github.com/kennyp/asdf-golang.git
RUN asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

# Create directories for languages installations
RUN mkdir -p /home/docs/.asdf/installs/python && \
    mkdir -p /home/docs/.asdf/installs/nodejs && \
    mkdir -p /home/docs/.asdf/installs/rust && \
    mkdir -p /home/docs/.asdf/installs/golang && \
    mkdir -p /home/docs/.asdf/installs/ruby

CMD ["/bin/bash"]
