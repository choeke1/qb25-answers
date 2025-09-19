bedtools intersect -a hg19-kc.bed -b snps-chr1.bed -c | sort -k5,5nr | head -1
#chr1	245912648	246670581	ENST00000490107.6_7	5445

#Systematic name: ENST00000490107.6_7
#Human Readable Name: SMYD3
#Position: hg19 chr1: 245912648-246670581
#size: 757,934 bp
#exon count: 12


bedtools sample -n 20 -seed 42 -i snps-chr1.bed > snps-subset.bed
bedtools sort -i snps-subset.bed > snps-subset.sorted.bed
bedtools sort -i hg19-kc.bed > hg19-kc.sorted.bed
bedtools closest -a snps-subset.sorted.bed -b hg19-kc.sorted.bed -d -t first > closest_results.bed
#to count the number of genes with SNPs inside:
bedtools intersect -a snps-subset.sorted.bed -b hg19-kc.sorted.bed -u | wc -l
# there were 15 genes with SNPs inside 

#Determining the distance: 
awk '$NF>0 {print $NF}' closest_results.bed | sort -n | sed -n '1p;$p'
#Min Distance: 1664
#Max Distance: 22944
