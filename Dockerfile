FROM debian:latest

LABEL maintainer="thomas.goelles@gmail.com"

# Set the working directory to /home
WORKDIR /home

# languages
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8


ENV USER=glacier

# versions
ENV TEPANADE_VERSION=3.16
ENV LIS_VERSION=2.1.1
ENV FPM_VERSION=0.8.1

# flags
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV LISDIR=/opt/lis
ENV NETCDF_PATH=/usr
ENV FC=gfortran
ENV TAPENADE_HOME="/home/$USER/tapenade_$TEPANADE_VERSION"
ENV PATH="$PATH:$TAPENADE_HOME/bin"
ENV JAVA_HOME=/usr/java/default

#get libs
RUN apt-get -y update && \
    apt-get install -y \
    git \
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
    curl \
    zip \
    unzip \
    tar \
    openjdk-11-jre \
    sudo && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install fpm
RUN wget -O fpm https://github.com/fortran-lang/fpm/releases/download/v${FPM_VERSION}/fpm-${FPM_VERSION}-linux-x86_64 && \
    mv fpm /usr/bin && \
    chmod u+x /usr/bin/fpm

# install lis
RUN echo "installing lis" &&\
    cd /tmp/ &&\
    wget https://www.ssisc.org/lis/dl/lis-${LIS_VERSION}.zip &&\
    unzip lis-${LIS_VERSION}.zip &&\
    cd /tmp/lis-${LIS_VERSION} &&\
    echo $PWD &&\
    echo "configure and make of lis" &&\
    ./configure --prefix=${LISDIR} --libdir=${LISDIR}/lib \
    --enable-fortran --enable-f90 \
    --enable-omp --enable-saamg --enable-fma \
    CC=gcc FC=gfortran F77=gfortran \
    CFLAGS="-mcmodel=medium" CPPFLAGS="-mcmodel=medium" \
    FCFLAGS="-mcmodel=medium" FFLAGS="-mcmodel=medium" &&\
    make &&\
    make check &&\
    make install &&\
    make installcheck &&\
    rm -rf /tmp/lis-${LIS_VERSION}

# install tepanade
RUN echo "installing tepanade" &&\
    cd /tmp/ && \
    wget https://tapenade.gitlabpages.inria.fr/tapenade/distrib/tapenade_${TEPANADE_VERSION}.tar && \
    tar xvfz tapenade${TEPANADE_VERSION}.tar -C $TAPENADE_HOME && \
    rm -r /tmp/tapenade_${TEPANADE_VERSION}.tar

# add user to superuse
RUN adduser --disabled-password --gecos '' ${USER} \
    && adduser ${USER} sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${USER}
ENV HOME=/home/${USER}


WORKDIR /home/glacier/sicopolis
ENTRYPOINT [ "bash" ]
