#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw/sum/;
use Math::BigFloat;

my $n = Math::BigFloat->new(1E-0);
$n->bround(10000);

my $max = 0;
# foreach (97..97)
# foreach (997..997)
# foreach (7..7)
foreach (1..1000)
{
    my $zzz = $n / $_;
    # print "\n";
    # print Dumper $zzz->bstr();
    foreach my $res ($zzz->bstr() =~ /(\d+?)(?=\1)/g)
    {
        if ($max < length($res))
        {
            $max = length($res);
            print "$_ : $res \n";
        }
        # print Dumper $zzz->bstr() =~ /(\d+?)(?=\1)/g;
    }
}



