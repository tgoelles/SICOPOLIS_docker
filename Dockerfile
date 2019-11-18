FROM ubuntu:18.04 

# Set the working directory to /home
WORKDIR /home

############## Envirinment flags ############## 
ENV DEBIAN_FRONTEND noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV LIS_PATH=/opt/lis
ENV NETCDF_PATH=/usr
ENV FC=gfortran

############## Get libs  ############## 
RUN apt-get -y update && \ 
    apt-get install -y subversion gcc g++ gfortran libnetcdf-dev libnetcdff-dev less && \ 
    apt-get install -y gmt gmt-dcw gmt-gshhg automake make wget zip unzip sudo && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 



# install lis
WORKDIR /tmp/
RUN wget https://www.ssisc.org/lis/dl/lis-2.0.20.zip
RUN unzip lis-2.0.20.zip
WORKDIR /tmp/lis-2.0.20
RUN ./configure --prefix=/opt/lis
RUN make
RUN make check
RUN rm -r /tmp/lis-2.0.20
# Configure sicopolis the first time
# automate the whole setup


# Add user
ENV USER=glacier
RUN adduser --disabled-password --gecos '' ${USER} \
    && adduser ${USER} sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${USER}
ENV HOME=/home/${USER}



# configure sicopolis
RUN ${HOME}/sicopolis/copy_templates.sh
WORKDIR ${HOME}/sicopolis/runs
RUN sed -i 's/LIS_FLAG=.*/LIS_FLAG=\"true\"/g' sico_configs.sh
RUN sed -i 's/NETCDF_FLAG=.*/NETCDF_FLAG=\"true\"/g' sico_configs.sh
RUN sed -i 's/OPENMP_FLAG=.*/OPENMP_FLAG=\"true\"/g' sico_configs.sh
RUN sed -i 's/LARGE_DATA_FLAG=.*/LARGE_DATA_FLAG=\"true\"/g' sico_configs.sh


WORKDIR ${HOME}/sicopolis/
ENTRYPOINT [ "bash" ]
