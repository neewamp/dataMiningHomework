# dataMiningHomework
Group repo for a Data Mining Project.

10/22/16 1:00 AM-----------------------------------------------------------------------------
index.txt -> contains starting positions for all the introns and exons
  for pttg1ip. Logic for constructing exon strings:
   exon 1= substr (sequence,exon start[1],intron start[1] - exon start[1])
     sequence here is without the promoter

   logic for intron strings:
   intron 1 = substr (sequence,intron start[1],exon start[1+1]-intron start[1])
   note that istart[]'s last item is symbolic of the end of the gene. I have constructed it
   in such a way so that it is the ending point for the last exon, so when I loop over
   the @istart array,I always do size(@istart) - 1, so it doesn't muck up other logic

   I wanted to get a starting point done as soon as possible, so I am pushing input files
     and input logics. If you guys don't like it (maybe we want to use a different "version" 
     of the gene, mine is from FASTA iirc), or you guys want to do your logic for how we
     get strings for each intron and exon that's fine. I'm pushing this is a starting point.
-Matt
---------------------------------------------------------------------------------------------
************************
We still need a flow chart and psudocode.


******************
curl -L http://cpanmin.us | perl - --sudo Math::Cartesian::Product
To install the library I don't like cpan.

---------------------------------------------------------------------------------------------
Some updates:
I'm working on core promoter motifs detection
I'm thinking that we can just hard code single and di- nucleotide so that we don't need Math::Cartesian::Product. What do you guys think?
-Yadi
Sorry guys, it was supposed that a list of activities was going to be created so each one could choose a couple of tasks. What items from the homework are not done yet?
-Isaac