use strict;
use warnings;
use diagnostics;
use DBI;


my $dbh=DBI->connect("DBI:Pg:dbname=edarnige; host=dbserver", "edarnige","Rockey11!",{'RaiseError'=>1});

print "Enter qn E.C. to look up:\n";
my $EC=<STDIN>;
chomp $EC;
my $query = $dbh->prepare("SELECT protein_name FROM protein_uniprot WHERE protein_name LIKE ?");
# my $query = sprintf("SELECT protein_name FROM protein_uniprot WHERE protein_name LIKE \%EC %s\%",$EC);
# my $sth = $dbh->prepare($query);
$query->execute("'\% $EC\%'");

# $dbh-> disconnect();

#IN SQLs
#SELECT protein_name FROM protein_uniprot WHERE protein_name LIKE '%EC 2.7.11.1%';