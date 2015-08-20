# Read the Docs - Environment base
FROM ubuntu:14.04
MAINTAINER Read the Docs <support@readthedocs.com>

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app

# System dependencies
RUN apt-get -y update
RUN apt-get -y install build-essential g++
RUN apt-get -y install \
    vim software-properties-common python3-setuptools python3 python3-dev \
    python-setuptools python-dev git-core postgresql-client libpq-dev \
    subversion graphviz curl sqlite libxml2-dev libxslt-dev python-numpy \
    python-scipy libevent-dev libmysqlclient-dev python-m2crypto libffi-dev \
    python-matplotlib graphviz-dev libenchant1c2a pandoc
RUN apt-get -y install texlive-latex-extra texlive-fonts-recommended

RUN easy_install3 pip
RUN easy_install-2.7 pip
RUN pip3 install -U virtualenv
RUN pip2 install -U virtualenv

# UID and GID from readthedocs/user
RUN groupadd --gid 205 docs
RUN useradd -m --uid 1005 --gid 205 docs

USER docs

CMD ["/bin/bash"]
