#!/usr/bin/python
# -*- coding: utf-8 -*-

import tempfile
import heapq
import csv
from itertools import islice
from collections import namedtuple


def merge(key=None, *iterables):
    if key is None:
        for element in heapq.merge(*iterables):
            yield element
    else:
        Keyed = namedtuple("Keyed", ["key", "obj"])
        keyed_iterables = [(Keyed(key(obj), obj) for obj in iterable)
                           for iterable in iterables]
        for element in heapq.merge(*keyed_iterables):
            yield element.obj


def sorted_huge_csv_file(filename, chunk_size=2, key=None):
    chunks = []
    with open(filename) as f:
        reader = csv.reader(f)
        while 1:
            current_chunk = list(islice(reader, chunk_size))
            if not current_chunk:
                break
            current_chunk.sort(key=key)
            f = tempfile.TemporaryFile()
            csv.writer(f).writerows(current_chunk)
            f.seek(0)
            del current_chunk[:]
            chunks.append(csv.reader(f))
    return merge(key, *chunks)


key = lambda row: row[0]
join_rows = lambda row1, row2: row1 + [row2[1]]
file1 = sorted_huge_csv_file('file_1.csv', chunk_size=2, key=key)
file2 = sorted_huge_csv_file('file_2.csv', chunk_size=2, key=key)
with open('result.csv', 'w') as f:
    writer = csv.writer(f)
    try:
        row2 = file2.next()
        for row1 in file1:
            while key(row1) == key(row2):
                writer.writerow(join_rows(row1, row2))
                print join_rows(row1, row2)
                row2 = file2.next()
    except StopIteration:
        pass
