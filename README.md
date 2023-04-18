# SICOPOLIS_docker

A docker based environment for the Ice sheet model SICOPOLIS http://www.sicopolis.net.
For more details please see http://www.sicopolis.net/index.html#docu


It comes with gfortran, netCDF, lis and GMT and tapenade.

This is currently an unofficial beta version, and has only partly been tested. Its the first step towards reproducible science.
For issues and suggestions, please use the issue tracker on github.


## Getting Started

Install docker: https://www.docker.com/products/docker-desktop for Mac and Windows, and https://docs.docker.com/install/ for Linux.

Make a new folder.

Then checkout the current version of SICOPOLIS (or use your own existing code)

```
git clone --branch develop
    https://gitlab.awi.de/sicopolis/sicopolis.git

```

Start docker in the terminal inside the sicopolis folder. This starts an interactive bash shell to compile and run SICOPOLIS as usual. The local repository is mounted as volume, which means that you can use your favorite editor as usual.

```
docker run -v $PWD:/home/glacier/sicopolis -it ghcr.io/tgoelles/sicopolis_base:latest
```

