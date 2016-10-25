require 'tools.pl';
require 'task.pl';
init();#fill in strings for promotor and sequence, tables for x0
#file_test();#check the arrays that result from the file inputs
exon_intron_init();#make 2 arrays, one is the exons and one the introns



############### Main? ####################################
$exons_only = make_spliced('exon');#create string that holds sequence w/o promoter/introns
$introns_only = make_spliced('intron'); #create string that holds only the introns
print Main($promoter);
print "\n";
print "Exons stats: \n\n";
# Main($exons_only);
# print "Intron stats: \n ";
# Main($introns_only);
print "\n";
$len = scalar(@estart);
print "\n";
for(my $i = 0; $i < $len-1;$i++){
    print "Exon "; print $i+1;
    print " stats: \n$estart[$i] \n";
    Main(substr($sequence,$estart[$i],$estart[$i+1]-$estart[$i]));
}    
print "\nIntron stats:\n\n";
$len = scalar(@istart);
for(my $i = 0; $i < $len-1;$i++){
    print "Exon "; print $i+1;
    print " stats: \n$istart[$i] \n";
    Main(substr($sequence,$istart[$i],$istart[$i+1]-$istart[$i]));
}






####################################################


