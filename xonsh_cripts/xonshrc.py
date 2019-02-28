"""
THIS PYTHON SCRIPT IS MEANT TO BE EXECUTED USING XONSH
XONSH IS A BASH LIKE INTERPRETER WRITED IN PYTHON
INSTALL IT USING
SUDO PIP INSTALL XONSH
THEN CALL IT WITH
XONSH
AND ALL THE FUNCTION IN THIS PYTHON SCRIPT
CAN BE USED JUST LIKE A NORMAL BASH FUNCTION
"""
import socket
import sys

sys.path = ["/root/mromay_bashrc/xonsh_cripts"] + sys.path

from local import *

def _domain_ip(args):
    return socket.gethostbyname(args[0])

aliases['domain_ip'] = _newline(_domain_ip)
