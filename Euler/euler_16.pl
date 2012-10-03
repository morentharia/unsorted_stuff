#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(reduce sum);
use Math::BigInt;

my $num = Math::BigInt->new(2) ** 1000;
print sum split(//, $num->bstr());


