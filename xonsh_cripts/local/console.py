

def newline(func):
    """
    CALLS THE ORIGINAL FUNCTION APPENDING A NEW LINE AT THE END
    """
    def inner(args):
        if args:
            return str(func(args)) + "\n"
        return ""
    return inner
