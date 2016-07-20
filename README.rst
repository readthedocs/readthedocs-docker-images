=============================
Read the Docs - Docker Images
=============================

These are the Docker image definitions used by the Read the Docs build
environments to encapsulate the build process. Our supported image used for
basic builds on our community site is ``readthedocs/build:14.04``.

You can find these images on Docker Hub, on the `readthedocs/build`_ repository.

.. _readthedocs/build: https://hub.docker.com/r/readthedocs/build/

Installing
----------

To use these images, simply load them into your Docker instance::

    make

Or install manually::

    docker build -t readthedocs/build:14.04 14.04/
    docker build -t readthedocs/build:14.04-advanced 14.04-advanced/
    docker build -t readthedocs/build:16.04 16.04/

Push to Docker Hub
------------------

To push to Docker Hub::

    make push
