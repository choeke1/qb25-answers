
#Exercise 1
bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam
samtools sort -o A01_01.bam A01_01.sam
samtools index A01_01.bam
idxstats A01_01.bam > A01_01.idxstats


#Exercise 2
The alignment of the different variants against the reference genome had a relatively consistent pattern. However A01_01, A01_03, and A01_04 had no reads/matches between ~20kb - 27 kb and many more mismatchesd (represented by colored lines), suggesting the sequencing wasn't as efficient. A01_02, A01_05, and A01_06 had far fewer mismatches, but still had roughly 3 - 10 mismatches per 1 kb. The sequencing efficiency was much stronger in these variants.

#Exercise 5
hisat2 -p 4 -x ../genomes/sacCer3 -U ../rawdata/SRR10143769.fastq -S rna.sam
2917686 reads; of these:
  2917686 (100.00%) were unpaired; of these:
    296807 (10.17%) aligned 0 times
    2245812 (76.97%) aligned exactly 1 time
    375067 (12.85%) aligned >1 times
89.83% overall alignment rate

Generally the sequencing reads are accumulated at the end of the gene. For example, REF2, Cab5, VPS64, and RAV2 have high coverage all in the final few hundered basepairs of their coding region. For smaller genes, like SPC19, there is coverage across the whole gene. Albeit weak to moderate in the beginning portions, coverage increases towards the end of the transcriptR

