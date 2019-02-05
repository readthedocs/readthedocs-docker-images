# Read the Docs - Environment base
FROM ubuntu:16.04
MAINTAINER Read the Docs <support@readthedocs.com>
LABEL version="3.0.0"

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app
ENV LANG C.UTF-8

# Versions, and expose labels for querying image metadata
ENV PYTHON_VERSION_27 2.7.13
ENV PYTHON_VERSION_33 3.3.6
ENV PYTHON_VERSION_34 3.4.7
ENV PYTHON_VERSION_35 3.5.4
ENV PYTHON_VERSION_36 3.6.2
ENV CONDA_VERSION 4.5.12
LABEL python.version_27=$PYTHON_VERSION_27
LABEL python.version_33=$PYTHON_VERSION_33
LABEL python.version_34=$PYTHON_VERSION_34
LABEL python.version_35=$PYTHON_VERSION_35
LABEL python.version_36=$PYTHON_VERSION_36
LABEL conda.version=$CONDA_VERSION

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
    latex-cjk-chinese-arphic-gbsn00lp latex-cjk-chinese-arphic-gkai00mp \
    fonts-symbola

# Install plantuml
RUN apt-get -y install plantuml

# Install Python tools/libs
RUN apt-get -y install python-pip && pip install -U virtualenv auxlib

# UID and GID from readthedocs/user
RUN groupadd --gid 205 docs
RUN useradd -m --uid 1005 --gid 205 docs

# Install jsdoc
RUN apt-get -y install nodejs nodejs-legacy npm && npm install --global jsdoc

USER docs
WORKDIR /home/docs

# Install Conda
RUN curl -O https://repo.continuum.io/miniconda/Miniconda2-${CONDA_VERSION}-Linux-x86_64.sh
RUN bash Miniconda2-${CONDA_VERSION}-Linux-x86_64.sh -b -p /home/docs/.conda/
ENV PATH $PATH:/home/docs/.conda/bin

# Install pyenv
RUN git clone --depth 1 https://github.com/yyuu/pyenv.git ~docs/.pyenv
ENV PYENV_ROOT /home/docs/.pyenv
ENV PATH /home/docs/.pyenv/shims:$PATH:/home/docs/.pyenv/bin

# Install supported Python versions
RUN pyenv install $PYTHON_VERSION_27 && \
    pyenv install $PYTHON_VERSION_36 && \
    pyenv install $PYTHON_VERSION_35 && \
    pyenv install $PYTHON_VERSION_34 && \
    pyenv install $PYTHON_VERSION_33 && \
    pyenv global \
        $PYTHON_VERSION_27 \
        $PYTHON_VERSION_36 \
        $PYTHON_VERSION_35 \
        $PYTHON_VERSION_34 \
        $PYTHON_VERSION_33

WORKDIR /tmp

RUN pyenv local $PYTHON_VERSION_27 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install pandas matplotlib virtualenv

RUN pyenv local $PYTHON_VERSION_36 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install pandas matplotlib virtualenv

RUN pyenv local $PYTHON_VERSION_35 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install pandas matplotlib virtualenv

RUN pyenv local $PYTHON_VERSION_34 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install pandas matplotlib virtualenv

RUN pyenv local $PYTHON_VERSION_33 && \
    pyenv exec pip install -U pip && \
    pyenv exec pip install --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install "pandas<0.18" "matplotlib<1.5" virtualenv && \
    pyenv local --unset

WORKDIR /

CMD ["/bin/bash"]
