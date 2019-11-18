A docker based environment for the Ice sheet model SICOPOLIS http://www.sicopolis.net.
For more details see http://www.sicopolis.net/index.html#docu

It comes with gfortran, netCDF, lis and GMT.

This is currently an unofficial beta version, and has only partly been tested. For issues and suggestions, please use the issue tracker on github.


## Getting startet

Install docker: https://www.docker.com/products/docker-desktop for Mac and Windows, and https://docs.docker.com/install/ for Linux.

Make a new folder.

Then checkout the current version of SICOPOLIS (of use your own existing code)

```
svn checkout --username anonsvn --password anonsvn \
    https://swrepo1.awi.de/svn/sicopolis/trunk sicopolis

```

Before the first run execute in the sicopolis folder

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



