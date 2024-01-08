import timeit
def function_a(X,Y):
    return X**10+Y**10
def function_b(X,Y):
    return  X**10*Y**10
def function_c(X,Y):
    return  X**10/Y**10

X,Y = 1,1
if __name__ == "__main__":
    repeats = 1000
    for function in ("function_a", "function_b", "function_c"):
        t = timeit.Timer("{0}(X, Y)".format(function), "from __main__ import {0}, X, Y".format(function))
        sec = t.timeit(repeats) / repeats
        print("{function}() {sec:.10f} sec".format(**locals()))
