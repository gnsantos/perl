#!/usr/bin/perl

$, = "\n\n";

use warnings;
use strict;


my $stalkeado = shift;
my $info = `rwho | grep $stalkeado`;
my $machine;
if($info =~ /\w*\s*[\w|\s]*\d\d:\d\d\s*(\w*)/){
    $machine = $1;
}

system("ssh ".$machine);
