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

# from readthedocs.build
RUN apt-get -y install graphviz libpq-dev libxml2-dev libxslt1-dev libfreetype6 build-essential g++ python-dev postgresql-client libmysqlclient-dev sqlite libevent-dev libffi-dev libenchant1c2a curl texlive-full python-m2crypto python-matplotlib python-numpy python-scipy graphviz graphviz-dev libgraphviz-dev pandoc doxygen latex-cjk-chinese-arphic-gbsn00lp latex-cjk-chinese-arphic-gkai00mp latex-cjk-chinese-arphic-bsmi00lp latex-cjk-chinese-arphic-bkai00mp python3 python3-dev python3-pip python3-matplotlib python3-numpy python3-scipy

# from readthedocs.common
RUN apt-get -y install bzr subversion git-core libpq-dev libxml2-dev libxslt1-dev build-essential python-dev postgresql-client libmysqlclient-dev


RUN easy_install3 pip
RUN easy_install-2.7 pip
RUN pip3 install -U virtualenv
RUN pip2 install -U virtualenv

# UID and GID from readthedocs/user
RUN groupadd --gid 205 docs
RUN useradd -m --uid 1005 --gid 205 docs

USER docs

CMD ["/bin/bash"]
