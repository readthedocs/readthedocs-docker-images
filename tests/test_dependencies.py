"""
Check dependencies of our images, fail builds on out of date bits
"""

import requests
from dockerfile_parse import DockerfileParser


def get_dockerfile():
    return DockerfileParser()

def test_miniconda():
    """Test miniconda latest version matches our version"""
    base_url = 'https://repo.continuum.io/miniconda'
    dockerfile = get_dockerfile()
    conda_version = dockerfile.envs.get('CONDA_VERSION')
    conda_python_version = dockerfile.envs.get('CONDA_PYTHON_VERSION')
    latest = requests.head(
        '{base}/Miniconda3-latest-Linux-x86_64.sh'.format(
            base=base_url
        )
    )
    current = requests.head(
        '{base}/Miniconda3-{conda_python_version}_{conda_version}-Linux-x86_64.sh'.format(
            base=base_url,
            conda_python_version=conda_python_version,
            conda_version=conda_version,
        )
    )
    assert current.headers['etag'] == latest.headers['etag']
