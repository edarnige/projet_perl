###########
#Filter CSV
#Eden Darnige
#2019/03/19
###########

#Based on:
#https://perlmaven.com/splice-csv-filter-columns


use strict;
use warnings;
use Text::CSV; #must download

#file empty spaces have been replaced with "ND"
my $csv = Text::CSV->new( { sep_char => "\t", binary => 1 } );

open my $in,  '<:encoding(utf8)', 'UniProt.tab' or die "Cannot open file";
open my $out, '>:encoding(utf8)', 'UniProt_spliced.tab' or die "Cannot create file for output";
 
while (my $row = $csv->getline($in)) {
    if (@$row[5] !~ /Arabidopsis/i && @$row[5] !~ /^Organism/){
        splice @$row;
    }
 
    my $status = $csv->combine(@$row);
    if ($status){
       print $out $csv->string(), "\n";
    }
}
 
close $in;
close $out;