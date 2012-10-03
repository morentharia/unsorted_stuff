#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw(reduce sum);

my @prime = prime_numbers(100000);
print "Ok prime numbers generated: " . scalar @prime . "\n";


for ( my ($triang_num, $i) = (1, 0); $i < 100000; $triang_num += 2 + $i++ ) 
{
    my %prime_divisors;
    my $tmp = $triang_num;
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

    # print Dumper \%prime_divisors;
    map {$prime_divisors{$_}++} keys %prime_divisors;

    my $res;
    no warnings;
    $res = reduce {$a * $b} values %prime_divisors;
    use warnings;
    # print $triang_num;
    # print ":";

    if (defined($res) && $res >= 500)
    {
        print $res . "\n" . $triang_num . "\n\n";
        last;
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

__END__
# my @a = (0);
# next_indexes(\@a, 1, 4);
sub next_indexes
{
    my ($a, $max, $size) = @_;
    $a->[0]++;
    foreach my $i (0..$#$a)
    {
        if ($a->[$i] > $max)
        {
            $a->[$i] = 0;
            $a->[$i + 1]++;
        }
    }
    return if ((scalar @$a) > $size);
}

# my $triang_num = 284;
# my $triang_num = 220;
# my $triang_num = 36;
my $max = 0;
# for ( my ($triang_num, $i) = (1, 0); $i < 1000; $triang_num += 2 + $i++ ) 
# for ( my ($triang_num, $i) = (437580, 0); $i < 100000000000000000000000000; $triang_num += 2 + $i++ ) 
for ( my ($triang_num, $i) = (36, 0); $i < 100000000000000000000000000; $triang_num += 2 + $i++ ) 
{
    my @prime_divisors;
    for ( my $i = 0; $prime[$i] <= $triang_num; $i++ ) 
    {
        if ($triang_num % $prime[$i] == 0)
        {
            push @prime_divisors, $prime[$i];
        }
    }

    my %other_divisors;
    my @a = (0, 0);
    foreach (0..@prime_divisors ** @prime_divisors)
    {
        # print Dumper \@a;
        # print Dumper [ @prime_divisors[@a] ];
        my $res = reduce {$a * $b} @prime_divisors[@a];
        if ($res !=0 && 0 == $triang_num % $res)
        {
            $other_divisors{$res}++;
        }
        next_indexes(\@a, $#prime_divisors, 5);
    }

    if ( scalar keys %other_divisors > $max ) 
    {
        $max = scalar keys %other_divisors;
        print $max . ":  " . $triang_num . "\n";
        print Dumper \@prime_divisors, [keys %other_divisors];
    }
    last;
    # print $triang_num  . ": " . join ', ', sort {$a <=> $b} keys %other_divisors;
    # print Dumper \@prime_divisors;
    # print Dumper \%other_divisors;
    # print reverse @a;


    # $other_divisors{1} = 1;
    # $other_divisors{$triang_num} = 1;

    # print Dumper $triang_num;
    # print Dumper scalar \@prime_divisors;
    # print Dumper scalar(keys %other_divisors);
    # print Dumper [ @other_divisors ];
    # print "\n";
}

