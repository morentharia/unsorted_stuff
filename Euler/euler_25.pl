#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw/sum/;
use Math::BigInt;

my $f0 = Math::BigInt->new(1);
my $f1 = Math::BigInt->new(1);
my $f2 = Math::BigInt->new(0);

foreach (3..1223492384)
{
    $f2 = $f0 + $f1;
    ($f0, $f1) = ($f1, $f2);
    if (1000 == length $f2->bstr())
    {
        print $_ . " : " . $f2->bstr() . "\n";
        last;
    }
}


# print sum split(//, $f2->bstr());

