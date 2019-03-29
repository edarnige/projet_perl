#!/usr/bin/perl
use strict;
use warnings;
use DBI; 
my $dbh=DBI->connect("DBI:Pg:dbname=juagarcia; host=dbserver", "juagarcia","Esinux14",{'RaiseError'=>1});

sub ajouterProteine(){
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

}

sub modifierProteine(){
    print "Enter UniProt ID to be modified:\n";

    my $identifier=<STDIN>;

    print "Enter new aminoacid sequence:\n";

    my $sequence=<STDIN>;



    my $query=sprintf("update uniprot_entry set sequence=%s where uniprot_id=%s",$sequence,$identifier);

    my $sth=$dbh->prepare($query);
    $sth->execute();

}

sub nomProteines(){

    my $query="select distinct protein_name from uniprot_plant,uniprot,uniprot_entry,protein_uniprot where uni_trembl=entry and entry=uniprot_entry.uniprot_id and uniprot_entry.uniprot_id=protein_uniprot.uniprot_id;";

   
    my $sth=$dbh->prepare($query);
    $sth->execute();
    open(FILE,">./proteines_ref.html");

    while ( my $row = $sth->fetchrow_arrayref ) {
        print FILE "<br/>", @$row;
    }

    close(FILE);
};



sub nomGenes(){

    my $query="select distinct gene_name from gene_uniprot,uniprot_plant where uni_trembl=uniprot_id;";

    my $sth=$dbh->prepare($query);
    $sth->execute();

    open(FILE,">./genes_ref.html");

    while ( my $row = $sth->fetchrow_arrayref ) {
        print FILE "<br/>", @$row[0];
    }

    close(FILE);
}
    


sub longProteine() {
    print "Enter length threshold:\n";

    my $longueur=<STDIN>;
    chomp $longueur;


    my $query=sprintf("select Entry, protein_name from UniProt,protein_uniprot where length>=%d and uniprot_id=entry;",$longueur);

    my $sth=$dbh->prepare($query);
    my $num=$sth->execute();

    print "Query returned $num rows\n";

    open(FILE,">./long_proteines.html");

    while ( my $row = $sth->fetchrow_arrayref ) {
        print FILE "<br/>", @$row[0],"&emsp;",@$row[1];
    }

    close(FILE);
}

sub rechercherEC(){
    print "Enter qn E.C. to look up:\n";
    my $EC=<STDIN>;
    chomp $EC;
    my $query = $dbh->prepare("SELECT protein_name,entry,length,sequence FROM protein_uniprot,uniprot_entry,uniprot WHERE entry=uniprot_entry.uniprot_id and uniprot_entry.uniprot_id=protein_uniprot.uniprot_id and protein_name LIKE '\%EC $EC\%' ");

    my $num=$query->execute();

    print "Query returned $num rows\n";
    open(FILE,">./EC.html");

    while ( my $row = $query->fetchrow_arrayref ) {
        print FILE "<br/>", @$row[0],"&emsp;",@$row[1],"&emsp;",@$row[2],"&emsp;",@$row[3];
    }

    close(FILE);


}

sub display_menu{
    print "==========Menu========\n";
    print "1 - Add a protein\n";
    print "2 - Edit a sequence\n";
    print "3 - Show proteins referenced in both UniProt and EnsemblePlants (saved as .html)\n";
    print "4 - Show gened referenced in both UniProt and EnsemblePlants (saved as .html)\n";
    print "5 - Show proteins with length over threshold (saved as .html)\n";
    print "6 - Show proteins by EC number\n";
    print "0 - quit\n";
    print "=====================\n";
}

my $choice;

$choice=1;

while ($choice != 0){
    display_menu();
    print "Enter your choice: ";
    $choice= <STDIN>;
    chomp($choice);

    if ($choice == 0){
        print "Goodbye\n";
        my $dbh->disconnect();
        exit 42;
    }elsif($choice == 1){
        ajouterProteine();
    }elsif($choice == 2){
        modifierProteine();
    }elsif($choice == 3){
        nomProteines();
    }elsif($choice == 4){
        nomGenes();
    }elsif($choice == 5){
        longProteine();
    }elsif($choice == 6){
        rechercherEC();
    }else{
        print "Please enter a valid choice\n";
    }

    
}
