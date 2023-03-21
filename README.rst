=============================
Read the Docs - Docker Images
=============================

These are the Docker image definitions used by the Read the Docs build
environments to encapsulate the build process.

You can find these images on Docker Hub, on the `readthedocs/build`_
repository:

`readthedocs/build:ubuntu-20.04-YYYY.MM.DD`
    Ubuntu 20.04 supporting multiple versions of Python, PyPy, conda, mamba, nodejs, rust and go.
    Available for public usage as ``build.os: ubuntu-20.04``

`readthedocs/build:ubuntu-22.04-YYYY.MM.DD`
    Ubuntu 22.04 supporting multiple versions of Python, PyPy, conda, mamba, nodejs, rust and go.
    Available for public usage as ``build.os: ubuntu-22.04``

Note that these images only contains the basic dependencies:

- ``asdf`` CLI manager to install the languages versions
- LaTeX packages to build PDFs
- Chinese fonts

.. _readthedocs/build: https://hub.docker.com/r/readthedocs/build/

Usage
-----

.. note::

   These images are only for internal usage on Read the Docs project.
   They are not meant to build your documentation locally,
   to replace Read the Docs' service or to emulate it locally.

To use the pre-built images, you can pull from Docker Hub:

    docker pull readthedocs/build:ubuntu-22.04-YYYY.MM.DD

.. note::

   Docker has changed how the iamges are build and now ``buildx`` is required.
   Read how to install it in your system at https://docs.docker.com/build/install-buildx/

You can also compile these images locally:

    docker build -t readthedocs/build:ubuntu-22.04-YYYY.MM.DD .

See `CONTRIBUTING`_ for more information on building and testing.

.. _CONTRIBUTING: CONTRIBUTING.rst
