#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Permutor;

my $perm = new List::Permutor qw(0 1 2 3 4 5 6 7 8 9);
foreach (1..1000000 - 1) 
{
    $perm->next;
}
print join '', $perm->next;
