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
    latest = requests.head(
        '{base}/Miniconda2-latest-Linux-x86_64.sh'.format(
            base=base_url
        )
    )
    current = requests.head(
        '{base}/Miniconda2-{version}-Linux-x86_64.sh'.format(
            base=base_url,
            version=conda_version,
        )
    )
    assert current.headers['etag'] == latest.headers['etag']
