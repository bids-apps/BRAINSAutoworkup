FROM ubuntu:16.04

# Run apt-get calls
RUN apt-get update \
 && apt-get install -y wget \
 && wget -O- http://neuro.debian.net/lists/xenial.us-tn.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
 && apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9

# Make a standard filesystem layout
RUN mkdir -p /code \
 && mkdir /oasis \
 && mkdir /projects \
 && mkdir /scratch \
 && mkdir /local-scratch

RUN apt-get install -y build-essential \
 && apt-get install -y cmake \
 && apt-get install -y cmake-curses-gui \
 && apt-get install -y git \
 
RUN apt-get install -y libtbb-dev

RUN apt-get install -y python \
 && apt-get install -y python-pip \
 && pip install nibabel \
 && pip install nipype[all]


#-- COPY run.py /code/run.py
#-- ENTRYPOINT ["/code/run.py"]
