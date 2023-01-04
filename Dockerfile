FROM ubuntu:16.04

ARG DEBIAN_FRONTEND="noninteractive"

# Run apt-get calls
RUN apt-get update -qq \
 && apt-get install -qq -y --no-install-recommends \
    wget \
 && wget --progress=dot:giga -O- http://neuro.debian.net/lists/xenial.us-tn.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
 && apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9

# Make a standard filesystem layout
RUN mkdir -p /code \
 && mkdir /oasis \
 && mkdir /projects \
 && mkdir /scratch \
 && mkdir /local-scratch

RUN apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends \
                build-essential \
                cmake \
                cmake-curses-gui \
                apt-utils \
                git

RUN apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends \
        libtbb-dev tbb-examples libtbb-doc libtbb2 && \
    unset DEBIAN_FRONTEND

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-4.1.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

# Install packages needed for VTK & ITK
RUN apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends \
    libglu1-mesa-dev freeglut3-dev mesa-common-dev
