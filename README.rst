=============================
Read the Docs - Docker Images
=============================

These are the Docker image definitions used by the Read the Docs build
environments to encapsulate the build process. Our supported image used for
basic builds on our community site is ``base``.

Usage
-----

To use these images for development, simply load them into your Docker
instance::

    docker build -t rtfd-build:latest base/
