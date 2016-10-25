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

print "\nExons stats: \n";
# Main($exons_only);
# print "Intron stats: \n ";
# Main($introns_only);
$len = scalar(@estart);
for(my $i = 0; $i < $len-1;$i++){
    print "\n================================ Exon ".($i+1)." ================================\n";
    print " stats: $estart[$i] \n";
    Main(substr($sequence,$estart[$i]-1,$istart[$i]-$estart[$i]));
}
print "\nIntron stats:\n";
$len = scalar(@istart);
for(my $i = 0; $i < $len-1;$i++){
    print "\n=============================== Intron ".($i+1)." ===============================\n";
    print " stats: $istart[$i] \n";
    Main(substr($sequence,$istart[$i]-1,$estart[$i+1]-$istart[$i]));
}






####################################################


