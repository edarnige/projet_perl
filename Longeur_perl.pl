###########
#Length via Perl
#Eden Darnige
#2019/03/29
###########


use strict;
use warnings;
use diagnostics;
use Text::CSV;

#Open CSV
my $csv = Text::CSV->new( { sep_char => "\t", binary => 1 } );
open my $in,  '<:encoding(utf8)', 'UniProt_spliced.tab' or die "Cannot open file";

#Get length
print "Enter length threshold:\n";
my $length=<STDIN>;

#Check condition and print
while (my $row = $csv->getline($in)) {
    if (@$row[6] =~ /([0-9]+)/){      #isolate length 
        if ($1 >= $length){           #check if length is greater than entered threshold
            print @$row[3],":\tlength: ",@$row[6],"\n"; #display protein names and length
        }
    }
}


close $in;
