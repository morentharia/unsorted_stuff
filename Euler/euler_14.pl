#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(reduce sum);

my $max_count = 1;
my $result;
foreach my $i (1..1000000)
{
    my $count = 1;
    my $n = $i;
    # print $n . " ";
    while ($n != 1)
    {
        if (0 == $n % 2)
        {
            $n /= 2;
        }
        else
        {
            $n = 3 * $n + 1;
        }
        # print $n . " ";
        $count++;
    }
    
    # print "\n"; 
    # print "RESULT " . $i . "\n";
    # print "COUNT: " . $count . "\n";

    if ($count > $max_count)
    {
        $max_count = $count;
        $result = $i;
    }
}

print "RESULT: " . $result . "\n";
