#!/usr/bin/perl

use strict;
use warnings;
use IO::Handle;
use List::Util qw(shuffle);

open CONFIG, "> saida.txt";
select CONFIG;
my @a = (2..5,1,6);
my @sorted = sort @a;
print "@sorted"."\n";
while("@sorted" ne "@a"){
    @a = shuffle(@a);
    print "@a"."\n";
}
select STDOUT;
my $numShuffle = `wc -l saida.txt`;
print "The array was shuffled ". $numShuffle . " times";
