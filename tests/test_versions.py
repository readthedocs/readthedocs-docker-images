import pytest
from docker import APIClient

from .utils import run_command_in_container


@pytest.mark.image_master
@pytest.mark.parametrize(
    'command,expected_output',
    [
        # python
        ('python2 --version', 'Python 2.7.18'),
        ('python3.5 --version', 'Python 3.5.10'),
        ('python3.6 --version', 'Python 3.6.12'),
        ('python3.7 --version', 'Python 3.7.9'),
        ('python3.8 --version', 'Python 3.8.6'),
        ('pypy3.5 --version', 'Python 3.5.3 (928a4f70d3de7d17449456946154c5da6e600162, Feb 09 2019, 11:50:43)\n[PyPy 7.0.0 with GCC 8.2.0]'),
        # pip
        ('python2 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/2.7.18/lib/python3.5/site-packages/pip (python 3.5)"),
        ('python3.5 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.5.10/lib/python3.5/site-packages/pip (python 3.5)"),
        ('python3.6 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.6.12/lib/python3.6/site-packages/pip (python 3.6)"),
        ('python3.7 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.7.9/lib/python3.7/site-packages/pip (python 3.7)"),
        ('python3.8 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.8.6/lib/python3.8/site-packages/pip (python 3.8)"),
        # setuptools
        ('python2 -c "import setuptools; print(setuptools.__version__)"', "44.0.0"),
        ('python3.5 -c "import setuptools; print(setuptools.__version__)"', "45.1.0"),
        ('python3.6 -c "import setuptools; print(setuptools.__version__)"', "45.1.0"),
        ('python3.7 -c "import setuptools; print(setuptools.__version__)"', "45.1.0"),
        ('python3.8 -c "import setuptools; print(setuptools.__version__)"', "45.1.0"),
        # virtualenv
        ('python2 -m virtualenv --version', 'virtualenv 16.7.9 from /home/docs/.pyenv/versions/3.7.16/lib/python2.7/site-packages/virtualenv/__init__.pyc'),
        ('python3.5 -m virtualenv --version', 'virtualenv 16.7.9 from /home/docs/.pyenv/versions/3.5.10/lib/python3.5/site-packages/virtualenv/__init__.pyc'),
        ('python3.6 -m virtualenv --version', 'virtualenv 16.7.9 from /home/docs/.pyenv/versions/3.6.12/lib/python3.6/site-packages/virtualenv/__init__.pyc'),
        ('python3.7 -m virtualenv --version', 'virtualenv 16.7.9 from /home/docs/.pyenv/versions/3.7.9/lib/python3.7/site-packages/virtualenv/__init__.pyc'),
        ('python3.8 -m virtualenv --version', 'virtualenv 16.7.9 from /home/docs/.pyenv/versions/3.8.6/lib/python3.8/site-packages/virtualenv/__init__.pyc'),
        # others
        ('node --version', 'v10.19.0'),
        ('npm --version', '6.14.4'),
        ('conda --version', 'conda 4.6.14'),
        ('cargo --version', 'cargo 1.46.0 (149022b1d 2020-07-17)'),
        ('git --version', 'git version 2.25.1'),
    ]
)
def test_command_versions_image_master(command, expected_output):
    cmd_output = run_command_in_container('readthedocs/build:7.0', command)
    assert cmd_output == expected_output


@pytest.mark.image_70
@pytest.mark.parametrize(
    'command,expected_output',
    [
        # python
        ('python2 --version', 'Python 2.7.18'),
        ('python3.5 --version', 'Python 3.5.10'),
        ('python3.6 --version', 'Python 3.6.12'),
        ('python3.7 --version', 'Python 3.7.9'),
        ('python3.8 --version', 'Python 3.8.6'),
        ('pypy3.5 --version', 'Python 3.5.3 (928a4f70d3de7d17449456946154c5da6e600162, Feb 09 2019, 11:50:43)\n[PyPy 7.0.0 with GCC 8.2.0]'),
        # pip
        ('python2 -m pip --version', "pip 20.0.2 from /home/docs/.pyenv/versions/2.7.18/lib/python3.5/site-packages/pip (python 3.5)"),
        ('python3.5 -m pip --version', "pip 20.0.2 from /home/docs/.pyenv/versions/3.5.10/lib/python3.5/site-packages/pip (python 3.5)"),
        ('python3.6 -m pip --version', "pip 20.0.2 from /home/docs/.pyenv/versions/3.6.12/lib/python3.6/site-packages/pip (python 3.6)"),
        ('python3.7 -m pip --version', "pip 20.0.2 from /home/docs/.pyenv/versions/3.7.9/lib/python3.7/site-packages/pip (python 3.7)"),
        ('python3.8 -m pip --version', "pip 20.0.2 from /home/docs/.pyenv/versions/3.8.6/lib/python3.8/site-packages/pip (python 3.8)"),
        # setuptools
        ('python2 -c "import setuptools; print(setuptools.__version__)"', "44.0.0"),
        ('python3.5 -c "import setuptools; print(setuptools.__version__)"', "45.2.0"),
        ('python3.6 -c "import setuptools; print(setuptools.__version__)"', "45.2.0"),
        ('python3.7 -c "import setuptools; print(setuptools.__version__)"', "45.2.0"),
        ('python3.8 -c "import setuptools; print(setuptools.__version__)"', "45.2.0"),
        # virtualenv
        ('python2 -m virtualenv --version', 'virtualenv 20.0.7 from /home/docs/.pyenv/versions/3.7.16/lib/python2.7/site-packages/virtualenv/__init__.pyc'),
        ('python3.5 -m virtualenv --version', 'virtualenv 20.0.7 from /home/docs/.pyenv/versions/3.5.10/lib/python3.5/site-packages/virtualenv/__init__.pyc'),
        ('python3.6 -m virtualenv --version', 'virtualenv 20.0.7 from /home/docs/.pyenv/versions/3.6.12/lib/python3.6/site-packages/virtualenv/__init__.pyc'),
        ('python3.7 -m virtualenv --version', 'virtualenv 20.0.7 from /home/docs/.pyenv/versions/3.7.9/lib/python3.7/site-packages/virtualenv/__init__.pyc'),
        ('python3.8 -m virtualenv --version', 'virtualenv 20.0.7 from /home/docs/.pyenv/versions/3.8.6/lib/python3.8/site-packages/virtualenv/__init__.pyc'),
        # others
        ('node --version', 'v8.10.0'),
        ('npm --version', '3.5.2'),
        ('conda --version', 'conda 4.6.14'),
        ('cargo --version', 'cargo 1.46.0 (149022b1d 2020-07-17)'),
        ('git --version', 'git version 2.17.1'),
    ]
)
def test_command_versions_image_70(command, expected_output):
    cmd_output = run_command_in_container('readthedocs/build:7.0', command)
    assert cmd_output == expected_output


@pytest.mark.image_60
@pytest.mark.parametrize(
    'command,expected_output',
    [
        # python
        ('python2 --version', 'Python 2.7.18'),
        ('python3.5 --version', 'Python 3.5.10'),
        ('python3.6 --version', 'Python 3.6.12'),
        ('python3.7 --version', 'Python 3.7.9'),
        ('python3.8 --version', 'Python 3.8.6'),
        ('pypy3.5 --version', 'Python 3.5.3 (928a4f70d3de7d17449456946154c5da6e600162, Feb 09 2019, 11:50:43)\n[PyPy 7.0.0 with GCC 8.2.0]'),
        # pip
        ('python2 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/2.7.18/lib/python3.5/site-packages/pip (python 3.5)"),
        ('python3.5 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.5.10/lib/python3.5/site-packages/pip (python 3.5)"),
        ('python3.6 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.6.12/lib/python3.6/site-packages/pip (python 3.6)"),
        ('python3.7 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.7.9/lib/python3.7/site-packages/pip (python 3.7)"),
        ('python3.8 -m pip --version', "pip 20.0.1 from /home/docs/.pyenv/versions/3.8.6/lib/python3.8/site-packages/pip (python 3.8)"),
        # setuptools
        ('python2 -c "import setuptools; print(setuptools.__version__)"', "44.0.0"),
        ('python3.5 -c "import setuptools; print(setuptools.__version__)"', "45.1.0"),
        ('python3.6 -c "import setuptools; print(setuptools.__version__)"', "45.1.0"),
        ('python3.7 -c "import setuptools; print(setuptools.__version__)"', "45.1.0"),
        ('python3.8 -c "import setuptools; print(setuptools.__version__)"', "45.1.0"),
        # virtualenv
        ('python2 -m virtualenv --version', '16.7.9'),
        ('python3.5 -m virtualenv --version', '16.7.9'),
        ('python3.6 -m virtualenv --version', '16.7.9'),
        ('python3.7 -m virtualenv --version', '16.7.9'),
        ('python3.8 -m virtualenv --version', '16.7.9'),
        # others
        ('node --version', 'v8.10.0'),
        ('npm --version', '3.5.2'),
        ('conda --version', 'conda 4.6.14'),
        ('git --version', 'git version 2.17.1'),
    ]
)
def test_command_versions_image_60(command, expected_output):
    cmd_output = run_command_in_container('readthedocs/build:6.0', command)
    assert cmd_output == expected_output


@pytest.mark.image_50
@pytest.mark.parametrize(
    'command,expected_output',
    [
        # python
        ('python2 --version', 'Python 2.7.18'),
        ('python3.6 --version', 'Python 3.6.12'),
        ('python3.7 --version', 'Python 3.7.9'),
        ('pypy3.5 --version', 'Python 3.5.3 (928a4f70d3de7d17449456946154c5da6e600162, Feb 09 2019, 11:50:43)\n[PyPy 7.0.0 with GCC 8.2.0]'),
        # pip
        ('python2 -m pip --version', "pip 19.1.1 from /home/docs/.pyenv/versions/2.7.18/lib/python2.7/site-packages/pip (python 2.7)"),
        ('python3.6 -m pip --version', "pip 19.1.1 from /home/docs/.pyenv/versions/3.6.12/lib/python3.6/site-packages/pip (python 3.6)"),
        ('python3.7 -m pip --version', "pip 19.1.1 from /home/docs/.pyenv/versions/3.7.9/lib/python3.7/site-packages/pip (python 3.7)"),
        # setuptools
        ('python2 -c "import setuptools; print(setuptools.__version__)"', "41.0.1"),
        ('python3.6 -c "import setuptools; print(setuptools.__version__)"', "41.0.1"),
        ('python3.7 -c "import setuptools; print(setuptools.__version__)"', "41.0.1"),
        # virtualenv
        ('python2 -m virtualenv --version', '16.6.0'),
        ('python3.6 -m virtualenv --version', '16.6.0'),
        ('python3.7 -m virtualenv --version', '16.6.0'),
        # others
        ('node --version', 'v8.10.0'),
        ('npm --version', '3.5.2'),
        ('conda --version', 'conda 4.6.14'),
        ('git --version', 'git version 2.17.1'),
    ]
)
def test_command_versions_image_50(command, expected_output):
    cmd_output = run_command_in_container('readthedocs/build:5.0', command)
    assert cmd_output == expected_output
