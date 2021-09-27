How to Contribute
=================

These are the build container images that Read the Docs will use to build your
documentation. They include all of the dependencies we require, and are a method
of isolating the build processes from the rest of our infrastructure.

If you are interested in contributing to the development of our build container
images, you can help in one of two ways:

If you would like to fix a bug or add a feature to our build images, see
`Testing Locally`_ for more information on how to build and test these images.

Testing Locally
---------------

If you'd like to add a feature to any of the images, you'll need to verify the
image works locally first. After making changes to the ``Dockerfile``, you can
build your image with::

    docker build -t readthedocs/build:ubuntu-20.04 .

This will take quite a long time, mostly due to LaTeX dependencies. The
resulting image will be around 5GB.

Once your image is built, you can test your image locally by running a shell in
a container using your new image::

    docker run --rm -t -i readthedocs/build:ubuntu-20.04 /bin/bash

This will put you into the root path in the container, as the ``docs`` user.
From here you can head to your home path (``cd ~docs``) and run normal
Python/Sphinx/etc operations to see if your changes have worked. For example::

    cd ~docs
    git clone https://github.com/readthedocs/template
    cd template/docs
    make html

Releases
--------

These images are all built from our `automated Docker Hub repository`_. The
automated build rules include pattern matching on Git tags. The current tags
are defined in the :doc:`README`.

We follow `calendar versioning`_ together with the Ubuntu LTS version for that particular image.
For example, if the Ubuntu version is 20.04 and it is released today,
it will be ``ubuntu-20.04-2020.08.30`` (YYYY.MM.DD).

Releases should be merged into one of the ``releases/`` branches, for instance
``releases/ubuntu-20.04-2020.08.30``. This commit should then also be tagged using the new version number.

.. _automated Docker Hub repository: https://hub.docker.com/r/readthedocs/build/
.. _calendar versioning: https://calver.org/
