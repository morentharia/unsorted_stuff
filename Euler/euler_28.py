#!/usr/bin/python

c = {}
x, y = 0, 0

right, down, left, up = 1, 1, 2, 2
count = 1

while 1:

    def set_(x, y, val):
        if abs(x) == abs(y):
            c[x, y] = val

    for j in range(right):
        set_(x, y, count)
        x, y = x    , y + 1
        count += 1

    for j in range(down):
        set_(x, y, count)
        x, y = x + 1, y
        count += 1

    if count > 1001 ** 2:
        break

    for j in range(left):
        set_(x, y, count)
        x, y = x    , y - 1
        count += 1

    for j in range(up):
        set_(x, y, count)
        x, y = x - 1, y
        count += 1

    right, down, left, up = right + 2, down + 2, left + 2, up + 2



print reduce(lambda x, y: x+y, c.values())


