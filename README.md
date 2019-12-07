# SICOPOLIS_docker

A docker based environment for the Ice sheet model SICOPOLIS http://www.sicopolis.net.
For more details please see http://www.sicopolis.net/index.html#docu

This is the docker file for the image  `tgoelles/sicopolis_dev` on docker hub.

It comes with gfortran, netCDF, lis and GMT.

This is currently an unofficial beta version, and has only partly been tested. Its the first step towards reproducible science.
For issues and suggestions, please use the issue tracker on github.


## Getting Started

Install docker: https://www.docker.com/products/docker-desktop for Mac and Windows, and https://docs.docker.com/install/ for Linux.

Make a new folder.

Then checkout the current version of SICOPOLIS (or use your own existing code)

```
svn checkout --username anonsvn --password anonsvn \
    https://swrepo1.awi.de/svn/sicopolis/trunk sicopolis

```

Start docker in the terminal, which starts an interactive bash shell to compile and run SICOPOLIS as usual.
```
docker run -v $PWD/sicopolis:/home/glacier/sicopolis -it tgoelles/sicopolis_dev
```

This mounts the folder sicopolis to /home/glacier/sicopolis inside the container. The container is based on ubuntu 18.04 and has a user called "glacier".


Before the first run execute in the sicopolis folder (or skip this step when using and existing code):

```
./copy_templates.sh
```

Then replace the sico_configs.sh in runs/sico_configs.sh the one in the image. Run this inside the container:

```
cd sicopolis/runs
cp ~/sico_configs.sh .
```

This is only necessary the first time.

The next time you want to develop sicopolis insde the folder simply run 
```
docker run -v $PWD/sicopolis:/home/glacier/sicopolis -it tgoelles/sicopolis_dev
```

