# Read the Docs - Sphinx Only Image
#
# This image only has a base sphinx and python environment.
# It can't create PDF's and doesn't have special C libraries.

FROM ubuntu:16.04
MAINTAINER Read the Docs <support@readthedocs.com>
LABEL version="base"

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app
ENV LANG C.UTF-8

# System dependencies
RUN apt-get -y update
RUN apt-get -y install vim software-properties-common
RUN apt-get -y install python-setuptools python3-setuptools python-dev python3-dev

# Version control and basic building utilies
RUN apt-get -y install bzr subversion git-core mercurial build-essential 

# from readthedocs.build
RUN apt-get -y install graphviz graphviz-dev pandoc doxygen 

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
env PATH $PATH:/home/docs/.conda/bin

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
