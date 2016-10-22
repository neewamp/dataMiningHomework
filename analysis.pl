init();#fill in strings for promotor and sequence, tables for x0
#file_test();#check the arrays that result from the file inputs
#exon_intron_init();#make 2 arrays, one is the exons and one the introns




############### Main? ####################################






####################################################
sub exon_intron_init(){
  @exons;
  @introns;

  for(my $c = 0; $c < scalar @estart; $c = $c + 1){
    my $temp = substr($sequence, @estart[$c],@istart[$c]-@estart[$c]);
    push(@exons,$temp); #fill @exon array with strings = each exon
  }

  for(my $c = 0; $c < scalar @istart - 1; $c = $c + 1){
    my $temp = substr($sequence,@istart[$c],@estart[$c+1]-@istart[$c]);
    push(@introns,$temp);
  }

  foreach $string(@exons){
    print " exon size: "; print length($string);
  }
  print "\n";

  foreach $string(@introns){
    print " intron size: "; print length($string);
  }
  print "\n";
}
sub file_test{
  print "Sequence size:";
  print length($sequence); print " Printing sequence: $sequence";
  print "\n\n\n";
  print $promoter;
  print "\n\n\n";
  print "exon start: @estart \n";
  print "intron start: @istart \n";
}

sub init{ #fill in strings $sequence, $promoter and exon/intron table
  $seqnam = 'sequence.txt';
  $pronam = 'promoter.txt';
  $indexnam = 'index.txt';

  open($seqin, '<', $seqnam);
    $sequence = <$seqin>;
  close $seqin;

  open($promin, '<', $pronam);
    $promoter = <$promin>;
  close $promin;

  @estart;
  @istart;
  $indexnam = 'index.txt';
  open($indexin, '<', $indexnam);


    $prom_len = <$indexin>; # nab promoter length at line 1 of file
    chomp($prom_len);


    $prime = <$indexin>;  #priming read, so we can check for signal -1776
    chomp($prime);
    for($c = 0; $prime != -1776;$c = $c + 1){#fill exon array
      @estart[$c] = $prime;
      $prime = <$indexin>;
      chomp($prime);
    }

    $prime = <$indexin>;   #reset priming read for introns
    chomp($prime);
    for($c = 0; $prime != -1776;$c = $c + 1){  #fill introns
      @istart[$c] = $prime;
      $prime = <$indexin>;
      chomp($prime);
    }
  close $indexin;
}



