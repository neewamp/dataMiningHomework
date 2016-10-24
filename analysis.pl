do 'tools.pl';
do 'task.pl';
init();#fill in strings for promotor and sequence, tables for x0
#file_test();#check the arrays that result from the file inputs
exon_intron_init();#make 2 arrays, one is the exons and one the introns



############### Main? ####################################
$exons_only = make_spliced('exon');#create string that holds sequence w/o promoter/introns
$introns_only = make_spliced('intron'); #create string that holds only the introns

print "Exons stats: \n";
Main($exons_only);
print "Intron stats: \n ";
Main($introns_only);

####################################################


