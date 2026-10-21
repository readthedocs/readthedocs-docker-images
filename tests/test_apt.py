import pytest

from .constants import DOCKER_IMAGE
from .utils import run_command_in_container


def test_apt_dont_remove_packages():
    command ='grep "Remove:" /var/log/apt/history.log'
    expected_output = ''

    cmd_output = run_command_in_container(DOCKER_IMAGE, command)
    assert cmd_output == expected_output


def test_ca_certificates_distrust_emsign_ecc_root_g3():
    # The emSign ECC Root CA - G3 root signed the eMudhra intermediate CAs whose
    # private keys were compromised in October 2026. Ubuntu removed it in
    # ca-certificates 20260816ubuntu0.22.04.1 (USN-8944-1).
    # NOTE: the command runs inside single quotes, so avoid using them here.
    command = (
        "dpkg --compare-versions "
        "$(dpkg-query -W -f=\\${Version} ca-certificates) "
        "ge 20260816ubuntu0.22.04.1 "
        "&& test ! -e /usr/share/ca-certificates/mozilla/emSign_ECC_Root_CA_-_G3.crt "
        "&& echo ok"
    )
    expected_output = "ok"

    cmd_output = run_command_in_container(DOCKER_IMAGE, command)
    assert cmd_output == expected_output
