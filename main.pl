use strict;
use warnings;
use diagnostics;


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

while ($choice != 0){
    display_menu();
    print "Enter your choice: ";
    $choice= <STDIN>;
    chomp($choice);

    if ($choice == 0){
        print "Goodbye\n";
        exit 42;
    }elsif($choice == 1){

    }elsif($choice == 2){

    }elsif($choice == 3){

    }elsif($choice == 4){

    }elsif($choice == 5){

    }elsif($choice == 6){

    }else{
        print "Please enter a valid choice\n";
    }

}
