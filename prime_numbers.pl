#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;


print Dumper prime_numbers(999999);

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
    grep { defined($_) } @numbers;
}
