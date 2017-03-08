# Read the Docs - Environment base
FROM readthedocs/base:latest
MAINTAINER Read the Docs <support@readthedocs.com>
LABEL version="2.0"

# from readthedocs.common
RUN apt-get -y install libpq-dev libxml2-dev libxslt-dev libxslt1-dev postgresql-client libmysqlclient-dev

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

CMD ["/bin/bash"]
