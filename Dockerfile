# Read the Docs - Environment base (multi-stage)
#
# Two variants share a common ``base`` stage:
#
#   ``nopdf`` — system deps + asdf + user setup. ~1 GB uncompressed,
#               ~400–600 MB compressed. Use this for projects that
#               don't render PDF output. Cold-starts on Fargate in ~10–20s.
#
#   ``pdf``   — adds TeX Live + CJK / fonts on top of ``nopdf``.
#               ~7.5 GB uncompressed, ~3 GB compressed. Use for projects
#               with ``formats: [pdf, ...]`` in ``.readthedocs.yaml``.
#
# Build locally:
#   docker build --target nopdf -t readthedocs/build:ubuntu-26.04-nopdf .
#   docker build --target pdf   -t readthedocs/build:ubuntu-26.04      .
#
# The second build mostly reuses the cached ``base`` stage, so the
# incremental cost is just TeX Live.

# ============================================================
# Stage 1: shared base
# ============================================================
FROM ubuntu:26.04 AS base

LABEL maintainer="Read the Docs <support@readthedocs.com>"
LABEL version="ubuntu-26.04-2026.03.19"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

USER root
WORKDIR /

# Single ``RUN`` for all system deps. Three things cut size vs. the old
# split-across-many-RUNs layout:
#   1. ``--no-install-recommends`` skips optional deps (~200–500 MB).
#   2. ``apt-get clean`` + ``rm -rf /var/lib/apt/lists/*`` keeps cache
#      files out of the final layer (~100–300 MB).
#   3. One RUN = one layer = no per-layer metadata overhead, and apt can
#      resolve all deps in a single pass.
#
# Packages intentionally **dropped** vs. the prior Dockerfile:
#   - ``vim``, ``software-properties-common`` — not used during builds.
#   - ``libjpeg8-dev`` — superseded by ``libjpeg-dev``.
#   - ``libxslt-dev`` — covered by ``libxslt1-dev``.
#   - ``coreutils`` — always present in the base image.
#   - ``libreadline6-dev`` — modern name is ``libreadline-dev``.
#   - ``rustc`` — was ~285 MB only for some Ruby gems (bigdecimal etc.).
#     Projects that need it can install via the asdf-managed Rust.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        # Core toolchain
        build-essential \
        ca-certificates \
        curl \
        wget \
        git-core \
        mercurial \
        subversion \
        bzr \
        pkg-config \
        # Compilers / build helpers (asdf Python/Node/Ruby/etc. native ext builds)
        autoconf \
        patch \
        make \
        g++ \
        llvm \
        # Compression / archive
        bzip2 \
        xz-utils \
        # Library headers needed by pip packages building C extensions
        libbz2-dev \
        libcairo2-dev \
        libdb-dev \
        libenchant-2-2 \
        libevent-dev \
        libffi-dev \
        libfreetype6 \
        libfreetype6-dev \
        libgdbm6 \
        libgdbm-dev \
        libgmp-dev \
        libgraphviz-dev \
        libjpeg-dev \
        liblcms2-dev \
        liblzma-dev \
        libmysqlclient-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libpq-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libtiff5-dev \
        libwebp-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libxslt1-dev \
        libyaml-dev \
        tk-dev \
        uuid-dev \
        zlib1g-dev \
        # asdf nodejs deps (GPG key verification)
        dirmngr \
        gpg \
        # Doc tooling
        doxygen \
        graphviz-dev \
        pandoc \
        postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# UID and GID from readthedocs/user. Combined into one RUN.
RUN groupadd --gid 205 docs \
    && useradd -m --uid 1005 --gid 205 docs

USER docs
WORKDIR /home/docs

# asdf + plugins + install dirs — one RUN to avoid 8 small layers.
ENV PATH=/home/docs/.asdf/shims:/home/docs/.asdf/bin:$PATH
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --depth 1 --branch v0.14.0 \
    && echo ". /home/docs/.asdf/asdf.sh" >> /home/docs/.bashrc \
    && echo ". /home/docs/.asdf/completions/asdf.bash" >> /home/docs/.bashrc \
    && asdf plugin add python \
    && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git \
    && asdf plugin add rust https://github.com/code-lever/asdf-rust.git \
    && asdf plugin add golang https://github.com/kennyp/asdf-golang.git \
    && asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git \
    && mkdir -p /home/docs/.asdf/installs/python \
                /home/docs/.asdf/installs/nodejs \
                /home/docs/.asdf/installs/rust \
                /home/docs/.asdf/installs/golang \
                /home/docs/.asdf/installs/ruby

CMD ["/bin/bash"]


# ============================================================
# Stage 2 (variant A): no-PDF — ships as-is from ``base``
# ============================================================
FROM base AS nopdf
# Nothing extra. This is the slim image.


# ============================================================
# Stage 2 (variant B): PDF — adds TeX Live and CJK fonts
# ============================================================
FROM base AS pdf

USER root

# ``texlive-full`` is a meta-package that already depends on
# ``texlive-fonts-extra``, ``texlive-fonts-recommended``,
# ``texlive-lang-english``, ``texlive-lang-japanese``, etc. — installing
# them individually first AND then ``texlive-full`` (as the prior
# Dockerfile did) just paid for the same content twice across layers.
# Single install pulls in everything once.
#
# Add only the packages NOT covered by ``texlive-full``:
#   - latex-cjk-chinese-arphic-* : CJK font packs (see #6319).
#   - fonts-symbola / lmodern / fonts-noto-cjk-extra / fonts-hanazono:
#     extra fonts called out in #5494, #6319.
#   - xindy: non-ASCII index generation (see #4454).
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        texlive-full \
        latex-cjk-chinese-arphic-bkai00mp \
        latex-cjk-chinese-arphic-gbsn00lp \
        latex-cjk-chinese-arphic-gkai00mp \
        fonts-symbola \
        fonts-noto-cjk-extra \
        fonts-hanazono \
        lmodern \
        xindy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

USER docs

CMD ["/bin/bash"]
