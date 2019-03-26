#!/usr/bin/perl
use strict;
use warnings;
use DBI;

print "Enter length threshold:\n";

my $longueur=<STDIN>;
chomp $longueur;

my $dbh=DBI->connect("DBI:Pg:dbname=juagarcia; host=dbserver", "juagarcia","Esinux14",{'RaiseError'=>1});

my $query=sprintf("select Entry from UniProt where length>=%d",$longueur);

my $sth=$dbh->prepare($query);
$sth->execute();

open my $fh, '>', "./file_detail.txt" or die $!;
select $fh;

while ( my $row = $sth->fetchrow_arrayref ) {
    printf "%s\n", @$row;
}