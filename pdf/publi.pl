#!/usr/bin/perl

use 5.12.0;
use warnings;
use strict;


my $file = `ls | grep pdf`; #pega nome do arquivo
my $num;
open CONF, "< config.txt";
while(<CONF>){
    $num = $_;
    print "oo numero: $num";
}
close CONF;
#open NEWCONF, " > config.txt";
#select NEWCONF;
#print $num +1;
#close NEWCONF;

my $url = "http://www3.tjma.jus.br:8080/diario/VisulizacaoDiarioPDF.mtw?idDiario=".$num;

system('wget '.$url);

#die "URL inexistente" unless $result == 0;

system("mv VisulizacaoDiarioPDF.mtw?idDiario=$num diarioTJ.pdf");

system('pdftotext -raw -enc UTF-8 '.$file); #transforma pdf em txt para leitura
$file =~ s/pdf/txt/;        #passa-se a lidar com o arquivo em txt
open PUB, "< $file";        #abre-se um handle para leitura
my @lines = <PUB>;          #coloca as linhas do arquivo em uma lista

for(my $i = 0; $i < @lines; $i++){
    if($lines[$i] =~ /Soraya Abdalla/i){
	print "\nEncontrei uma publicacao!\n\n\n";
	my $j = $i;
	while( $lines[$j] !~ /ACÓRDÃO/i ){
	    $j--;
	}
	$j--;
	my $message = "";
	while( $lines[$j++] !~ /Presidente e Relator/i ){
	    $message = $message."$lines[$j]";
	}
	print $message;
    }
}
