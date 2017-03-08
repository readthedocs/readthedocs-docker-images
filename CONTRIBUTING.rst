How to Contribute
=================

We can use contributions to the images here, but can also use your help in
testing the images. If you'd like to sign up for beta testing the ``latest``
image, sign up here:

https://goo.gl/forms/3oAbxkGMUiEZz2782

We'll need to verify that you are the account holder, and that you made the
request for the projects that you listed.

Testing
-------

You can test your image by running a shell in a container::

    docker run --rm -t -i readthedocs/build:latest /bin/bash

This will put you into the root path in the container, as the ``docs`` user.
From here you can head to your home path (``cd ~docs``) and run normal
Python/Sphinx/etc operations to see if your changes have worked.

Releases
--------

Theses images are all built from our `automated Docker Hub repository`_. Here is
how the images are currently built:

build:1.0
    From the ``1.0`` tag. These tags should only represent commits to the
    ``releases/1.x`` branch.

build:2.0
    From any tag matching ``2.0[0-9.]*``. These tags should only represent
    commits to the ``releases/2.x`` branch.

build:2.1
    From any tag matching ``2.1[0-9.]*`` These tags should only represent
    commits to the ``releases/2.x`` branch.

build:latest
    From the ``master`` branch.

We follow `semantic versioning`_, but drop the bug fix level version number for
our images, as this level of granularity is not important for any application of
these images. New releases should be merged into one of the ``releases/``
branches, for instance ``releases/2.x``. This commit should then be tagged using
the new version number.

If the version number in the Dockerfile was ``2.0.1`` before, and you implement
a bug fix to the image, the new image will be ``2.0.2``. The output image from
Docker Hub will still be ``2.0`` however. If a new feature is introduced, the
new version tagged and in the Dockerfile will be ``2.1``.

We don't care about bug fix version numbers here, as RTD will only ever have one
main ``2.x`` image at a time. There is no need for us to run multiple bug fix
versions at the same time.

.. _automated Docker Hub repository: https://hub.docker.com/r/readthedocs/build/
.. _sematic versioning: http://semver.org
