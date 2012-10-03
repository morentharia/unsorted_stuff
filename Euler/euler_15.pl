#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;


my ($size_x, $size_y) = (20, 20);

print way(0, 0);

{
    my %cash;
    sub way
    {
        my ($x, $y) = @_;

        return $cash{"$x $y"} if (exists $cash{"$x $y"});

        return 1 if ( $x == $size_x && $y == $size_y);
        return 0 if ( $x > $size_x || $y > $size_y);
        my $res = way($x + 1, $y    ) + way($x    , $y + 1);

        $cash{"$x $y"} = $res;

        return $res;
    }
}
