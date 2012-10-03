#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(reduce sum);

# my $graph = [
#     [ qw{    3    } ],
#     [ qw{   7 4   } ],
#     [ qw{  2 4 6  } ],
#     [ qw{ 8 5 9 3 } ],

my $graph = [
    [ qw { 75                                           } ],
    [ qw { 95 64                                        } ],
    [ qw { 17 47 82                                     } ],
    [ qw { 18 35 87 10                                  } ],
    [ qw { 20 04 82 47 65                               } ],
    [ qw { 19 01 23 75 03 34                            } ],
    [ qw { 88 02 77 73 07 63 67                         } ],
    [ qw { 99 65 04 28 06 16 70 92                      } ],
    [ qw { 41 41 26 56 83 40 80 70 33                   } ],
    [ qw { 41 48 72 33 47 32 37 16 94 29                } ],
    [ qw { 53 71 44 65 25 43 91 52 97 51 14             } ],
    [ qw { 70 11 33 28 77 73 17 78 39 68 17 57          } ],
    [ qw { 91 71 52 38 17 14 91 43 58 50 27 29 48       } ],
    [ qw { 63 66 04 68 89 53 67 30 73 16 69 87 40 31    } ],
    [ qw { 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23 } ],
];

sub left
{
    my ($level, $index) = @_;
    return ($level + 1, $index);
}

sub right
{
    my ($level, $index) = @_;
    return ($level + 1, $index + 1);
}

sub node_value
{
    my ($level, $index) = @_;
    # print Dumper ($level, $index);
    return $graph->[$level]->[$index];
}


{
    my $max_sum = 0;
    sub rec
    {
        my ($sum, @node) = @_;
        if ($node[0] > $#$graph)
        {
            if ($sum > $max_sum)
            {
                $max_sum = $sum;
            }
            return;
        }
    
        rec( $sum + node_value(@node), right(@node) );
        rec( $sum + node_value(@node), left(@node) );
    }
    
    rec(0, 0, 0);
    print $max_sum;
}

