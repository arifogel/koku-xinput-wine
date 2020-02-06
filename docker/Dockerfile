# Setting the parent image to ubuntu
FROM i386/ubuntu:16.04
LABEL vendor="Koku"

# Set a Working Dir
USER root
WORKDIR /root/workdir

RUN apt-get update && apt-get install -y \
    build-essential \
    libsdl2-dev \
    software-properties-common \
    wget \
    zlib1g-dev \
    cmake \
&&  rm -rf /var/lib/apt/lists/* \
&&  apt-get clean

RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && \
    apt-get install -y \
    gcc-snapshot \
    gcc-4.8 \
    gcc-6 \
    g++-4.8 \
    g++-6 \
&&  rm -rf /var/lib/apt/lists/* \
&&  apt-get clean

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8
RUN update-alternatives --config gcc

RUN apt-get update \
&&  apt-get install -y \
    apt-transport-https \
&&  rm -rf /var/lib/apt/lists/* \
&&  apt-get clean

# install wine
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key \
&&  apt-key add winehq.key \
&&  rm winehq.key \
&&  apt-add-repository -y 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' \
&&  apt-get update \
&&  apt-get install -y --install-recommends \
    wine-staging-dev=2.21.0~xenial \
    wine-staging-i386=2.21.0~xenial \
&&  rm -rf /var/lib/apt/lists/* \
&&  apt-get clean

ARG SOURCE_PACKAGE_URL_PREFIX=https://github.com/KoKuToru/koku-xinput-wine/archive/
ARG SOURCE_PACKAGE=v1.2.2.tar.gz

# Download koku-xinput-wine source
RUN wget ${SOURCE_PACKAGE_URL_PREFIX}/${SOURCE_PACKAGE} \
&&  tar -xf ${SOURCE_PACKAGE} \
&&  rm ${SOURCE_PACKAGE}

RUN cd koku-xinput-wine-1.2.2 \
&&  cmake . \
&&  bash -c 'make -j$(grep -i proc /proc/cpuinfo | wc -l)' \
&&  mv koku-xinput-wine.so .. \
&&  cd .. \
&&  strip koku-xinput-wine.so \
&&  rm -rf koku-xinput-wine-1.2.2
