# Read the Docs - Environment base
FROM ubuntu:18.04
LABEL mantainer="Read the Docs <support@readthedocs.com>"
LABEL version="5.0.0rc1"

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app
ENV LANG C.UTF-8

# Versions, and expose labels for external usage
ENV PYTHON_VERSION_27 2.7.15
ENV PYTHON_VERSION_36 3.6.8
ENV PYTHON_VERSION_37 3.7.2
ENV CONDA_VERSION 4.5.11
LABEL python.version_27=$PYTHON_VERSION_27
LABEL python.version_36=$PYTHON_VERSION_36
LABEL python.version_37=$PYTHON_VERSION_37
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
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
RUN apt-get install -y \
    make libssl-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils \
    tk-dev liblzma-dev python-openssl

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

# plantuml: is to support sphinxcontrib-plantuml
# https://pypi.org/project/sphinxcontrib-plantuml/
#
# imagemagick: is to support sphinx.ext.imgconverter
# http://www.sphinx-doc.org/en/master/usage/extensions/imgconverter.html
#
# rsvg-convert: is for SVG -> PDF conversion
# using Sphinx extension sphinxcontrib.rsvgconverter, see
# https://github.com/missinglinkelectronics/sphinxcontrib-svg2pdfconverter
RUN apt-get -y install plantuml imagemagick librsvg2-bin

# Install Python tools/libs
RUN apt-get -y install python-pip && pip install -U virtualenv auxlib

# Install jsdoc and typedoc
RUN apt-get -y install nodejs npm && npm install --global jsdoc typedoc

# UID and GID from readthedocs/user
RUN groupadd --gid 205 docs
RUN useradd -m --uid 1005 --gid 205 docs

USER docs
WORKDIR /home/docs

# Install Conda
RUN curl -O https://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh
RUN bash Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -b -p /home/docs/.conda/
ENV PATH $PATH:/home/docs/.conda/bin
RUN rm -f Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh

# Install pyenv
RUN git clone --depth 1 https://github.com/yyuu/pyenv.git ~docs/.pyenv
ENV PYENV_ROOT /home/docs/.pyenv
ENV PATH /home/docs/.pyenv/shims:$PATH:/home/docs/.pyenv/bin

# Install supported Python versions
RUN pyenv install $PYTHON_VERSION_27 && \
    pyenv install $PYTHON_VERSION_37 && \
    pyenv install $PYTHON_VERSION_36 && \
    pyenv global \
        $PYTHON_VERSION_27 \
        $PYTHON_VERSION_37 \
        $PYTHON_VERSION_36

WORKDIR /tmp

RUN pyenv local $PYTHON_VERSION_27 && \
    pyenv exec pip install --no-cache-dir -U pip && \
    pyenv exec pip install --no-cache-dir --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install --no-cache-dir pandas matplotlib virtualenv

RUN pyenv local $PYTHON_VERSION_37 && \
    pyenv exec pip install --no-cache-dir -U pip && \
    pyenv exec pip install --no-cache-dir --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install --no-cache-dir pandas matplotlib virtualenv

RUN pyenv local $PYTHON_VERSION_36 && \
    pyenv exec pip install --no-cache-dir -U pip && \
    pyenv exec pip install --no-cache-dir --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install --no-cache-dir pandas matplotlib virtualenv

WORKDIR /

CMD ["/bin/bash"]
