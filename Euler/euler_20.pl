#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(reduce sum);
use Math::BigInt;

my $num = Math::BigInt->new(1);

foreach (2..100)
{
    $num *= $_;
}


print sum split(//, $num->bstr());


