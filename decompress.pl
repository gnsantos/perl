#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV != 1){
    die "Insuficient arguments.\n";
}

my $filename = $ARGV[0];
if($filename =~ /(\w*).txt.comp/){
    $filename = $1.".txt.decomp";
}
my $text = [[]];
my $line, my $column;
while(<>){
    my @wordpos = split;
    my $word = shift @wordpos;
    for my $pos (@wordpos){
	if($pos =~ /\((\d*),(\d*)\)/){
	    $line = $1;
	    $column = $2;
	    $text->[$line]->[$column] = $word;
	}
    }
}

open FILE, "> $filename";
select FILE;

foreach my $linha (@{$text}){
    foreach my $coluna (@{$linha}){
	print "$coluna ";
    }
    print "\n";
}
 
