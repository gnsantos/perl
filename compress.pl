#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV != 1){
    die "Insuficient arguments.\n";
}

my $filename = $ARGV[0];
my @words;
my %compressed;
my $line = 0;
my $pos = 0;

while(<>){
    @words = split;
    $pos = 0;
    for my $word (@words){
	my $ref = [$line, $pos];
	if(exists $compressed{$word}){
	    push @{$compressed{$word}}, $ref;
	}
	else{
	    $compressed{$word} = [];
	    push @{$compressed{$word}}, $ref;
	}
	$pos++;
    }
    $line++;
}

open FILE, "> $filename".".comp";
select FILE;
foreach my $element (sort keys %compressed){
    print "$element ";
    my $tam = @{$compressed{$element}};
    for(my $i = 0; $i < $tam; $i++){
	my $j = $compressed{$element}->[$i];
	print "($j->[0],$j->[1]) ";
    }
    print "\n";
}

