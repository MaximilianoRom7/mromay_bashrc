"""
THIS PYTHON SCRIPT IS MEANT TO BE EXECUTED USING XONSH

XONSH IS A BASH LIKE INTERPRETER WRITED IN PYTHON

INSTALL IT USING

SUDO PIP INSTALL XONSH
"""
import socket

def _domain_ip(args):
    return socket.gethostbyname(args[0])

def _newline(func):
    """
    CALLS THE ORIGINAL FUNCTION APPENDING A NEW LINE AT THE END
    """
    def inner(args):
        return str(func(args)) + "\n"
    return inner

aliases['domain_ip'] = _newline(_domain_ip)
