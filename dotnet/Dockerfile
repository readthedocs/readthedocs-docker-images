# Read the Docs - Advanced image
#
# This image is for resource-intensive toolchains and build tools with
# special requirements

FROM readthedocs/build:latest
MAINTAINER Read the Docs <support@readthedocs.com>

# .NET support - Mono, DNVM, and docfx installation
ENV USER_HOME /home/docs
ENV DNX_VERSION 1.0.0-rc1-update1
ENV DOCFX_VERSION 1.3.0

USER root
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | \
    sudo tee /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get update
RUN apt-get install -y mono-complete mono-devel unzip

USER docs

RUN curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | \
    DNX_BRANCH=dev sh

RUN bash -c "source $USER_HOME/.dnx/dnvm/dnvm.sh && \
    dnvm install -p $DNX_VERSION"
RUN bash -c "source $USER_HOME/.dnx/dnvm/dnvm.sh && \
    dnu commands install docfx $DOCFX_VERSION"

ENV PATH /home/docs/.dnx/runtimes/dnx-mono.$DNX_VERSION/bin:/home/docs/.dnx/bin:$PATH

CMD ["/bin/bash"]
