#!/usr/bin/env perl
use strict;
use warnings;

my $num = 0;
foreach my $year ( 1901..2000 ) 
{
    foreach my $month (1..12)
    {
        $num += `cal $month $year | grep \'                   1\' | wc -l`;
    }
}
print $num;

