#!/usr/bin/env perl
use strict;
use warnings;

my $cur;
my ($prev_prev, $prev) = (1, 2);
my $res;
while (1)
{
    $cur        = $prev + $prev_prev;
    $prev_prev  = $prev;
    $prev       = $cur; 
    last if ($cur >= 4000000);

    if (0 == $cur % 2)
    {
        $res += $cur;
    }
        

    print $cur;
    print "\n";
}
print "result = " . ($res + 2);
print "\n";

