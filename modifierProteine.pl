use strict;
use warnings;
use DBI; 

print "Enter UniProt ID to be modified:\n";

my $identifier=<STDIN>;
$identifier="".$identifier;

print "Enter new aminoacid sequence:\n";

my $sequence=<STDIN>;
$sequence="".$sequence;

my $dbh=DBI->connect("DBI:Pg:dbname=juagarcia; host=dbserver", "juagarcia","Esinux14",{'RaiseError'=>1});

my $query=sprintf("update UniProt_Entry set Sequence='%s' where UniProt_ID='%s'",$sequence,$identifier);

my $sth=$dbh->prepare($query);
$sth->execute();

## c) 

#select Uni_Trembl from UniProt_Plant where Uni_Trembl in (select Entry from UniProt)

## d)

#select Gene_name from Gene_UniProt where UniProt_ID in (select distinct Uni_Trembl from UniProt_Plant) 