=============================
Read the Docs - Docker Images
=============================

These are the Docker image definitions used by the Read the Docs build
environments to encapsulate the build process. Our supported image used for
basic builds on our community site is ``base``.

Installing
----------

To use these images, simply load them into your Docker instance::

    make

Or install manually::

    docker build -t rtfd-build:base base/
    docker build -t rtfd-build:advanced advanced/

Upgrading
---------

This is more of a manual process for now. First, build the image without tagging
it::

    docker build base/
    docker build advanced/

Next, find the images hashes and force tag them::

    docker tag -f <HASH> rtfd-build:base
    docker tag -f <HASH> rtfd-biuld:advanced
