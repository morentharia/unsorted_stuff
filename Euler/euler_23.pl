#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(reduce sum);

# print Dumper sum all_divisors(220);
# print Dumper sum all_divisors(284);
print Dumper     all_divisors(30);
print Dumper sum all_divisors(30);
# exit;


my @excess;
foreach my $n (2..28123)
{
    my $sum = sum all_divisors($n);
    # print "$n $sum \n";
    if ( $sum > $n ) 
    {
        push @excess, $n;
    }
}
# print Dumper \@excess;
# print Dumper scalar @excess;
print "excess finded \n";

my @res = (0, 1..28123);
foreach my $i (0..$#excess)
{
    foreach my $j ($i..$#excess)
    {        
        my $index = $excess[$i] + $excess[$j];
        if ($index <= $#res)
        {
            $res[ $index ] = 0;
        }
    }
}

print "RESULT: " . (Dumper @res) . "\n";
print "RESULT: " . (sum @res) . "\n";


{
    my @prime;
    sub all_divisors
    {
        my ($num) = @_;

        unless (@prime)
        {
            @prime = prime_numbers(65535);
            # print "Ok prime numbers generated: " . scalar @prime . "\n";
        }

        my $tmp = $num;
        my %prime_divisors;
        foreach my $p (@prime)
        {
            while (0 == $tmp % $p)
            {
                $prime_divisors{$p}++;
                $tmp /= $p;
            }
            if (1 == $tmp) 
            {
                last;
            }
        }


        my (@divisor, @grade);
        while (my ($divisor, $grade) = each(%prime_divisors))
        {
            push @divisor, $divisor;
            push @grade, $grade;
        }

        # print Dumper \%prime_divisors;
        # print Dumper (\@divisor, \@grade);

        my @result;
        foreach my $g (all_variants(@grade))
        {
            my $d = 1;
            map { $d *= $divisor[$_] ** $g->[$_] } (0..$#$g);
            push @result, $d;
        }
        pop @result;
        return @result;
    }
}


sub all_variants
{
    my @max = @_;

    my @begin = @max;
    map {$_ = 0} @begin;
    
    # print Dumper \@begin;
    
    my @res;
    push @res, [ @begin ];
    while(1)
    {
        my $is_end;
        $begin[0]++;
        foreach my $i (0..$#max)
        {
            if ($begin[$i] > $max[$i])
            {
                $begin[$i] = 0;
                
                if ( $i + 1 > $#max ) 
                {
                    $is_end = 1;
                } 
                else
                {
                    $begin[$i + 1]++;
                }
            }
        }
        last if ($is_end);
        # print "@begin" . "\n";
        push @res, [ @begin ];
    }
    return @res;
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
