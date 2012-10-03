#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my $sum = 0;
foreach my $i (2..100)
{
    $sum += $i * sum($i - 1);
}
print 2 * $sum;


sub sum
{
    my $p = shift;
    return $p * ($p + 1) / 2.;
}
