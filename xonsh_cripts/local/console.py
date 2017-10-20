

def _newline(func):
    """
    CALLS THE ORIGINAL FUNCTION APPENDING A NEW LINE AT THE END
    """
    def inner(args):
        return str(func(args)) + "\n"
    return inner
