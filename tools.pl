sub freq(2){# intended paramters: freq(string string, string target)
  my $relative_freq;
  

return $relative_freq;
}
###################################################################################
sub make_spliced(1){
  my $spliced;
  if(@_[0] eq 'exon'){
    #print " in make exons";
    foreach $exon(@exons){
      #print $exon;
      $spliced = $spliced . $exon;
    }#exon for
  }#exon if
  elsif(@_[0] eq 'intron'){
    #print "in make introns";
    foreach $intron(@introns){
      #print $intron;
      $spliced = $spliced . $intron;
    }#intron for
  }#elsif
  else {
    print "Subroutine make_spliced passed bad input. \"exon\" for exonstring,";
    print " \"intron\" for intron string. You passed: ";
    print @_[0];
  }
return $spliced;
}#sub routine

#################################################################################
sub exon_intron_init(){#creates the arrays of strings for introns and exons
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

  # foreach $string(@exons){
  #  print " exon size: "; print length($string);
  # }
  # print "\n\n";

  # foreach $string(@introns){
  #  print " intron size: "; print length($string);
  # }
  # print "\n\n";
}
#################################################################################
sub file_test{#some testing prints for array/string integrity
  print "Sequence size:";
  print length($sequence); print " Printing sequence: $sequence";
  print "\n\n\n";
  print $promoter;
  print "\n\n\n";
  print "exon start: @estart \n";
  print "intron start: @istart \n";
}
#################################################################################
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

  print "@estart";
}



