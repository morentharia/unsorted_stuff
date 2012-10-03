#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(reduce);

my ($a, $b, $c);
my $sum = 1000;
foreach $a (1..$sum)
{
    foreach $b ( $a + 1..$sum ) 
    {
        $c = $sum - $a - $b;
        if ($a * $a + $b * $b == $c * $c)
        {
            print $a * $b * $c; 
            exit;
        }
    }
}
