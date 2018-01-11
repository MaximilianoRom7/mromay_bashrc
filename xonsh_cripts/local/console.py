def removeLastNewLine(text):
    if text[-1] == "\n":
        return text[:-1]
    else:
        return text

def pipeArgs(pipe):
    if pipe:
        return removeLastNewLine(pipe.read()).split(" ")
    else:
        return []

def printDict(d):
    out = ""
    if type(d) == dict:
        for key, val in d.items():
            out += str(key) + ": " + str(val) + "\n"
        return out
    else:
        return str(d) + "\n"

def newline(func):
    """
    CALLS THE ORIGINAL FUNCTION APPENDING A NEW LINE AT THE END
    """
    def inner(args, pipe=None):
        args += pipeArgs(pipe)
        return printDict(func(*args)) + "\n"
    return inner
