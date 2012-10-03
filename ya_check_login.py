import re


def check_login(login):
    """
    >>> check_login('a')
    True
    >>> check_login('3')
    False
    >>> check_login('-')
    False
    >>> check_login('.')
    False
    >>> check_login('.3')
    False
    >>> check_login('a-')
    False
    >>> check_login('aa')
    True
    >>> check_login('a.')
    False
    >>> check_login('a.3')
    True
    >>> check_login('a-bbbbb.3')
    True
    >>> check_login('-bbbbb.3')
    False
    >>> check_login('a1b----------------9')
    True
    >>> check_login('a12345678901234567891')
    False
    >>> check_login('a123456789012345678-')
    False
    >>> check_login('11234567890123456789')
    False
    """
    p = re.compile('''
                   [a-zA-Z]
                   (
                       [a-zA-Z0-9]?$
                       |
                       [a-zA-Z0-9\.\-]{1,18}[a-zA-Z0-9]$
                   )
                   ''',
                   re.VERBOSE)
    if p.match(login):
        return True
    return False


if __name__ == "__main__":
    import doctest
    doctest.testmod()
