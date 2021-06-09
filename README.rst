=============================
Read the Docs - Docker Images
=============================

These are the Docker image definitions used by the Read the Docs build
environments to encapsulate the build process.

You can find these images on Docker Hub, on the `readthedocs/build`_
repository:

`readthedocs/build:1.0`
    **Deprecated**
    Ubuntu 14.04 based image.

`readthedocs/build:1.0-dotnet`
    **Deprecated**
    Ubuntu 14.04 based image, plus .NET.

`readthedocs/build:2.0`
    **Deprecated**
    Ubuntu 16.04 based image.

`readthedocs/build:4.0`
    **Deprecated**
    Ubuntu 18.04 supporting Python 2.7, 3.5, 3.6, 3.7.

`readthedocs/build:5.0`
    ``stable``
    Ubuntu 18.04 supporting Python 2.7, 3.6, 3.7 and pypy3.5-7.0.0.
    This is the **stable** image supported by Read the Docs.

`readthedocs/build:6.0`
    ``latest``
    Ubuntu 18.04 supporting Python 2.7, 3.5, 3.6, 3.7, 3.8 and PyPy3.5-7.0.0.
    This is the **latest** default image used for documentation builds and supported by Read the Docs.

`readthedocs/build:7.0`
    ``testing``
    Ubuntu 18.04 supporting Python 2.7, 3.5, 3.6, 3.7, 3.8, 3.9, and PyPy3.5-7.0.0.
    Available for public usage as **testing** image. You should expect some breaking changes here.

.. _readthedocs/build: https://hub.docker.com/r/readthedocs/build/

.. warning::

   We are transitioning to a new way of building our Docker images, see
   `the relevant design document <https://docs.readthedocs.io/en/stable/development/design/build-images.html>`_
   for more information.
   As a result, we will not update the current images
   and will focus on implementing the new ones instead.

Usage
-----

To use the pre-built images, you can pull from Docker Hub:

    docker pull readthedocs/build:latest

You can also compile these images locally:

    docker build -t readthedocs/build:testing .

See `CONTRIBUTING`_ for more information on building and testing.

.. _CONTRIBUTING: CONTRIBUTING.rst
