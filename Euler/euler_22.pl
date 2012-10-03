#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

open(F, '/home/mor/my_projects/perl/names.txt') || die $!;

my $text = <F>;
my @names = sort split(/[\s",]+/, $text);

my %alpha_num = (
    'A' => 1 ,
    'B' => 2 ,
    'C' => 3 ,
    'D' => 4 ,
    'E' => 5 ,
    'F' => 6 ,
    'G' => 7 ,
    'H' => 8 ,
    'I' => 9 ,
    'J' => 10,
    'K' => 11,
    'L' => 12,
    'M' => 13,
    'N' => 14,
    'O' => 15,
    'P' => 16,
    'Q' => 17,
    'R' => 18,
    'S' => 19,
    'T' => 20,
    'U' => 21,
    'V' => 22,
    'W' => 23,
    'X' => 24,
    'Y' => 25,
    'Z' => 26,
);

# my $name = $names[938];
my $res;
for ( my $i = 1; $i < scalar @names; $i++ ) 
{
    my $sum;
    map { $sum += $alpha_num{$_}; } split('', $names[$i]);
    $res += $i * $sum

}
print $res;








