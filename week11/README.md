# How many 100bp reads are needed to sequence a 1Mbp genome to 3x coverage?
1 Mbp x 3x coverage = 3 million base pairs
3 million base pairs/ 100 bp = 30,000 reads

# 3x Coverage 
Roughly 50,0000 positions have 0x coverage.
Both the poisson and nromal distributions fit the data reasonably well. But, the poisson esimate fits better. This makes sense as this is an independent random sampling test which are poisson processes.

# 10x Coverage
A number close to zero positions have 0x coverage.
The Poisson distribution with lambda = 10 is now fairly symmetric and well-approximated by a normal distribution with mean 10, so the normal curve fits the histogram quite well.

# 30x Coverage
At a 30x readdepth, there are even fewer positions observed expected at 0x coverage.
The distribution of the 30x is normal and the normal estimation curve and the possoin estimation look nearly identical. This is because as the number of reads required increases a poisson distribution adopts a normal shape.

# Exercise 2:
TCTTATTCATTTG

To reconstruct the entire genome, you would need to adjust the size of the k-mer accordingly, increasing the size of the sequence creates more opportunity for overlap. If the k-mer is too small, there would be abundance of branchpoints that would make interpretation incredibly hard. To overcome these challenges, the genome should be sequenced with a high degree of coverage (>=10x), or include the reverse read to confer amibiguous regions from the complimentary sequence.
