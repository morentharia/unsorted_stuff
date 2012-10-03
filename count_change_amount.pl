#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my @first_denomination = qw(1 5 10 25 50 100);
my %cash_count_change_amount = (); 

print Dumper count_change_amount(100, $#first_denomination);

sub count_change_amount
{
    my ($amount, $kind_of_coins, @haha) = @_;

    return $cash_count_change_amount{join('+', @haha)} if (exists $cash_count_change_amount{join('+', @haha)});
     
    if ($amount == 0)
    { 
        print join('+', @haha) . "\n";
        return 1;
    }
    elsif (($amount < 0) || ($kind_of_coins < 0))
    {
        return 0;
    }

    return 
        count_change_amount( 
            $amount, 
            $kind_of_coins - 1,
            @haha) 
        + 
        count_change_amount(
            $amount - $first_denomination[$kind_of_coins], 
            $kind_of_coins,
            (@haha, $first_denomination[$kind_of_coins]) );
}

