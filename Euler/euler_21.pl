#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(reduce sum);

# print Dumper sum all_divisors(220);
# print Dumper sum all_divisors(284);


my $sum = 0;
my %sum_hash;
my %friends;
# foreach (2..10000)
foreach (2..10000)
{
    $friends{$_} = sum all_divisors($_);
}

foreach my $d (keys %friends)
{
     # if (exists $friends{ $friends{$_} } && $friends{$_} == $friends{ $friends{$_} })
     if (exists $friends{ $d } && 
         exists $friends{ $friends{ $d } } &&
         $d != $friends{ $d } &&
         $d == $friends{ $friends{ $d } }
     )
     {
         unless (defined $sum_hash{$d})
         {
             print Dumper $d;
             $sum +=  $d;
             $sum_hash{$d} = 1;
         }

     }

}
# print Dumper \%friends;
print $sum;


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

