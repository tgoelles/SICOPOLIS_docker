FROM ubuntu:18.04 

LABEL com.example.version="0.0.1-beta"
LABEL maintainer="thomas.goelles@gmail.com"

# Set the working directory to /home
WORKDIR /home

#Envirinment flags 
ENV DEBIAN_FRONTEND noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV LIS_PATH=/usr/lib/lis
ENV LIS_VERSION=2.0.20
ENV NETCDF_PATH=/usr
ENV FC=gfortran

#get libs  
RUN apt-get -y update && \ 
    apt-get install -y \
    subversion \
    gcc \
    gfortran \ 
    libnetcdf-dev \  
    libnetcdff-dev \
    less \ 
    gmt \
    gmt-dcw \ 
    gmt-gshhg \
    automake \
    make \
    wget \ 
    zip \
    unzip \ 
    sudo && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# install lis
WORKDIR /tmp/
RUN echo "installing lis"
RUN wget https://www.ssisc.org/lis/dl/lis-${LIS_VERSION}.zip
RUN unzip lis-${LIS_VERSION}.zip
WORKDIR /tmp/lis-${LIS_VERSION}
RUN echo $PWD
RUN echo "configure and make of lis"
RUN ./configure --prefix=${LIS_PATH} --enable-omp --enable-f90
RUN make 
RUN make check
RUN make install
RUN make installcheck
RUN rm -rf /tmp/lis-${LIS_VERSION}


# Add user
ENV USER=glacier
RUN adduser --disabled-password --gecos '' ${USER} \
    && adduser ${USER} sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${USER}
ENV HOME=/home/${USER}


WORKDIR ${HOME}/sicopolis/
ENTRYPOINT [ "bash" ]
