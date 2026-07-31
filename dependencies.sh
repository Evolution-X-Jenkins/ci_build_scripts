#!/bin/bash

# Basic Packages
apt install -y \
    bc \
    bison \
    build-essential \
    ccache \
    curl \
    flex \
    g++-multilib \
    gcc-multilib \
    git \
    git-lfs \
    gnupg \
    gperf \
    imagemagick \
    protobuf-compiler \
    python3-protobuf \
    lib32readline-dev \
    lib32z1-dev \
    libdw-dev \
    libelf-dev \
    libgnutls28-dev \
    lz4 \
    libsdl1.2-dev \
    libssl-dev \
    libxml2 \
    libxml2-utils \
    lzop \
    pngcrush \
    rsync \
    schedtool \
    squashfs-tools \
    xsltproc \
    xxd \
    zip \
    zlib1g-dev

# Install additional packages for Ubuntu 23.10 and later
UBUNTU_VERSION="$(lsb_release -rs)"
echo "Detected Ubuntu version: $UBUNTU_VERSION"

if dpkg --compare-versions "$UBUNTU_VERSION" ge "23.10"; then
    # Install libtinfo5 for Ubuntu 23.10 and later
    wget https://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.3-2_amd64.deb && sudo dpkg -i libtinfo5_6.3-2_amd64.deb && rm -f libtinfo5_6.3-2_amd64.deb
    # Install libncurses5 for Ubuntu 23.10 and later
    wget https://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libncurses5_6.3-2_amd64.deb && sudo dpkg -i libncurses5_6.3-2_amd64.deb && rm -f libncurses5_6.3-2_amd64.deb
else
    # Install libtinfo5 for Ubuntu versions earlier than 23.10
    apt install -y libtinfo5
    # Install libncurses5 for Ubuntu versions earlier than 23.10
    apt install -y libncurses5
fi