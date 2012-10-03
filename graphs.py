#!/usr/bin/python

G = {
 'a': set('bcdef'),
 'b': set('ce'),
 'c': set('d'),
 'd': set('e'),
 'e': set('f'),
 'f': set('cgh'),
 'g': set('fh'),
 'h': set('fg')
}

print 'c' in G['b']


a, b, c, d, e, f, g, h = range(8)
N = [
 {b:2, c:1, d:3, e:9, f:4},  # a
 {c:4, e:3},  # b
 {d:8},  # c
 {e:7},  # d
 {f:5},  # e
 {c:2, g:2, h:2},  # f
 {f:1, h:6},  # g
 {f:9, g:8}  # h
]

print b in N[a]
print len(N[a])
print N[a][d]

if g in N[a]:
    print N[a][g]
else:
    print "Fail"


def rec_dfs(G, s, S=None):
    if S is None:
        S = set()
    S.add(s)
    for u in G[s]:
        if u in S:
            continue
        print S
        rec_dfs(G, u, S)


def iter_dfs(G, s):
    S, Q = set(), []
    Q.append(s)
    while Q:
        print Q
        u = Q.pop()
        if u in S:
            continue
        S.add(u)
        Q.extend(G[u])
        yield u


print sorted(list(iter_dfs(N, a)))


def partition(seq):
    pi, seq = seq[0], seq[1:]
    lo = [x for x in seq if x <= pi]
    hi = [x for x in seq if x > pi]
    return lo, pi, hi


def select(seq, k):
    lo, pi, hi = partition(seq)
    m = len(lo)
    if m == k:
        return pi
    elif m < k:
        return select(hi, k - m - 1)
    else:
        return select(lo, k)


def quicksort(seq):
    if len(seq) <= 1:
        return seq
    # Base case
    lo, pi, hi = partition(seq)
    # pi is in its place
    return quicksort(lo) + [pi] + quicksort(hi)  # Sort lo and hi separately


haha = range(30)
haha.reverse()
print haha
print quicksort(haha)
