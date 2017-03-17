# Read the Docs - Environment base
FROM ubuntu:16.04
MAINTAINER Read the Docs <support@readthedocs.com>
LABEL version="latest"

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app
ENV LANG C.UTF-8

# System dependencies
RUN apt-get -y update
RUN apt-get -y install vim software-properties-common

# Install requirements
RUN apt-get -y install \
    bzr subversion git-core mercurial libpq-dev libxml2-dev libxslt-dev \
    libxslt1-dev build-essential postgresql-client libmysqlclient-dev curl \
    doxygen g++ graphviz-dev libfreetype6 libbz2-dev libcairo2-dev \
    libenchant1c2a libevent-dev libffi-dev libfreetype6-dev \
    libgraphviz-dev libjpeg-dev libjpeg8-dev liblcms2-dev libreadline-dev \
    libsqlite3-dev libtiff5-dev libwebp-dev pandoc pkg-config zlib1g-dev

# pyenv extra requirements
RUN apt-get install -y \
    make libssl-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils

# LaTeX -- split to reduce image layer size
RUN apt-get -y install texlive-fonts-extra
RUN apt-get -y install texlive-latex-extra-doc texlive-publishers-doc \
    texlive-pictures-doc
RUN apt-get -y install texlive-lang-english texlive-lang-japanese
RUN apt-get -y install texlive-full
RUN apt-get -y install \
    texlive-fonts-recommended latex-cjk-chinese-arphic-bkai00mp \
    latex-cjk-chinese-arphic-gbsn00lp latex-cjk-chinese-arphic-gkai00mp

# Install plantuml
RUN apt-get -y install plantuml

# Install Python tools/libs
RUN apt-get -y install python-pip && pip install -U virtualenv auxlib

# UID and GID from readthedocs/user
RUN groupadd --gid 205 docs
RUN useradd -m --uid 1005 --gid 205 docs

USER docs
WORKDIR /home/docs

# Install Conda
RUN curl -O https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh
RUN bash Miniconda2-4.3.11-Linux-x86_64.sh -b -p /home/docs/.conda/
ENV PATH $PATH:/home/docs/.conda/bin

# Install pyenv
RUN git clone --depth 1 https://github.com/yyuu/pyenv.git ~docs/.pyenv
ENV PYENV_ROOT /home/docs/.pyenv
ENV PATH /home/docs/.pyenv/shims:$PATH:/home/docs/.pyenv/bin

# Install supported Python versions
RUN pyenv install 2.7.13 && \
    pyenv install 3.6.0 && \
    pyenv install 3.5.2 && \
    pyenv install 3.4.5 && \
    pyenv install 3.3.6 && \
    pyenv global 2.7.13 3.6.0 3.5.2 3.4.5 3.3.6

WORKDIR /tmp

RUN pyenv local 2.7.13 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install pandas matplotlib virtualenv

RUN pyenv local 3.6.0 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install pandas matplotlib virtualenv

RUN pyenv local 3.5.2 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install pandas matplotlib virtualenv

RUN pyenv local 3.4.5 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install pandas matplotlib virtualenv

RUN pyenv local 3.3.6 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install "pandas<0.18" "matplotlib<1.5" virtualenv && \
    pyenv local --unset

WORKDIR /

CMD ["/bin/bash"]
