#!/usr/bin/perl

use warnings;
use strict;
$, = "\n";
my @processes = split('\n',`ps`);

shift @processes;
shift @processes;

my $reg = shift;

foreach my $active (@processes){
  if( $active =~ /$reg/ ){
	if( $active =~ /([0-9]+)/ ){
		my $pnumber = $1;
		system('kill -s SIGKILL '.$pnumber);
    }	
  }
}
