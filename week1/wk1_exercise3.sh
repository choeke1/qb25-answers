grep 1_Active nhek.bed > nhek-active.bed
wc nhek-active.bed
#14013  112104  899705 nhek-active.bed
grep 12_Repressed nhek.bed > nhek-repressed.bed
wc nhek-repressed.bed
#32314  258512 1916982 nhek-repressed.bed
grep 1_Active nhlf.bed > nhlf-active.bed
wc nhlf-active.bed
#14888  119104  956585 nhlf-active.bed
grep 12_Repressed nhlf.bed > nhlf-repressed.bed
wc nhlf-repressed.bed
#34469  275752 2044657 nhlf-repressed.bed




##following are the nine commands wanted for the assignment:
#to identify if the active and repressed states are mutually exclusive I used an intersect command that 
#will show if regions in the -a file overlap at all with -b. Since the output for each of these commands is zero,
# it implies that the active and repressed are mutually exclusive
#For NHEK:
bedtools intersect -u -a nhek-active.bed -b nhek-repressed.bed | wc -l
#output: 0

#for NHLF:
bedtools intersect -u -a nhlf-active.bed -b nhlf-repressed.bed | wc -l
#output: 0


#the following command tests whether there is any overlap in the nhek-active file with nhlf active. Does not test nhlf
bedtools intersect -u -a  nhek-active.bed -b nhlf-active.bed | wc -l
#11608, There are 11608 genes that are found in both the NHEK and NHLF files.

#the following command tests whether there are genes that are unique to the -a file that are not in -b
bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed | wc -l
# 2405, There are 2405 genes that are found just in NHEK and not in NHLF


# 11608 + 2405 = 14013, yes these two ouputs add up to the total number of lines in the nhek-active.bed file
#for the third question, I had initially used -u, such that an overlapping region is only counted once, even if 
# it overlaps multiple times in the second file. Had I used a regular intersect, it would have counted these
# multiple overlaps, thus overcounting the number of overlapping lines.

#the following command returns regions from nhek that are completely within regions of nhlf, outputting the first region
bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed | head -n 1
# chr1	25558413	25559413	1_Active_Promoter	0	.	25558413	25559413


#this command does the inverse of the previous command
bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed | head -n 1
#chr1	19923013	19924213	1_Active_Promoter	0	.	19922613	19924613

#this command shows regions that match and are identical to one another
bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed | head -n 1
#chr1	1051137	1051537	1_Active_Promoter	0	.	1051137	1051537

#as the parameters for the overlap change, so do the chromatin states. In the nhek within nhlf, the chromatin state is quite active with strong enhancers
#in the nhlf in nhek, and double overlap, there are weak enhancers and promoters preceeding the active promoter. The chromatin state was not as active.
#of note, within the NHEK and NHLF samples for each command, the chromatin states are roughly the same.


bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed | head -n 1
#chr1	19922613	19924613	1_Active_Promoter	0	.	19922613	19924613

bedtools intersect -u -a nhek-active.bed -b nhlf-repressed.bed | head -n 1
#chr1	1981140	1981540	1_Active_Promoter	0	.	1981140	1981540


bedtools intersect -u -a nhek-repressed.bed -b nhlf-repressed.bed | head -n 1
#chr1	11534013	11538613	12_Repressed	0	.	115340111538613


#Active Active:
#All have an active promoter, with a strong enhancer, some have weak enhancers as well. A few have weak promoters and weak enhancers after the active promoter.

#Active Repressed:
#4/9 states had a weak enhancer followed by an active promoter. HUVEC had a poised promoter and the ressed had repressed state.

#Repressed Repressed:
#many  had atleast a weak promoter, then some combination of poised promoters, and weak enhancers. The NHLF ,K562, and HUVEC had insulators, and HepG2 had a weak_txn (whatever that is).

