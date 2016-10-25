#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

use Math::Cartesian::Product;

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
            say $_.": ".sprintf("%.2f", $f * 100)."%";
        }
    }
    return %result;
}

sub CountKmers {
    # Take 2 args $seq, $kmerSize, return hash of kmers as key, their occurrences as value
    my ($seq, $kmerSize) = (@_);
    my %kmers;
    for (my $i = 0; $i + $kmerSize <= length($seq); $i++) {
        $kmers{substr($seq, $i, $kmerSize)} += 1;
    }
    return %kmers;
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
    say "**** Frequencies of single nucleotide:";
    my %singleF = Frequency(\%single);
    say "**** Frequencies of dinucleotide:";
    my %doubleF = Frequency(\%double);

    # Task 3. Calculate fxy/fx/fy
    say "**** Dinucleotide odds ratio:";
    foreach (keys %double) {
        if ($double{$_}) {
            say $_.": ".sprintf("%.2f", $doubleF{$_} / $singleF{substr($_, 0, 1)} / $singleF{substr($_, 1, 1)}); }
    }

    # Task 4. Core promoter motifs detection
    say "**** Detecting core promoter motifs:";
    if ($seq =~ /TATA[AT]AA[GA]/) {say "TATA Box is detected on sense strand"}
    elsif ($seq =~ /[CT]TT[AT]TATA/) {say "TATA Box is detected on antisense strand"}
    if ($seq =~ /TCA[GT]T[CT]/) {say "Inr (Drosophila) is detected on sense strand"}
    elsif ($seq =~ /[GA]A[AC]TGA/) {say "Inr (Drosophila) is detected on antisense strand"}
    if ($seq =~ /[CT][CT]A[ACGT][AT][CT][CT]/) {say "Inr (Human) is detected on sense strand"}
    elsif ($seq =~ /[GA][GA][AT][ACGT]T[GA][GA]/) {say "Inr (Human) is detected on antisense strand"}
    if ($seq =~ /C[GC]A[GA]C[GC][GC]AAC/) {say "MTE (Drosophila) is detected on sense strand"}
    elsif ($seq =~ /GTT[GC][GC]G[CT]T[GC]G/) {say "MTE (Drosophila) is detected on antisense strand"}
    if ($seq =~ /[GA]G[AT][CT][^T]T/) {say "DPE (Drosophila) is detected on sense strand"}
    elsif ($seq =~ /A[^A][GA][AT]C[CT]/) {say "DPE (Drosophila) is detected on antisense strand"}
    if ($seq =~ /[GC][GC][GA]CGCC/) {say "BRE^u is detected on sense strand"}
    elsif ($seq =~ /GGCG[CT][GC][GC]/) {say "BRE^u is detected on antisense strand"}
    if ($seq =~ /[GA]T[^C][GT][GT][GT][GT]/) {say "BRE^d is detected on sense strand"}
    elsif ($seq =~ /[AC][AC][AC][AC][^G]A[CT]/) {say "BRE^d is detected on antisense strand"}
    if ($seq =~ /[^C][GC]G[CT]GG[GA]A[GC][AC]/) {say "XCPE1 (Human) is detected on sense strand"}
    elsif ($seq =~ /[GT][GC]T[CT]CC[GA]C[GC][^G]/) {say "XCPE1 (Human) is detected on antisense strand"}
    if ($seq =~ /CTTC.{1,11}CTGT.{5,14}AGC/) {say "DCE is detected on sense strand"}
    elsif ($seq =~ /GCT.{5,14}ACAG.{1,11}GAAG/) {say "DCE is detected on antisense strand"}

    # Task 5. CTCF binding motif detection
    say "**** Detecting CTCF binding motif:";
    if ($seq =~ /CCGCG.GG.GGCAG/) {say "CTCF binding motif is detected on sense strand"}
    elsif ($seq =~ /CTGCC.CC.CGCGG/) {say "CTCF binding motif is detected on antisense strand"}
    else { say "No CTCF binding motif detected in this region" }

    # Task 6. Count 5-mer
    say "**** Counting 5-mers. Result not shown (too many entries...)";
    my %fiveMer = CountKmers($seq, 5);
    my $totalCount = keys(%fiveMer);
    say "Unique fiveMer count: $totalCount";
}


# TODO: Use Main for each region
Main("ATATGCG") # An example.

