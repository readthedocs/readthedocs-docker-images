import pytest
from docker import APIClient


@pytest.mark.parametrize(
    'container_image,command,expected_output',
    [
        # TODO: add other Docker images as well
        # python
        ('readthedocs/build:6.0', 'python2 --version', 'Python 2.7.16'),
        ('readthedocs/build:6.0', 'python3.5 --version', 'Python 3.5.7'),
        ('readthedocs/build:6.0', 'python3.6 --version', 'Python 3.6.8'),
        ('readthedocs/build:6.0', 'python3.7 --version', 'Python 3.7.3'),
        ('readthedocs/build:6.0', 'python3.8 --version', 'Python 3.8.0'),
        # pip
        ('readthedocs/build:6.0', 'python3.5 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.5.7/lib/python3.5/site-packages/pip (python 3.5)"),
        ('readthedocs/build:6.0', 'python3.6 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.6.8/lib/python3.6/site-packages/pip (python 3.6)"),
        ('readthedocs/build:6.0', 'python3.7 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.7.3/lib/python3.7/site-packages/pip (python 3.7)"),
        ('readthedocs/build:6.0', 'python3.8 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.8.0/lib/python3.8/site-packages/pip (python 3.8)"),
        # virtualenv
        ('readthedocs/build:6.0', 'virtualenv --version', '16.7.9'),
        # others
        ('readthedocs/build:6.0', 'node --version', 'v8.10.0'),
        ('readthedocs/build:6.0', 'npm --version', '3.5.2'),
        ('readthedocs/build:6.0', 'conda --version', 'conda 4.6.14'),
    ]
)
def test_python_versions(container_image, command, expected_output):
    client = APIClient()

    # Create the container
    container = client.create_container(
        image=container_image,
        command=(
            '/bin/sh -c "sleep {time}; exit {exit}"'.format(
                time=60,
                exit=42,
            )
        ),
        detach=True,
        user='docs',
    )

    # Start the container
    container_id = container.get('Id')
    client.start(container=container_id)

    # Execute commands to verify versions
    exec_cmd = client.exec_create(
        container=container_id,
        cmd=f"/bin/sh -c '{command}'",
        stdout=True,
        stderr=True,
    )
    cmd_output = client.exec_start(exec_id=exec_cmd['Id'], stream=False)
    cmd_output = cmd_output.decode('utf-8', 'replace').strip()
    client.kill(container_id)

    assert cmd_output == expected_output
