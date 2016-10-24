#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

use Math::Cartesian::Product; # Required, use cpan to install this package

sub GenerateHash {
    # Take 1 arg $length, generate hash of all the posible nucleotides of this length
    return map { join("", @$_) => 0 } cartesian {1;} [ qw(A T C G) ] x $_[0];
}

sub Frequency {
    # Take 1 arg %hash, calculate the frequencies of all the entries of the hash
    my %hash = %{$_[0]};
    my $total = 0;
    $total = $total + $hash{$_} foreach (keys %hash);
    my (%result, $f);
    foreach (keys %hash) {
        if ($hash{$_}) {
            $f = $hash{$_} / $total;
            $result{$_} = $f;
            say $_.": ".sprintf("%.2f", $f * 100)."%" if ($hash{$_});
        }
    }
    return %result;
}
#Pass a sequence Maybe this is how you calculate kmers idk
sub count_Kmers {
    my ($seq, $kmerSize) = (@_);
    my @kmers;
    my $count = 0;
    for (my $i = 0; $i + $kmerSize <= length($seq); $i++) {
        #I don't know exactly what we need but here is an array of kmers of any lenght
	$count++;
	push @kmers, substr($seq, $i, $kmerSize);
    }
    return $count;
}

sub Main {
    # Take 1 arg $sequnece, perform all the taskes
    my $seq = shift;

    # Task 1. Generate hash of nucleotide;
    my %single = GenerateHash(1);
    my %double = GenerateHash(2);
    # Counting
    for (my $index = 0; $index < length($seq) - 1; $index++) {
        $single{substr($seq, $index, 1)} += 1;
        $double{substr($seq, $index, 2)} += 1;
    }
    $single{substr($seq, length($seq) - 1)} += 1;

    # Task 2. Calculate freuqnencies
    say "Frequencies of single nucleotide:";
    my %singleF = Frequency(\%single);
    say "Frequencies of dinucleotide:";
    my %doubleF = Frequency(\%double);

    # Task 3. Calculate fxy/fx/fy
    say "";
    say "Calculating dinucleotide odds ratio";
    foreach (keys %double) {
        if ($double{$_}) {
            say $_.": ".sprintf("%.2f", $doubleF{$_} / $singleF{substr($_, 0, 1)} / $singleF{substr($_, 1, 1)}); }
    }

    # Task 4. Promoter detection
    # TODO: get a list of promoter in re form, apply search

    # Task 5. CTCF binding motif detection
    say "";
    if (($seq =~ /CCGCG.GG.GGCAG/) or ($seq =~ /CTGCC.CC.CGCGG/)) { # Also need to consider the other strand
        say "This region contains the CTCF binding motif"
    }
    else { say "No CTCF binding motif detected in this region" }

    # Task 6. Count 5-mer
    print "Number of 5mers: ";
    print count_Kmers($seq,5). "\n";


    
    # TODO: Due Th
}


# TODO: Use Main for each region
Main("ATATGCG") # An example.

