# Read the Docs - Hotfix for urllib3
#
# Instead of rebuilding this version, only rebuild the last few layers. This is
# to address some old binaries built against openssl < 1.1.1

FROM readthedocs/build:6.0
LABEL mantainer="Read the Docs <support@readthedocs.com>"
LABEL version="6.0.4-hotfix"

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app
ENV LANG C.UTF-8

# Versions, and expose labels for external usage
ENV RTD_PYTHON_VERSION_27 2.7.18
ENV RTD_PYTHON_VERSION_35 3.5.10
ENV RTD_PYTHON_VERSION_36 3.6.12
ENV RTD_PYTHON_VERSION_37 3.7.9
ENV RTD_PYTHON_VERSION_38 3.8.6
ENV RTD_PYPY_VERSION_35 pypy3.5-7.0.0

# Note: 4.7.12.1 drastically increases memory usage
ENV RTD_CONDA_VERSION 4.6.14

ENV RTD_PIP_VERSION 20.0.1
ENV RTD_SETUPTOOLS_VERSION 45.1.0
ENV RTD_VIRTUALENV_VERSION 16.7.9
LABEL python.version_27=$RTD_PYTHON_VERSION_27
LABEL python.version_35=$RTD_PYTHON_VERSION_35
LABEL python.version_36=$RTD_PYTHON_VERSION_36
LABEL python.version_37=$RTD_PYTHON_VERSION_37
LABEL python.version_38=$RTD_PYTHON_VERSION_38
LABEL pypy.version_35=$RTD_PYPY_VERSION_35
LABEL conda.version=$RTD_CONDA_VERSION


# Install a newer libssl (1.1.1) to compile Python SSL module with it
# Note that it removes `npm` and other packages. They have to be re-installed
# later in this Dockerfile
USER root
RUN apt-get update && \
    apt-get install -y libssl-dev

USER docs
WORKDIR /home/docs

# Install Conda
RUN curl -L -O https://repo.continuum.io/miniconda/Miniconda2-${RTD_CONDA_VERSION}-Linux-x86_64.sh
RUN bash Miniconda2-${RTD_CONDA_VERSION}-Linux-x86_64.sh -b -u -p /home/docs/.conda/
ENV PATH $PATH:/home/docs/.conda/bin
RUN rm -f Miniconda2-${RTD_CONDA_VERSION}-Linux-x86_64.sh

# Install pyenv
RUN wget https://github.com/pyenv/pyenv/archive/master.zip
RUN rm -rf ~docs/.pyenv && \
    unzip master.zip && \
    rm -f master.zip && \
    mv pyenv-master ~docs/.pyenv
ENV PYENV_ROOT /home/docs/.pyenv
ENV PATH /home/docs/.pyenv/shims:$PATH:/home/docs/.pyenv/bin

# Install supported Python versions
RUN pyenv install $RTD_PYTHON_VERSION_27 && \
    pyenv install $RTD_PYTHON_VERSION_38 && \
    pyenv install $RTD_PYTHON_VERSION_37 && \
    pyenv install $RTD_PYTHON_VERSION_35 && \
    pyenv install $RTD_PYTHON_VERSION_36 && \
    pyenv install $RTD_PYPY_VERSION_35 && \
    pyenv global \
        $RTD_PYTHON_VERSION_27 \
        $RTD_PYTHON_VERSION_38 \
        $RTD_PYTHON_VERSION_37 \
        $RTD_PYTHON_VERSION_36 \
        $RTD_PYTHON_VERSION_35 \
        $RTD_PYPY_VERSION_35

WORKDIR /tmp

RUN pyenv local $RTD_PYTHON_VERSION_27 && \
    pyenv exec pip install --no-cache-dir -U pip==20.0.1 && \
    pyenv exec pip install --no-cache-dir -U setuptools==44.0.0 && \
    pyenv exec pip install --no-cache-dir --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install --no-cache-dir pandas matplotlib virtualenv==16.7.9

RUN pyenv local $RTD_PYTHON_VERSION_38 && \
    pyenv exec pip install --no-cache-dir -U pip==$RTD_PIP_VERSION && \
    pyenv exec pip install --no-cache-dir -U setuptools==$RTD_SETUPTOOLS_VERSION && \
    pyenv exec pip install --no-cache-dir --only-binary numpy numpy && \
    pyenv exec pip install --no-cache-dir pandas matplotlib virtualenv==$RTD_VIRTUALENV_VERSION

RUN pyenv local $RTD_PYTHON_VERSION_37 && \
    pyenv exec pip install --no-cache-dir -U pip==$RTD_PIP_VERSION && \
    pyenv exec pip install --no-cache-dir -U setuptools==$RTD_SETUPTOOLS_VERSION && \
    pyenv exec pip install --no-cache-dir --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install --no-cache-dir pandas matplotlib virtualenv==$RTD_VIRTUALENV_VERSION

RUN pyenv local $RTD_PYTHON_VERSION_36 && \
    pyenv exec pip install --no-cache-dir -U pip==$RTD_PIP_VERSION && \
    pyenv exec pip install --no-cache-dir -U setuptools==$RTD_SETUPTOOLS_VERSION && \
    pyenv exec pip install --no-cache-dir --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install --no-cache-dir pandas matplotlib virtualenv==$RTD_VIRTUALENV_VERSION

RUN pyenv local $RTD_PYTHON_VERSION_35 && \
    pyenv exec pip install --no-cache-dir -U pip==$RTD_PIP_VERSION && \
    pyenv exec pip install --no-cache-dir -U setuptools==$RTD_SETUPTOOLS_VERSION && \
    pyenv exec pip install --no-cache-dir --only-binary numpy,scipy numpy scipy && \
    pyenv exec pip install --no-cache-dir pandas matplotlib virtualenv==$RTD_VIRTUALENV_VERSION

RUN pyenv local $RTD_PYPY_VERSION_35 && \
    pyenv exec python -m ensurepip && \
    pyenv exec pip3 install --no-cache-dir -U pip==$RTD_PIP_VERSION && \
    pyenv exec pip install --no-cache-dir -U setuptools==$RTD_SETUPTOOLS_VERSION && \
    pyenv exec pip install --no-cache-dir virtualenv==$RTD_VIRTUALENV_VERSION

USER root
RUN apt-get install -y libssl1.0-dev node-gyp nodejs-dev npm

USER docs
WORKDIR /

CMD ["/bin/bash"]
