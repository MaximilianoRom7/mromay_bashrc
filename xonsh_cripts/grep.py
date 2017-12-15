import os
import re

def path_full(path):
    """
    Replaces the first characters './' and '~/' for the full path
    """
    if not path:
        return ""
    first = path[:2]
    if first == "~" + os.sep:
        return os.getenv("HOME") + os.sep + path[2:]
    if first == "." + os.sep:
        return os.getcwd() + os.sep + path[2:]
    return path

def grep(text, path):
    """
    Filters the source of the file using regular expressions
    """
    if not path:
        return ""
    lines = ""
    path = path_full(path)
    source = open(path, 'r')
    for line in source:
        if re.search(text, line):
            lines += line
    return lines
