#!/usr/bin/python

def Haha(degree):
    for i in xrange(2, 10**6):
        if i == sum([int(c)**(degree) for c in str(i)]):
            yield i


print sum(Haha(5));
