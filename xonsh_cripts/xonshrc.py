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
import os

user = os.getlogin()
xon_dir = "mromay_bashrc/xonsh_cripts"

absolute_path = lambda l: os.sep + os.sep.join(l)

path =  [user, xon_dir]

if not user == "root":
    path = ["home"] + path

path =  absolute_path(path)

sys.path = [path, path + "/local"] + sys.path

from local import *

def _domain_ip(args):
    if args:
        return socket.gethostbyname(args[0])

aliases['domain_ip'] = newline(_domain_ip)
