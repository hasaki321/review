# import functools
# import pdb
# print(list(filter(lambda x:x%2==0,[i for i in range(5)])))
# print(list(map(lambda x:x**2,[i for i in range(5)])))
# print(functools.reduce(lambda x, y: x*y, [i for i in range(1,5)]))
# pdb.set_trace()
# print(all([1, 'a', True]))
# print(any([1, '', True]))
# x = 1
# def func(x):
#     """
#     >>> func(1)
#     1
#     """  
#     return x+1

# # import doctest
# # doctest.testmod()
import sys
print(sys.argv)

def func(x): pass
import timeit
x = 1
t = timeit.Timer('func(x)','from __main__ import x,func')
print(t.timeit(10))