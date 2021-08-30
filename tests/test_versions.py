import pytest
from docker import APIClient

from .utils import run_command_in_container


@pytest.mark.parametrize(
    'command,expected_output',
    [
        ('asdf version', 'v0.8.1-a1ef92a'),
        ('asdf plugin list', '\n'.join(['golang', 'nodejs', 'python', 'rust']),
        ('git --version', 'git version 2.25.1'),
    ]
)
def test_command_versions_image_master(command, expected_output):
    cmd_output = run_command_in_container('readthedocs/build:master', command)
    assert cmd_output == expected_output
