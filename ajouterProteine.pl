use strict;
use warnings;
use DBI; 


print "Enter Uniprot ID:\n";
my $Entry=<STDIN>;
chomp $Entry;

print "Enter Entry name:\n";
my $Entry_name=<STDIN>;
chomp $Entry_name;

print "Enter protein's status:\n";
my $Status=<STDIN>;
chomp $Status;

print "Enter names of the protein:\n";
my $Protein_names=<STDIN>;
chomp $Protein_names;

print "Enter gene names:\n";
my $Gene_names=<STDIN>;
chomp $Gene_names;

print "Enter name of the organism:\n";
my $Organism=<STDIN>;
chomp $Organism;

print "Enter length of the protein:\n";
my $Length=<STDIN>;
chomp $Length;

print "Enter definitions from Gene Ontology:\n";
my $GO=<STDIN>;
chomp $GO;

print "Enter EnsemblPlant transcript:\n";
my $Ensembl=<STDIN>;
chomp $Ensembl;

print "Enter protein sequence:\n";
my $Sequence=<STDIN>;
chomp $Sequence;

my $query1="insert into UniProt values(?,?,?,?,?)";
my $query2="insert into UniProt_Entry values(?,?,?)";
my $query3="insert into Protein_UniProt values(?,?)";
my $query4="insert into Gene_UniProt values(?,?)";
my $query5="insert into Ensembl_UniProt values(?,?)";

my $sth1;
my $sth2;
my $sth3;
my $sth4;
my $sth5;

my $dbh=DBI->connect("DBI:Pg:dbname=juagarcia; host=dbserver", "juagarcia","Esinux14",{'RaiseError'=>1});


$sth1=$dbh->prepare($query1);
$sth2=$dbh->prepare($query2);
$sth3=$dbh->prepare($query3);
$sth4=$dbh->prepare($query4);
$sth5=$dbh->prepare($query5);


$sth1->execute($Entry,$Status,$Organism,$Length,$GO);
$sth2->execute($Entry,$Entry_name,$Sequence);
$sth3->execute($Protein_names,$Entry);
$sth4->execute($Gene_names,$Entry);
$sth5->execute($Ensembl,$Entry);