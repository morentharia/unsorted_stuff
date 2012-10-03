#!/usr/bin/env perl
use strict;
use warnings;

my $max_num = 0;
foreach my $i (reverse(100..999))
{
    foreach my $j (reverse($i..999))
    {
        my $num = $i * $j;
        if ($num eq reverse($num) &&
            $max_num < $num )
        {
            $max_num = $num;
            last;
        }
    }
}
print $max_num;

