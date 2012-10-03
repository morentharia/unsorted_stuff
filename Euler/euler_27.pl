#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.1;

my %prime_numbers;
foreach (prime_numbers(65535))
{
    $prime_numbers{$_} = 1;
}

my $res;
my $max = 0;

foreach my $a (-1000..1000)
{
    foreach my $b (-1000..1000)
    {
        for (my $n = 0; ; $n++)
        {
            my $f = $n**2 + $a * $n + $b;
            unless (exists $prime_numbers{$f})
            {
                if ($max < $n)
                {
                    $max = $n;
                    say "RESULT: n = $n; a = $a; b = $b; a * b = " . $a * $b;
                }
                last;
            }
        }
    }
}


sub prime_numbers
{
    my @numbers = (0..$_[0]);
    for (my $n = 2; $n < sqrt(@numbers); ++$n)
    {
        next unless (defined $numbers[$n]);

        for (my $i = $n + $n; $i < @numbers; $i += $n) 
        {
            $numbers[$i] = undef;
        }
    }
    grep { defined($_) && $_ != 0 && $_ != 1} @numbers;
}
