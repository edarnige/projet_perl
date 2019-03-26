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
my $csv = Text::CSV->new( { binary => 1 } );

open my $in,  '<:encoding(utf8)', 'mart_export.csv' or die "Cannot open file";
open my $out, '>:encoding(utf8)', 'mart_export_spliced.csv' or die "Cannot create file for output";
 
while (my $row = $csv->getline($in)) {

    if (@$row[3] =~ /ND/i || @$row[2] =~ /ND/i){
        splice @$row;
    }
 
    my $status = $csv->combine(@$row);
    if ($status){
       print $out $csv->string(), "\n";
    }
}
 
close $in;
close $out;








