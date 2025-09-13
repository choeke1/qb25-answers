wget https://hgdownload.soe.ucsc.edu/goldenPath/hg16/bigZips/hg16.chrom.sizes
grep -v _ hg16.chrom.sizes > hg16-main.chrom.sizes
bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed
mv ~/Downloads/hg16-kc.tsv .
cut -f1-3,5 hg16-kc.tsv > hg16_kc.bed
bedtools intersect -c -a hg16-1mb.bed -b hg16_kc.bed > hg-16_kc-count.bed


wc -l hg19-kc-count.bed
#3114 hg19-kc-count.bed

cmdb@QuantBio-15 week1 % bedtools intersect -v -a hg19-kc-count.bed -b hg-16_kc.bed | wc
#36     144     969
#The difference that accounts for genes seen in hg19 and not hg16 could be do to annotation changes, or even sequence additions to the assembly



wc -l hg-16_kc.bed
#3085 hg-16_kc.bed

cmdb@QuantBio-15 week1 % bedtools intersect -v -a hg-16_kc.bed -b hg19-kc-count.bed | wc
#7      28     173 
#interestingly only 7 genes in hg16 are not seen in hg19. Overall, they are different assemblies, so differences in gene presence is expected. 
# But, because hg16 is an earlier version, one would expect all of its annotations to be the same. This is likely due to annotation changes or updates to
# the hg16 assembly, merging of genes, positional changes on the chromosomes.