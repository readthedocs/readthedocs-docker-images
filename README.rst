=============================
Read the Docs - Docker Images
=============================

These are the Docker image definitions used by the Read the Docs build
environments to encapsulate the build process.

You can find these images on Docker Hub, on the `readthedocs/build`_ repository.

.. _readthedocs/build: https://hub.docker.com/r/readthedocs/build/

Usage
-----

To use these images, you can pull from Docker Hub:

    docker pull readthedocs/build:latest

You can also compile these images manually:

    docker build -t readthedocs/build:latest .

Push to Docker Hub
------------------

To push to Docker Hub::

    docker push readthedocs/build:latest
