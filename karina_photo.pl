#!/usr/bin/env perl

use warnings;
use strict;
use utf8;      

use WWW::Mechanize;
use HTML::TreeBuilder;
use URI::Escape;
use LWP::UserAgent;
use MIME::Base64;
use Data::Dumper;
use strict;

my $proxy = 'proxyhost';
my $username = '********';
my $password = '*******************';

my $url = 'http://capturejordan.com/ViewPhoto.aspx?UserPhotosId=2422';

my $alias = 'Windows IE 6';

$ENV{'HTTP_PROXY'} = 'http://' . $username . ':' . $password . '@' . $proxy . '/';
# print $ENV{HTTP_PROXY};

foreach (1..2)
{
    my $mech = WWW::Mechanize->new( autocheck => 1, agent => $alias);
    $mech->env_proxy();
    $mech->get( $url );
    
    my $node = HTML::TreeBuilder->new();
    $node->parse( $mech->content );
    
    print $node->find_by_attribute( id => 'ctl00_ContentPlaceHolder1_lblRatingCount')->content()->[0];
    my $viewstate = $node->find_by_attribute( id => '__VIEWSTATE')->attr('value');
    
    $mech->post(
        'http://capturejordan.com/ViewPhoto.aspx?UserPhotosId=2422',
        [ 
        'ctl00$SearchBox1$sp1' => 'ctl00$ContentPlaceHolder1$up2|ctl00$ContentPlaceHolder1$ImageButtonLike',
        '__EVENTTARGET' => '',
        '__EVENTARGUMENT' => '',
        '__VIEWSTATE' => $viewstate,
        'ctl00$SearchBox1$TBWE2_ClientState' => '' ,
        'ctl00$SearchBox1$TextBoxSearch' => '',
        'ctl00$ContentPlaceHolder1$txtName' => '' ,
        'ctl00$ContentPlaceHolder1$txtEmail' => '',
        'ctl00$ContentPlaceHolder1$txtComments' => '',
        'ctl00$ContentPlaceHolder1$ImageButtonLike.x' => 5,
        'ctl00$ContentPlaceHolder1$ImageButtonLike.y' => 15,
        ]
    );
    sleep(5);
}


# my $response = $mech->response();

# for my $key ( $response->header_field_names() ) 
# {
#     print $key, ":", $response->header( $key ), "\n";
# }
# print Dumper $response->content();

