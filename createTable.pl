## CREATE TABLES

use strict;
use warnings;
# use DBI; 


# my $dbh=DBI->connect("DBI:Pg:dbname=juagarcia; host=dbserver", "juagarcia","Esinux14",{'RaiseError'=>1});

# $dbh->do("create table UniProt(Entry varchar(25) primary key, Status varchar(25), Organism varchar(100), Length int check (Length>0), GO varchar(500), Sequence varchar(2000000), Gene_Stable varchar(200), Transcript(250), Plant_React(500))");
# $dbh->do("create table Uniprot_Entry(UniProt_ID varchar(25), Entry_Name varchar(25) primary key)");
# $dbh->do("create table Protein_UniProt(Protein_Name varchar(200) primary key, UniProt_ID varchar(25))");
# $dbh->do("create table Gene_Uniprot(Gene_name varchar(300) primary key, UniProt_ID varchar(25))");
# $dbh->do("create table Ensembl_UniProt(Ensembl_Pla varchar(200) primary key, UniProt_ID varchar(25))");

## IMPORT

my @UniProt;


my $query1="insert into UniProt(Entry,Status,Organism,Length,GO,Sequence) values(?,?,?,?,?,?)";
my $query1_1="insert into UniProt(Gene_Stable,Transcript,Plant_React) values(?,?,?)";
my $query2="insert into UniProt_Entry values(?,?)";
my $query3="insert into Protein_UniProt values(?,?)";
my $query4="insert into Gene_UniProt values(?,?)";
my $query5="insert into Ensembl_UniProt values(?,?)";


open(my $file,"UniProt_spliced.tab");

my @line;
my $sth1;
my $sth1_1;
my $sth2;
my $sth3;
my $sth4;
my $sth5;

$sth1=dbh->prepare($query1);
$sth2=dbh->prepare($query2);
$sth3=dbh->prepare($query3);
$sth4=dbh->prepare($query4);
$sth5=dbh->prepare($query5);

while(<$file>){
    @line=split(/\t+/,$_);

    $sth1->execute($line[0],$line[2],)
}