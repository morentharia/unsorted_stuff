#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(max);

print max( grep {( 600851475143 % $_ ) == 0;} prime_numbers(sqrt(600851475143)) );


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
    grep { defined($_) && $_ != 0 } @numbers;
}
