This is a collection (sparse so far) of Dockerfiles for building a containerized
deep learning software.

## Notes to self...

Example of how to update...

    $ . start-docker-osx.sh
    // see what we got
    $ docker images
    // get rid of old "latest" and tagged stuff
    // use correct hash from `docker images`
    $ docker rmi -f 0df6c
    // build with a tag (Dockerfile is local)
    // use tensorflow version to version this container
    $ docker build -t gnperdue/tfdevel:1.1.0 py2cg
    ...
    // see what we got
    $ docker images
    $ docker push gnperdue/tfdevel:1.1.0
    $ docker build -t gnperdue/tfdevel:latest py2cg
    $ docker push gnperdue/tfdevel:latest


$ docker run -ti --volume=$(pwd):/workspace gnperdue/tfdevel:1.1.0 /bin/bash
$ docker run -ti --volume=$(pwd):/workspace gnperdue/tfdevel:1.1.0 ipython
$ docker run -ti --volume=$(pwd):/workspace gnperdue/tfdevel:1.1.0 \
  python pyverchecker.py
CaloGAN$ docker run -ti --volume=$(pwd):/workspace gnperdue/tfdevel:1.1.0 \
  python -m models.train -h
CaloGAN$ docker run -ti --volume=$(pwd):/workspace gnperdue/tfdevel:1.1.0 \
  python -m models.train --nb-epochs 1  models/particles.yaml

Where is it getting the Keras config? -> Must be looking locally (somehow) -
no config file in the container. Or it is just using default values.
