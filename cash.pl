#!/usr/bin/env perl

use warnings;
use strict;
use utf8;        # for Jabber

use Data::Dumper;

use WWW::Mechanize;
use HTML::TokeParser;
use Net::Jabber;
use Storable;

my %jabber_conf = ( 
    hostname    => "im.workworkwrok.com", 
    port        => 5222,

    username    => "vos", 
    password    => "1111111111111111111111", 
);

my %jabber_msg = (
    to      => $jabber_conf{username} . '@im.cyberplat.com',
); 

my $wage = parse_wage(
    url     => "https://www.platina.ru/card/online/",
    fields  => {
        card        => "132451324512345",
        secretword  => "*********************"
    }
);

my $wage_store_file = $ENV{HOME} . '/.wage';

my $stored_wage = 0;
eval{ $stored_wage = ${ retrieve($wage_store_file) } };

## DEBUG
# $stored_wage = 0;

if ($wage != $stored_wage)
{
    store(\$wage, $wage_store_file) or die "Can't store wage !\n";
}

if ($wage > $stored_wage) 
{
    my $jabber_client = new Net::Jabber::Client();
    
    my $status = $jabber_client->Connect(hostname => $jabber_conf{hostname}, port => $jabber_conf{port});
    die "Jabber conect status: $status" unless ($status);
       
    my @res = $jabber_client->AuthSend(
        username    => $jabber_conf{username}, 
        password    => $jabber_conf{password}, 
        resourse    => "autosend"
    );
    die "Jabber auth:" . $res[0] unless ( "ok" eq $res[0]);
    
    $jabber_client->MessageSend(      
        %jabber_msg,
        body    => 'бабла привалило забухай ебт!! : ' . $wage . " ( +" . ($stored_wage - $wage) . " )",
    );
}

sub parse_wage
{
    my (%args) = @_;
    my $agent = WWW::Mechanize->new();

    $agent->get($args{url});

    my $res = $agent->submit_form(form_number => 1, fields => $args{fields});
    die $res->status_line unless $res->is_success;

    my $stream = HTML::TokeParser->new(\$agent->{content});

    $stream->get_tag('table') foreach (0..7);
    $stream->get_tag('tr') foreach (0..11);

    $stream->get_tag('td');
    # print Dumper $stream->get_text("/td");
    $stream->get_tag('td');

    my $wage = $stream->get_trimmed_text("/td");
    $wage =~ s/[^\.\d]//g;

    # die "error wage format: $wage" if ($wage !~ /^\d+(\.\d+)?$/);
    return $wage;
}

