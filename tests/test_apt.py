import pytest

from .constants import DOCKER_IMAGE
from .utils import run_command_in_container


def test_apt_dont_remove_packages():
    command ='grep "Remove:" /var/log/apt/history.log'
    expected_output = ''

    cmd_output = run_command_in_container(DOCKER_IMAGE, command)
    assert cmd_output == expected_output
