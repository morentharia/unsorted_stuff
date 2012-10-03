#!/usr/bin/env perl
use strict;
use warnings;
use POSIX qw/floor/;

my $MAX = 1000 - 1;
my $res = 0;
foreach my $i (1..$MAX)
{
    if (($i % 3 == 0) || ($i % 5 == 0))
    {
        print $i . "\n";
        $res += $i;
    }
}
print "result = " . $res;
print "\n";

sub sum
{
    my ($d) = @_;
    my $n = floor($MAX / $d);
    return ((2 * $d + $d * ($n - 1)) / 2) * $n;
}

print "result = " . (sum(3) + sum(5) - sum(15));
print "\n";



