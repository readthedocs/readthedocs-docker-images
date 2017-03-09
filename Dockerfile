# Read the Docs - Environment base
FROM readthedocs/build:base
MAINTAINER Read the Docs <support@readthedocs.com>
LABEL version="latest"

USER root

# Install requirements
RUN apt-get -y install libpq-dev libxml2-dev libxslt-dev \
    libxslt1-dev build-essential postgresql-client libmysqlclient-dev curl \
    g++ libfreetype6 libbz2-dev libcairo2-dev \
    libenchant1c2a libevent-dev libffi-dev libfreetype6-dev \
    libgraphviz-dev libjpeg-dev libjpeg8-dev liblcms2-dev libreadline-dev \
    libtiff5-dev libwebp-dev pkg-config zlib1g-dev

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

USER docs

CMD ["/bin/bash"]
