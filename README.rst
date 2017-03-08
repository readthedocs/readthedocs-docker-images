=============================
Read the Docs - Docker Images
=============================

These are the Docker image definitions used by the Read the Docs build
environments to encapsulate the build process.

You can find these images on Docker Hub, on the `readthedocs/build`_
repositoryr:

* `readthedocs/build:1.0` - Ubuntu 14.04 based image
* `readthedocs/build:1.0-dotnet` - Ubuntu 14.04 based image, plus .NET
* `readthedocs/build:2.0` - Ubuntu 16.04 based image
* `readthedocs/build:latest` - Latest development image

.. _readthedocs/build: https://hub.docker.com/r/readthedocs/build/

Usage
-----

To use prebuilt images, you can pull from Docker Hub:

    docker pull readthedocs/build:latest

You can also compile these images locally:

    docker build -t readthedocs/build:latest .

See `CONTRIBUTING`_ for more information on building and testing.

.. _CONTRIBUTING: CONTRIBUTING.rst
