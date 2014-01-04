#!/usr/bin/perl

use 5.12.0;
use strict;
use LWP::Simple;

print "Enter a book: ";
my $book = <STDIN>;
my $url = join('_' , split(' ', $book));
my $url = "http://en.wikipedia.org/wiki/".$url;
print "Data extracted from $url\n";
my $content = get $url;
die "No such URL or too many results.\n" unless defined $content;
my @tags = split ('\n',$content);

foreach my $x (@tags){
    if( $x =~ /<th .*>(.*)<\/th>/){
	print "\n".$1;
    }
    if( $x =~ /<th .*>.*<a .*>(.*)<\/a>.*<\/th>/){
	print "\n".$1;
    }
    if( $x =~ /<td>([\w\s\d,-\/.]+).*<\/td>/){
	print ": ".$1."\n";
    }
    if( $x =~ /<td>.*<a .*>(.*)<\/a>.*(<\/td>)?/){
	print ": ".$1."\n";
    }
    if($x =~ /<\/table>/){ last;}
}

print "Plot summary: \n";

my $i; 
my $aux = 0;

for($i = 0; $i < @tags; $i++){
    if( $tags[$i] =~ /plot/i ){
	if( $aux == 0) {$aux = 1;}
	else {$i++; last;}
    }
}

until( $tags[$i] =~ /mw-headline/ ){
    $tags[$i] =~ s/<[\/api].*?>//g;
    $tags[$i] =~ s/<div.*>//g;
    if($tags[$i] eq ""){
	$i++;
    }
    else{
	print "$tags[$i++]\n\n";
    }
}
