#!/usr/bin/perl 
use warnings;

use Net::Jabber;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use Storable;

$CARD       = '****************';
$PASSWORD   = '************';
$URL        = 'https://www.platina.ru/card/online/statement/';
$JUSER      = 'vostrykh';
$JPASS      = '*******';
$JSERVER    = 'im.cyberplat.com';
$JNOTIFY    = 'vostrykh@im.cyberplat.com';
$BAL_FILE   = $ENV{HOME} . '/.balance'; 

$ENV{https_proxy}   = "";

# забираем с сервера текущий баланс
($bal) = LWP::UserAgent->new->request(POST $URL, [ card => $CARD, secretword => $PASSWORD])->as_string =~ m#Available.*?<tt>[^\d]*([\d\.]+)#s;
print $bal;


# проверяем файл с предыдущим значением баланса
$bal_old = ${ retrieve($BAL_FILE) } if (-e $BAL_FILE); store(\$bal, $BAL_FILE);

# сравниваем новое значение со старым
exit unless ($bal > $bal_old);
$j = new Net::Jabber::Client();
$j->Connect(hostname => $JSERVER, port => 5222);
$j->AuthSend(username => $JUSER, password => $JPASS);
$j->MessageSend(to => $JNOTIFY, body => '+' . ($bal - $bal_old ));
