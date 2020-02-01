FROM debian:9

ENV LANG C.UTF-8

RUN apt update && apt install -y \
    build-essential \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-net-dev \
    ninja-build

ADD https://github.com/Kitware/CMake/releases/download/v3.16.3/cmake-3.16.3-Linux-x86_64.sh .
RUN sh cmake-3.16.3-Linux-x86_64.sh --skip-license --prefix=/usr/local && rm cmake-3.16.3-Linux-x86_64.sh

VOLUME /tmp/woof-src
VOLUME /tmp/woof-install

CMD mkdir /tmp/woof-build && cd /tmp/woof-build && \
    cmake /tmp/woof-src -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/tmp/woof-install -DWoof_APPIMAGE=On && \
    ninja install && chown -R $UID:$GID /tmp/woof-install
