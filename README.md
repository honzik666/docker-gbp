# Intro

To make a long story short: this is an attempt to provide a Docker image that allows building Debian packages with [git-buildpackage](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.html) (**gbp**) in [pbuilder](https://wiki.debian.org/git-pbuilder) environment.


# Quickstart

- clone this repository and build the image:
```
cd docker-gbp
./docker-build-docker-image.sh
```

- create pbuilder environment inside of the docker image
```
./docker-create-pbuild-env.sh mypkg
```

- execute the build of your package (NOTE: runs docker container in *privileged mode*):

```
cd into-git-build-package-debian-package
docker run --privileged -ti -v$(pwd):/build braiins/gbp /bin/bash -c "git-buildpackage --git-pbuilder --git-dist=jessie --git-arch=amd64 -uc -us"

```

This example builds a package without signing the *source* package and *.changes* file.



# Motivation

One idea that comes to mind is to build the package directly using **debuild** inside of the container (**gbp** natively uses debuild). The problem is that **git-buildpackage** has many dependencies and the build of the package would **NOT** happen in a minimal system. Therefore, it is cleaner to build the package in pbuilder environment.

This all looks very nice and smooth, there is one drawback, though: creating pbuilder environment and executing pbuilder (**gbp**) requires bind mounting /proc /dev/shm and other special filesystems. This is possible **only if** the container runs in privileged mode (see the example above).
