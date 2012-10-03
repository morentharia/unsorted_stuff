#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my @factors = (2..20);
my $num = 1;
map {$num *= $_;} @factors;

foreach my $d (@factors)
{
    while ( $num % $d == 0 && 
        check_divisibility($num / $d, \@factors) )
    {
        $num /= $d;
    }
}
print $num;


sub check_divisibility
{
    my ($num, $factors) = @_;
    my $is_ok = 1;
    foreach (@$factors)
    {
        unless (0 == $num % $_)
        {
            $is_ok = undef;
            last;
        }
    }
    return $is_ok;
}
