#!/usr/bin/python
# -*- encoding: utf-8 -*-

from cStringIO import StringIO


def my_wc(s):
    """
    >>> my_wc('''abc''')
    '1\\t1\\t3\\n'

    >>> my_wc('''a bb c dd-d ee-eee fff'f
    ... ''')
    '1\\t6\\t25\\n'

    >>> my_wc('''a  bb c dd-d ee-eee fff'f''')
    '1\\t6\\t25\\n'

    >>> my_wc('''a bb c dd-d ee-eee fff'f
    ...
    ...
    ... ''')
    '3\\t6\\t27\\n'

    >>> my_wc('''a bb c dd-d ee-eee fff'f
    ...
    ... dah
    ...
    ... ''')
    '4\\t7\\t31\\n'
    """

    c = len(s)
    l = len(s.splitlines())
    w = len(s.split())

    return '%d\t%d\t%d\n' % (l, w, c)


def xreadlines(s):
    stri = StringIO(s)
    while True:
        nl = stri.readline()
        if nl != '':
            yield nl.strip('\n')
        else:
            raise StopIteration


def my_wc_2(s):
    """
    >>> my_wc_2('''abc''')
    '1\\t1\\t3\\n'

    >>> my_wc_2('''a bb c dd-d ee-eee fff'f
    ... ''')
    '1\\t6\\t25\\n'

    >>> my_wc_2('''a  bb c dd-d ee-eee fff'f''')
    '1\\t6\\t25\\n'

    >>> my_wc_2('''a bb c dd-d ee-eee fff'f
    ...
    ...
    ... ''')
    '3\\t6\\t27\\n'

    >>> my_wc_2('''a bb c dd-d ee-eee fff'f
    ...
    ... dah
    ...
    ... ''')
    '4\\t7\\t31\\n'
    """
    l = w = 0
    c = len(s)
    for i in xreadlines(s):
        l += 1
        w += len(i.split())

    return '%d\t%d\t%d\n' % (l, w, c)


if __name__ == "__main__":
    import doctest
    doctest.testmod()
