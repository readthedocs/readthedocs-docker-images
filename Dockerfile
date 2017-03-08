# Read the Docs - Environment base
FROM ubuntu:16.04
MAINTAINER Read the Docs <support@readthedocs.com>
LABEL version="2.0"

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app
ENV LANG C.UTF-8

# System dependencies
RUN apt-get -y update
RUN apt-get -y install vim software-properties-common python-setuptools \
    python3-setuptools

# from readthedocs.common
RUN apt-get -y install bzr subversion git-core mercurial libpq-dev libxml2-dev \
    libxslt-dev libxslt1-dev build-essential python-dev postgresql-client \
    libmysqlclient-dev

# from readthedocs.build
RUN apt-get -y install libfreetype6 g++ sqlite libevent-dev libffi-dev \
    libenchant1c2a curl texlive-full python-m2crypto python-matplotlib \
    python-numpy python-scipy python-pandas graphviz graphviz-dev \
    libgraphviz-dev pandoc doxygen latex-cjk-chinese-arphic-gbsn00lp \
    latex-cjk-chinese-arphic-gkai00mp latex-cjk-chinese-arphic-bsmi00lp \
    latex-cjk-chinese-arphic-bkai00mp python3 python3-dev python3-pip \
    python3-matplotlib python3-numpy python3-scipy python3-pandas \
    texlive-latex-extra texlive-fonts-recommended pkg-config libjpeg-dev \
    libfreetype6-dev libtiff5-dev libjpeg8-dev zlib1g-dev liblcms2-dev \
    libwebp-dev libcairo2-dev

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
