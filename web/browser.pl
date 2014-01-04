#!/usr/bin/perl

use 5.12.0;
use strict;
use LWP::UserAgent;
use HTTP::Request::Common qw(POST);
use HTTP::Request::Common qw(GET);
use HTTP::Cookies;

#my $browser = LWP::UserAgent->new;

#my $req = POST 'http://www.perlmeme.org', [name => 'Bob', age => 24];

#my $res = $browser->request($req);

#if($res->is_success){
#    print $res->content;
#} else {
 #   print "Oi!\n";
  #  print $res->status_line."\n";
#}
my $ua = LWP::UserAgent->new;

    # Define user agent type
    $ua->agent('Mozilla/8.0');

    # Cookies
    $ua->cookie_jar(
        HTTP::Cookies->new(
            file => 'mycookies.txt',
            autosave => 1
        )
    );

    # Request object
    my $req = GET 'http://www.perlmeme.org';

    # Make the request
    my $res = $ua->request($req);

    # Check the response
    if ($res->is_success) {
        print $res->content;
    } else {
        print $res->status_line . "\n";
    }

    exit 0;

