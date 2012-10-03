#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;


print [ prime_numbers(300000) ]->[10001 - 1];


sub prime_numbers
{
    my @numbers = (0..$_[0]);
    for (my $n = 2; $n < sqrt(@numbers); ++$n)
    {
        next unless (defined $numbers[$n]);

        for (my $i = $n + $n; $i < @numbers; $i += $n) 
        {
            $numbers[$i] = undef;
        }
    }
    grep { defined($_) && $_ != 0 && $_ != 1} @numbers;
}
