How to Contribute
=================

These are the build container images that Read the Docs will use to build your
documentation. They include all of the dependencies we require, and are a method
of isolating the build processes from the rest of our infrastructure.

If you are interested in contributing to the development of our build container
images, you can help in one of two ways:

If you would like to fix a bug or add a feature to our build images, see
`Testing Locally`_ for more information on how to build and test these images.

We can also use your help in beta testing the pre-built images on Read the Docs.
If you'd like to sign up for beta testing our latest build image with your
projects, you can fill out this form:

https://goo.gl/forms/3oAbxkGMUiEZz2782

We'll need to verify that you are the account holder, and that you made the
request for the projects that you listed.

Testing Locally
---------------

If you'd like to add a feature to any of the images, you'll need to verify the
image works locally first. After making changes to the ``Dockerfile``, you can
build your image with::

    docker build -t readthedocs/build:latest .

This will take quite a long time, mostly due to LaTeX dependencies. The
resulting image will be around 8GB.

Once your image is built, you can test your image locally by running a shell in
a container using your new image::

    docker run --rm -t -i readthedocs/build:latest /bin/bash

This will put you into the root path in the container, as the ``docs`` user.
From here you can head to your home path (``cd ~docs``) and run normal
Python/Sphinx/etc operations to see if your changes have worked. For example::

    cd ~docs
    git clone https://github.com/readthedocs/template
    cd template
    make html

Releases
--------

These images are all built from our `automated Docker Hub repository`_. The
automated build rules include pattern matching on Git tags. Here is how the
images are currently tagged:

build:latest
    From the ``master`` branch.

build:2.0
    From any tag matching ``2.0[0-9.]*``. These tags should only represent
    commits to the ``releases/2.x`` branch.

build:1.0
    From the ``1.0`` tag. These tags should only represent commits to the
    ``releases/1.x`` branch.

We follow `semantic versioning`_, but drop the bug fix level version number for
our images, as this level of granularity is not important for any application of
these images. Each release is tagged in Git, and the release version number is
included in the Dockerfile version label (``LABEL version="2.0"``).

For our ``latest`` version, you do not need to update the version label in the
Dockerfile, and you do not need to tag the commit. This will be handled when the
latest image becomes a release.

Releases should be merged into one of the ``releases/`` branches, for instance
``releases/2.x``. The version label in the Dockerfile should be updated to the
next version in the series, following semver rules. This commit should then also
be tagged using the new version number.

If the version number in the Dockerfile was ``2.0.1`` before, and you implement
a bug fix to the image, the new image will be ``2.0.2``. The output image from
Docker Hub will still be ``2.0`` however. If a new feature is introduced, the
new version tagged and in the Dockerfile will be ``2.1``.

We don't care about bug fix version numbers here, as RTD will only ever have one
main ``2.x`` image at a time. There is no need for us to run multiple bug fix
versions at the same time.

.. _automated Docker Hub repository: https://hub.docker.com/r/readthedocs/build/
.. _sematic versioning: http://semver.org
