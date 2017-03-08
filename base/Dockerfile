# Read the Docs - Sphinx Only Image
#
# This image only has a base sphinx and python environment.
# It can't create PDF's and doesn't have special C libraries.

FROM ubuntu:16.04
MAINTAINER Read the Docs <support@readthedocs.com>
LABEL version="latest"

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app
ENV LANG C.UTF-8

# System dependencies
RUN apt-get -y update
RUN apt-get -y install vim software-properties-common python-setuptools \
    python3-setuptools python3 python3-pip python-dev python3-dev

# Version control and basic building utilies
RUN apt-get -y install bzr subversion git-core mercurial build-essential 

# from readthedocs.build
RUN apt-get -y install graphviz graphviz-dev pandoc doxygen 

RUN easy_install3 pip
RUN easy_install pip
RUN pip3 install -U virtualenv auxlib
RUN pip2 install -U virtualenv auxlib

# UID and GID from readthedocs/user
RUN groupadd --gid 205 docs
RUN useradd -m --uid 1005 --gid 205 docs

USER docs

# Install miniconda as docs user
WORKDIR /home/docs
RUN curl -O https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh
RUN bash Miniconda2-4.3.11-Linux-x86_64.sh -b -p /home/docs/miniconda2/
env PATH $PATH:/home/docs/miniconda2/bin

CMD ["/bin/bash"]
