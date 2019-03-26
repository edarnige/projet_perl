#!/usr/bin/perl
use strict;
use warnings;
use DBI;

#Connect
my $dbh = DBI->connect("DBI:Pg:dbname=juagarcia;
host=dbserver", "juagarcia", "Esinux14", {'RaiseError' => 1});

$dbh->do("create table UniProt(Entry varchar(200) primary key, Status varchar(200), Organism varchar(100), Length int, GO varchar(50000))");
$dbh->do("create table Uniprot_Plant( Uni_Trembl varchar(30), Gene_Stable varchar(200), Transcript varchar(25000), Plant_React varchar(50000), constraint key primary key (Uni_Trembl,Gene_Stable,Transcript,Plant_React))");
$dbh->do("create table Uniprot_Entry(UniProt_ID varchar(25) primary key, Entry_Name varchar(200), Sequence varchar(20000))"); ###
$dbh->do("create table Protein_UniProt(Protein_Name varchar(200000), UniProt_ID varchar(25) primary key)");
$dbh->do("create table Gene_Uniprot(Gene_name varchar(300000), UniProt_ID varchar(25) primary key)");
$dbh->do("create table Ensembl_UniProt(Ensembl_Pla varchar(200000), UniProt_ID varchar(25) primary key)");

## IMPORT

my @UniProt;


my $query1="insert into UniProt values(?,?,?,?,?)";
my $query1_1="insert into UniProt_Plant values(?,?,?,?)";
my $query2="insert into UniProt_Entry values(?,?,?)";
my $query3="insert into Protein_UniProt values(?,?)";
my $query4="insert into Gene_UniProt values(?,?)";
my $query5="insert into Ensembl_UniProt values(?,?)";

## Get data from mart_export_spliced.csv and paste it in a new table 



open(my $file,"UniProt_spliced.tab");

my @line;
my $sth1;
my $sth1_1;
my $sth2;
my $sth3;
my $sth4;
my $sth5;

$sth1=$dbh->prepare($query1);
$sth1_1=$dbh->prepare($query1_1);
$sth2=$dbh->prepare($query2);
$sth3=$dbh->prepare($query3);
$sth4=$dbh->prepare($query4);
$sth5=$dbh->prepare($query5);

while(<$file>){
    @line=split(/\t/,$_);
    if ($line[0]=~/Entry/){
        next;
    }
    $sth1->execute($line[0],$line[2],$line[5],$line[6],$line[8]);
    $sth2->execute($line[0],$line[1],$line[10]);
    $sth3->execute($line[3],$line[0]);
    $sth4->execute($line[4],$line[0]);
    $sth5->execute($line[9],$line[0]);
}
close($file);

open (my $fichier,"mart_export_spliced.csv");

while (<$fichier>){
    @line=split(/,/,$_);

    if ($line[0]=~/Gene Stable/){
        next;
    }
    $sth1_1->execute($line[2],$line[0],$line[1],$line[3]);
}

close($fichier);


# More filtering
$dbh->do("alter table Uniprot_Plant drop column Gene_Stable");

$dbh->disconnect();
