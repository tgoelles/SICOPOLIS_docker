# SICOPOLIS_docker

A docker based environment for the Ice sheet model SICOPOLIS http://www.sicopolis.net.
For more details please see http://www.sicopolis.net/index.html#docu

The docker image is also on docker hub: `tgoelles/sicopolis_dev`

It comes with gfortran, netCDF, lis and GMT.

This is currently an unofficial beta version, and has only partly been tested. Its the first step towards reproducible science.
For issues and suggestions, please use the issue tracker on github.


## Getting Started

Install docker: https://www.docker.com/products/docker-desktop for Mac and Windows, and https://docs.docker.com/install/ for Linux.

Make a new folder.

Then checkout the current version of SICOPOLIS (of use your own existing code)

```
svn checkout --username anonsvn --password anonsvn \
    https://swrepo1.awi.de/svn/sicopolis/trunk sicopolis

```

Before the first run execute in the sicopolis folder:

```
./copy_templates.sh
```

Then replace the sico_configs.sh in runs/sico_configs.sh with the one in this repository.


```
cp sico_configs.sh sicopolis/runs/
```

Start docker in the terminal, which starts and interactive bash shell to compile and run SICOPOLIS as usual.
```
docker run -v $PWD/sicopolis:/home/glacier/sicopolis -it tgoelles/sicopolis_dev
```

This mounts the the folder sicopolis to /home/glacier/sicopolis inside the container. The container is based on ubuntu 18.04 and has a user called glacier.




